
import Storage

if let s = CppStorage.create() {
    let h = CppData(id: 1, value: "Hello")
    let w = CppData(id: 2, value: "World")
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
