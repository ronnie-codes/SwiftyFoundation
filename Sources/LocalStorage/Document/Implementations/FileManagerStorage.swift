//
//  FileManagerStorage.swift
//  SwiftyFoundation
//
//  Created by Ronny Vega on 1/3/26.
//

import Foundation

final class FileManagerStorage: LocalDocumentStorage {
    static let shared = FileManagerStorage()

    private let fileManager: FileManager
    private let documentsDirectory: URL

    public init(fileManager: FileManager = .default) {
        self.fileManager = fileManager
        self.documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }

    // MARK: - Common Directories

    /// Returns (and ensures) a subdirectory under Documents.
    public func directory(named name: String, createIfNeeded: Bool = true) throws -> URL {
        let dir = documentsDirectory.appendingPathComponent(name, isDirectory: true)
        if createIfNeeded {
            try ensureDirectoryExists(at: dir)
        }
        return dir
    }

    // MARK: - Directory Management

    @discardableResult
    public func ensureDirectoryExists(at url: URL) throws -> URL {
        var isDir: ObjCBool = false
        if !fileManager.fileExists(atPath: url.path, isDirectory: &isDir) || !isDir.boolValue {
            try fileManager.createDirectory(at: url, withIntermediateDirectories: true)
        }
        return url
    }

    // MARK: - File Operations

    /// Saves (copies) a file from a source URL into a destination directory with an optional new name.
    /// Returns the destination URL.
    @discardableResult
    public func saveFile(
        from sourceURL: URL,
        toDirectory directory: URL,
        named fileName: String? = nil,
        overwrite: Bool = true
    ) throws -> URL {
        let accessGranted = sourceURL.startAccessingSecurityScopedResource()
        defer {
            if accessGranted {
                sourceURL.stopAccessingSecurityScopedResource()
            }
        }

        guard sourceURL.isFileURL else {
            throw CocoaError(.fileReadInvalidFileName)
        }

        try ensureDirectoryExists(at: directory)

        let destinationURL: URL
        if let fileName {
            destinationURL = directory.appendingPathComponent(fileName, isDirectory: false)
        } else {
            destinationURL = directory.appendingPathComponent(sourceURL.lastPathComponent, isDirectory: false)
        }

        if overwrite, fileManager.fileExists(atPath: destinationURL.path) {
            try fileManager.removeItem(at: destinationURL)
        }

        try fileManager.copyItem(at: sourceURL, to: destinationURL)
        return destinationURL
    }

    /// Lists files in a directory, optionally filtering by allowed extensions (case-insensitive, without dots).
    public func listFiles(in directory: URL, allowedExtensions: [String]? = nil) throws -> [URL] {
        guard fileManager.fileExists(atPath: directory.path) else { return [] }
        let files = try fileManager.contentsOfDirectory(at: directory, includingPropertiesForKeys: nil)

        guard let allowedExtensions, !allowedExtensions.isEmpty else {
            return files
        }

        let lowered = Set(allowedExtensions.map { $0.lowercased() })
        return files.filter { lowered.contains($0.pathExtension.lowercased()) }
    }

    /// Deletes the file at the given URL if it exists.
    public func deleteFile(at url: URL) throws {
        if fileManager.fileExists(atPath: url.path) {
            try fileManager.removeItem(at: url)
        }
    }

    /// Moves a file to a destination URL, optionally overwriting.
    @discardableResult
    public func moveFile(from sourceURL: URL, to destinationURL: URL, overwrite: Bool = true) throws -> URL {
        try ensureDirectoryExists(at: destinationURL.deletingLastPathComponent())

        if overwrite, fileManager.fileExists(atPath: destinationURL.path) {
            try fileManager.removeItem(at: destinationURL)
        }

        try fileManager.moveItem(at: sourceURL, to: destinationURL)
        return destinationURL
    }
}
