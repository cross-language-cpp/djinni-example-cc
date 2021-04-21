#define DOCTEST_CONFIG_IMPLEMENT_WITH_MAIN
#include <doctest/doctest.h>

#include "cpplib/djinni/cpp/Data.hpp"
#include "cpplib/djinni/cpp/Storage.hpp"

SCENARIO("Using djinni storage from cpp") {
  auto store = cpplib::djinni::Storage::create();
  REQUIRE(store != nullptr);

  GIVEN("an empty storage instance and a Data element") {
    using Data = cpplib::djinni::Data;
    CHECK_EQ(store->size(), 0);

    WHEN("adding a element to the empty storage") {
      Data d{1, "Hello"};
      auto add_succeeded = store->add(d);
      THEN("the add operation succeeded") {
        REQUIRE(add_succeeded);
        CHECK_EQ(store->size(), 1);
      }
      AND_THEN("the same element can not be added again") {
        REQUIRE_FALSE(store->add(d));
        CHECK_EQ(store->size(), 1);
      }
      AND_THEN("a different element can be added") {
        REQUIRE(store->add(Data{2, "World"}));
        CHECK_EQ(store->size(), 2);
      }
      AND_THEN("the element can be removed once") {
        REQUIRE(store->remove(1));
        CHECK_EQ(store->size(), 0);
        REQUIRE_FALSE(store->remove(1));
      }
    }
  }
}
