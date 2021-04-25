//
//  Settings.swift
//  Audi
//
//  Created by EVGENII DUKA on 18.04.2021.
//

import Foundation
import CoreLocation

class Settings {
    
    static var main = Settings()
    
    private let keychain = Keychain()
    
    var originAddress: Address? {
        set {
            if let newValue = newValue {
                let data = NSKeyedArchiver.archivedData(withRootObject: newValue)
                keychain.set(data, forKey: Keys.Settings.OriginAddressKey.rawValue)
            } else {
                keychain.delete(Keys.Settings.OriginAddressKey.rawValue)
            }
        }
        get{
            guard let data = keychain.getData(Keys.Settings.OriginAddressKey.rawValue) else { return nil }
            guard let address = NSKeyedUnarchiver.unarchiveObject(with: data) as? Address else { return nil }
            return address
        }
    }
    
    var destinationAddress: Address? {
        set {
            if let newValue = newValue {
                let data = NSKeyedArchiver.archivedData(withRootObject: newValue)
                keychain.set(data, forKey: Keys.Settings.DestinationAddressKey.rawValue)
            } else {
                keychain.delete(Keys.Settings.DestinationAddressKey.rawValue)
            }
        }
        get{
            guard let data = keychain.getData(Keys.Settings.DestinationAddressKey.rawValue) else { return nil }
            guard let address = NSKeyedUnarchiver.unarchiveObject(with: data) as? Address else { return nil }
            return address
        }
    }
    
}


fileprivate class Keychain {
    func set(_ value: Bool, forKey: String) {
        UserDefaults.standard.set(value, forKey: forKey)
    }
    func set(_ value: Data, forKey: String) {
        UserDefaults.standard.set(value, forKey: forKey)
    }
    func set(_ value: String, forKey: String) {
        UserDefaults.standard.setValue(value, forKey: forKey)
    }
    func getData(_ key: String) -> Data? {
        return UserDefaults.standard.value(forKey: key) as? Data
    }
    func get(_ key: String) -> String? {
        return UserDefaults.standard.value(forKey: key) as? String
    }
    func getBool(_ key: String) -> Bool? {
        return UserDefaults.standard.value(forKey: key) as? Bool
    }
    func delete(_ key: String) {
        UserDefaults.standard.set(nil, forKey: key)
    }
}
