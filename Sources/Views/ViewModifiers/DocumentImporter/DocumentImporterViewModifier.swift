//
//  DocumentImporterViewModifier.swift
//  Read2Me
//
//  Created by Ronny Vega on 10/01/26.
//

import SwiftUI
import UniformTypeIdentifiers

public struct DocumentImporterViewModifier: ViewModifier {
    @ObservedObject var coordinator: DocumentImportCoordinator
    var allowedContentTypes: [UTType]

    public init(
        coordinator: DocumentImportCoordinator,
        allowedContentTypes: [UTType] = [.pdf]
    ) {
        self.coordinator = coordinator
        self.allowedContentTypes = allowedContentTypes
    }

    public func body(content: Content) -> some View {
        content
            .myFileImporter(
                isPresented: $coordinator.isPresented,
                allowedContentTypes: allowedContentTypes
            ) { result in
                Task { @MainActor in
                    await coordinator.handlePickerResult(result)
                }
            }
            .overlay {
                if coordinator.isImporting {
                    Color.black.opacity(0.12)
                        .ignoresSafeArea()
                        .overlay(
                            ProgressView()
                                .progressViewStyle(.circular)
                        )
                }
            }
    }
}

public extension View {
    func documentImporter(
        coordinator: DocumentImportCoordinator,
        allowedContentTypes: [UTType] = [.pdf]
    ) -> some View {
        modifier(DocumentImporterViewModifier(coordinator: coordinator, allowedContentTypes: allowedContentTypes))
    }
}
