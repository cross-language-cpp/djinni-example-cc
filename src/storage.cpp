
#include <iostream>

#include "cpplib/djinni/cpp/Action.hpp"
#include "cpplib/djinni/cpp/Data.hpp"
#include "cpplib/djinni/cpp/Logger.hpp"
#include "cpplib/djinni/cpp/Storage.hpp"

#include <cassert>
#include <limits>
#include <optional>
#include <set>
namespace cpplib {

class Storage : public djinni::Storage {
  using data_set = std::set<djinni::Data,
                            bool (*)(const djinni::Data&, const djinni::Data&)>;

  data_set store{
      [](const djinni::Data& a, const djinni::Data& b) { return a.id < b.id; }};


  std::shared_ptr<djinni::Logger> logger;

 public:
  Storage(std::shared_ptr<djinni::Logger> l):logger{l}{}

  ~Storage() = default;

  std::optional<djinni::Data> get(int64_t id) const override {
    auto find_iter = store.find(djinni::Data{id, ""});
    if (find_iter != store.end()) {
      return *find_iter;
    }
    return {};
  }

  bool add(const djinni::Data& data) override {
    auto insert_info = store.insert(data);
    if(insert_info.second)
      logger->write((int) djinni::Action::INSERT, insert_info.first->id);
    return insert_info.second;
  }

  bool remove(int64_t id) override {
      logger->write((int) djinni::Action::REMOVE, id);
      return store.erase(djinni::Data{id,""}) == 1;
  }

  int64_t size() const override {
    assert(store.size() <
           static_cast<std::size_t>(std::numeric_limits<int64_t>::max()));

    return static_cast<int64_t>(store.size());
  }
};
}  // namespace cpplib

namespace cpplib::djinni {

std::shared_ptr<Storage> Storage::create(const std::shared_ptr<Logger> & logger) {
  return std::make_shared<cpplib::Storage>(logger);
}
}  // namespace cpplib::djinni
