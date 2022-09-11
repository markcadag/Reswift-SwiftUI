//
//  ReswiftTodoTests.swift
//  ReswiftTodoTests
//
//  Created by iOS Developer on 9/10/22.
//

import XCTest
@testable import ReswiftTodo

import Quick
import Nimble

class FileUtilManagerTest: QuickSpec {
    override func spec() {
        let fileManagerUtil = FileManagerUtil<Note>(fileName: "data.json")
        describe("The 'FileManagerUtil' class for handling offline data") {
            context("Can manage object") {
                it("can save object") {
                    _ = fileManagerUtil.deleteAll()
                    let timestamp = Date().currentTimeMillis()
                    let note = Note(time_stamp: timestamp, text: "A sample note")
                    expect(fileManagerUtil.saveObject(item: note)).to(beTruthy())
                    
                    let users = fileManagerUtil.loadObjects()
                    expect(users.count).to(equal(1))
                }
            }
        }
  }
}
