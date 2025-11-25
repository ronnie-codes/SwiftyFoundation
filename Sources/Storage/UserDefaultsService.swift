//
//  UserDefaultsService.swift
//  NiceTube
//

import Foundation

public final class UserDefaultsService: LocalStorageService {
    private let defaults: UserDefaults
    private let encoder: JSONEncoder
    private let decoder: JSONDecoder

    public init(defaults: UserDefaults = .standard, encoder: JSONEncoder = JSONEncoder(), decoder: JSONDecoder = JSONDecoder()) {
        self.defaults = defaults
        self.encoder = encoder
        self.decoder = decoder
    }

    public func set<T>(value: T, forKey: String) where T: Codable {
        if let data = try? encoder.encode(value) {
            defaults.set(data, forKey: forKey)
        }
    }

    public func get<T>(forKey: String) -> T? where T: Codable {
        if let data = defaults.data(forKey: forKey), let value = try? decoder.decode(T.self, from: data) {
            return value
        }
        return nil
    }

    public func remove(forKey: String) {
        defaults.removeObject(forKey: forKey)
    }
}
