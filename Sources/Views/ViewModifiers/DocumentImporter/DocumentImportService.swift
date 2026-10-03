//
//  DocumentImportService.swift
//  Read2Me
//
//  Created by Ronny Vega on 10/01/26.
//

import Foundation

@MainActor
public protocol DocumentImportService: AnyObject {
    func importDocument(from url: URL) async throws
}
