//
//  LocalDocumentStorage.swift
//  SwiftyFoundation
//
//  Created by Ronny Vega on 1/3/26.
//

import Foundation

public protocol LocalDocumentStorage {
    func directory(named name: String, createIfNeeded: Bool) throws -> URL

    @discardableResult
    func ensureDirectoryExists(at url: URL) throws -> URL

    @discardableResult
    func saveFile(from sourceURL: URL, toDirectory directory: URL, named fileName: String?, overwrite: Bool) throws -> URL

    func listFiles(in directory: URL, allowedExtensions: [String]?) throws -> [URL]

    func deleteFile(at url: URL) throws

    @discardableResult
    func moveFile(from sourceURL: URL, to destinationURL: URL, overwrite: Bool) throws -> URL
}

// MARK: - Defaulted Convenience Overloads

public extension LocalDocumentStorage {
    // directory(named:createIfNeeded:) defaulting to true
    func directory(named name: String) throws -> URL {
        try directory(named: name, createIfNeeded: true)
    }

    // saveFile(from:toDirectory:named:overwrite:) defaults: named = nil, overwrite = true
    @discardableResult
    func saveFile(from sourceURL: URL, toDirectory directory: URL) throws -> URL {
        try saveFile(from: sourceURL, toDirectory: directory, named: nil, overwrite: true)
    }

    @discardableResult
    func saveFile(from sourceURL: URL, toDirectory directory: URL, named fileName: String?) throws -> URL {
        try saveFile(from: sourceURL, toDirectory: directory, named: fileName, overwrite: true)
    }

    // listFiles(in:allowedExtensions:) defaulting to nil
    func listFiles(in directory: URL) throws -> [URL] {
        try listFiles(in: directory, allowedExtensions: nil)
    }

    // moveFile(from:to:overwrite:) defaulting to true
    @discardableResult
    func moveFile(from sourceURL: URL, to destinationURL: URL) throws -> URL {
        try moveFile(from: sourceURL, to: destinationURL, overwrite: true)
    }
}
