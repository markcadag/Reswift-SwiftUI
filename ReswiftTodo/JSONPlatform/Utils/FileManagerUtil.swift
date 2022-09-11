//
//  FileManagerUtil.swift
//  ReswiftTodo
//
//  Created by iOS Developer on 9/10/22.
//

import Foundation

protocol FileManagerImpl {
    func save(jsonObject: Any, toFilename filename: String) throws ->  Bool
    func loadJSON(withFilename filename: String) throws -> Any?
}

class FileManagerUtil<T> where T: Encodable, T: Decodable {
    
    private var fileName: String
    
    private lazy var fileURL: URL = {
        try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
               .appendingPathComponent(fileName)
    }()
    
    init(fileName: String) {
        self.fileName = fileName
    }
    
    func saveObject(item: T) -> Bool {
        var objects = loadObjects()
        objects.append(item)
        return saveObjects(item: objects)
    }
    
    func deleteItemAt(index: Int) -> Bool {
        var objects = loadObjects()
        objects.remove(at: index)
        return saveObjects(item: objects)
    }
    
    func loadObjects() -> [T] {
        do {
            let data = try Data(contentsOf: fileURL)
            let decoder = JSONDecoder()
            let items = try decoder.decode([T].self, from: data)
            return items
        } catch {
            return []
        }
    }
    
    func deleteAll() -> Bool {
        do {
            if !FileManager.default.fileExists(atPath: fileURL.path) {
                return false
            }
            do {
                try FileManager.default.removeItem(atPath: fileURL.path)
                return true
            } catch {
                return false
            }
        }
    }
    
    private func saveObjects(item: [T]) -> Bool {
        do {
            let encoder = JSONEncoder()
            try encoder.encode(item).write(to: fileURL)
            return true
        } catch {
            return false
        }
    }
    
}
