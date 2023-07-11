//
//  VisionService.swift
//  NiceTube
//

import CoreImage
import Foundation
import Vision

public protocol VisionService {
    func getWords(from image: CIImage) async throws -> [String]
    func getWords(from imageUrl: URL) async throws -> [String]
    func getWords(from imageUrls: [URL]) async throws -> [String]
}

public final class VisionServiceApple: VisionService {
    private let topCandidates = 1

    public init() {}

    public func getWords(from image: CIImage) async throws -> [String] {
        try await request(with: .init(ciImage: image))
    }

    public func getWords(from imageUrl: URL) async throws -> [String] {
        try await request(with: .init(url: imageUrl))
    }

    public func getWords(from imageUrls: [URL]) async throws -> [String] {
        // To future self: API doesn't like being hit this quickly or concurrently
        try await withThrowingTaskGroup(of: [String].self) { taskGroup in
            for imageUrl in imageUrls {
                taskGroup.addTask { try await self.getWords(from: imageUrl) }
            }
            var words = [String]()
            for try await text in taskGroup {
                words.append(contentsOf: text)
            }
            return words
        }
    }

    private func request(with handler: VNImageRequestHandler) async throws -> [String] {
        try await withCheckedThrowingContinuation { [topCandidates] continuation in
            let request = VNRecognizeTextRequest { request, error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else if let observations = request.results as? [VNRecognizedTextObservation] {
                    let words = observations.compactMap { $0.topCandidates(topCandidates).first?.string }
                    continuation.resume(returning: words)
                } else {
                    continuation.resume(returning: [])
                }
            }
            request.recognitionLevel = .accurate
            do {
                try handler.perform([request])
            } catch {
                debugPrint(error)
            }
        }
    }
}
