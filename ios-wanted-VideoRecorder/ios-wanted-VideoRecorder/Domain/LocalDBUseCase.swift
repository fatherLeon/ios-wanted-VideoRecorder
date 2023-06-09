//
//  RealmManager.swift
//  ios-wanted-VideoRecorder
//
//  Created by 강민수 on 2023/06/06.
//

import RealmSwift
import Foundation

struct LocalDBUseCase<T: Object>: DBUseCase {
    private var realm: Realm? {
        return try? Realm()
    }
    
    func create(_ object: T) {
        try? realm?.write {
            realm?.add(object)
        }
    }
    
    func read() -> [T]? {
        guard let objects = realm?.objects(T.self) else { return nil }
        
        return Array(objects)
    }
    
    func update(_ object: T) {
        try? realm?.write {
            realm?.add(object, update: .modified)
        }
    }
    
    func delete(_ id: UUID) {
        guard let object = realm?.object(ofType: T.self, forPrimaryKey: id) else { return }
        try? realm?.write {
            realm?.delete(object)
        }
    }
}