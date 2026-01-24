//
//  LocalKeyValueStorage.swift
//  SwiftyFoundation
//

import Foundation

@MainActor
public protocol LocalKeyValueStorage {
    func set<T>(value: T, forKey: String) where T: Codable
    func get<T>(forKey: String) -> T? where T: Codable
    func remove(forKey: String)
}

public final class LocalKeyValueStorageMock: LocalKeyValueStorage {
    public func set<T>(value _: T, forKey _: String) where T: Codable {}
    public func get<T>(forKey _: String) -> T? where T: Codable { nil }
    public func remove(forKey _: String) {}

    public init() {}
}
