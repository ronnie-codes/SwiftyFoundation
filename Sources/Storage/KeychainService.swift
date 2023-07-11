//
//  KeychainService.swift
//  NiceTube
//

import Foundation
import KeychainAccess

public final class KeychainService: LocalStorageService {
    private let keychain: Keychain
    private let encoder: JSONEncoder
    private let decoder: JSONDecoder

    public init(service: String, encoder: JSONEncoder = JSONEncoder(), decoder: JSONDecoder = JSONDecoder()) {
        keychain = Keychain(service: service)
        self.encoder = encoder
        self.decoder = decoder
    }

    public init(service: String, group: String, encoder: JSONEncoder = JSONEncoder(), decoder: JSONDecoder = JSONDecoder()) {
        keychain = Keychain(service: service, accessGroup: group)
        self.encoder = encoder
        self.decoder = decoder
    }

    public func set<T>(value: T, forKey: String) where T: Codable {
        if let data = try? encoder.encode(value) {
            keychain[data: forKey] = data
        }
    }

    public func get<T>(forKey: String) -> T? where T: Codable {
        if let data = keychain[data: forKey], let value = try? decoder.decode(T.self, from: data) {
            return value
        }
        return nil
    }

    public func remove(forKey: String) {
        keychain[forKey] = nil
    }
}
