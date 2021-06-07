
import Storage


class LogStub : Logger {
    func write(_ action: Int64 , id: Int64) -> Bool {
        print("Here with \(action), and id \(id)")
        return true
    }
}

let logger = LogStub()
if let s = Storage.create(logger) {
    let h = Data(id: 1, value: "Hello")
    let w = Data(id: 2, value: "World")
    if s.add(h) == false {
        fatalError("Can't add first element")
    }
    if s.add(h) == true {
        fatalError("Can add first element twice")
    }
    if s.add(w) == false {
        fatalError("Can't add second element")
    }
} else {
    fatalError("Can't create CppStorage")
}

print ("All done")
