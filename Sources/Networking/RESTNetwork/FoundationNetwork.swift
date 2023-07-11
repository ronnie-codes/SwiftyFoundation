//
//  FoundationNetwork.swift
//  NiceTube
//

import Foundation

public final class FoundationNetwork: RESTNetwork {
    private let serverURL: URL
    private let session: URLSession
    private let encoder: JSONEncoder
    private let decoder: JSONDecoder

    public init(serverURL: URL, session: URLSession = .shared, encoder: JSONEncoder = JSONEncoder(), decoder: JSONDecoder = JSONDecoder()) {
        self.serverURL = serverURL
        self.session = session
        self.encoder = encoder
        self.decoder = decoder
    }

    public func request<Parameters: Encodable, Response: Decodable>(method: HTTPMethod, path: String, params: Parameters) async throws -> Response {
        var request = URLRequest(url: serverURL.appendingPathComponent(path))
        request.httpMethod = method.rawValue
        request.httpBody = try encoder.encode(params) // TODO: this line doesn't work properly
        let data = try await session.data(for: request) // TODO: Scan http codes
        let decodable = try decoder.decode(Response.self, from: data.0)
        return decodable
    }

    public func request<Response: Decodable>(method: HTTPMethod, path: String) async throws -> Response {
        var request = URLRequest(url: serverURL.appendingPathComponent(path))
        request.httpMethod = method.rawValue
        let data = try await session.data(for: request)
        let decodable = try decoder.decode(Response.self, from: data.0)
        return decodable
    }
}
