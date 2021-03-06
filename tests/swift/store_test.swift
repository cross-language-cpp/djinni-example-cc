import XCTest
import Storage

class StorageTests: XCTestCase {

    let s = CppStorage.create()
    let h = CppData(id: 1, value: "Hello")
    let w = CppData(id: 2, value: "World")

    func testAddElemet() {
        XCTAssert(s != nil)
        XCTAssert(s!.add(h))
        XCTAssert(s!.add(w))
    }

    func testAddElementTwice() {
        XCTAssert(s != nil)
        XCTAssert(s!.add(h))
        XCTAssert(!s!.add(h))
    }

}
