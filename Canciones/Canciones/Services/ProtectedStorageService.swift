//
//  ProtectedStorageService.swift
//  Canciones
//
//  Created by A S on 22.08.2022.
//

import Foundation

//TODO: Rework to keychain and get rid of singleton
final class ProtectedStorageService {
    static let shared = ProtectedStorageService()
    
    private init() {}
    
    func save(_ value: Any, forKey key: String) {
        UserDefaults.standard.set(value, forKey: key)
    }
    
    func getValue<T>(forKey key: String) -> T? {
        UserDefaults.standard.value(forKey: key) as? T
    }
    
    func removeValueForKey(_ key: String) {
        UserDefaults.standard.removeObject(forKey: key)
    }
    
    func getData<T: Decodable>(forKey key: String) -> T? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        guard let data = UserDefaults.standard.data(forKey: key) else { return nil }
        
        
        return try? decoder.decode(T.self, from: data)
    }
}
