//
//  DocumentImportCoordinator.swift
//  Read2Me
//
//  Created by Ronny Vega on 10/01/26.
//

import Foundation
import Combine

@MainActor
public final class DocumentImportCoordinator: ObservableObject {
    @Published public var isPresented: Bool = false
    @Published public var isImporting: Bool = false

    private let importService: DocumentImportService
    public var onSuccess: ((URL) -> Void)?
    public var onError: ((Error) -> Void)?

    public init(
        importService: DocumentImportService,
        onSuccess: ((URL) -> Void)? = nil,
        onError: ((Error) -> Void)? = nil
    ) {
        self.importService = importService
        self.onSuccess = onSuccess
        self.onError = onError
    }

    public func openFilePicker() {
        isPresented = true
    }

    public func handlePickerResult(_ result: Result<URL, Error>) async {
        isPresented = false

        switch result {
        case .success(let url):
            isImporting = true
            do {
                try await importService.importDocument(from: url)
                isImporting = false
                onSuccess?(url)
            } catch {
                isImporting = false
                onError?(error)
            }
        case .failure(let error):
            // Ignore when user cancels the system file picker dialog
            guard (error as? CocoaError)?.code != .userCancelled else { return }
            onError?(error)
        }
    }
}
