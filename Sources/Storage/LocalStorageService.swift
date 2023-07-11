//
//  KeychainService.swift
//  NiceTube
//

import Foundation

public protocol LocalStorageService {
    func set<T>(value: T, forKey: String) where T: Codable
    func get<T>(forKey: String) -> T? where T: Codable
    func remove(forKey: String)
}

public final class LocalStorageServiceMock: LocalStorageService {
    public func set<T>(value _: T, forKey _: String) where T: Codable {}
    public func get<T>(forKey _: String) -> T? where T: Codable { nil }
    public func remove(forKey _: String) {}

    public init() {}
}
