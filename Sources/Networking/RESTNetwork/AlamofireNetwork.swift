//
//  AlamofireNetwork.swift
//  NiceTube
//

import Alamofire
import Foundation

public final class AlamofireNetwork: RESTNetwork {
    private let serverURL: URL
    private let encoder: JSONEncoder
    private let decoder: JSONDecoder

    public init(serverURL: URL, encoder: JSONEncoder = JSONEncoder(), decoder: JSONDecoder = JSONDecoder()) {
        self.serverURL = serverURL
        self.encoder = encoder
        self.decoder = decoder
    }

    public func request<Parameters: Encodable, Response: Decodable>(method: HTTPMethod, path: String, params: Parameters) async throws -> Response {
        let url = serverURL.appendingPathComponent(path)
        let request = AF.request(url, method: method.toAlamofireHTTPMethod(), parameters: params, encoder: JSONParameterEncoder(encoder: encoder))
        let response = try await request.serializingDecodable(Response.self, decoder: decoder).value // TODO: Scan http codes
        return response
    }

    public func request<Response: Decodable>(method: HTTPMethod, path: String) async throws -> Response {
        let url = serverURL.appendingPathComponent(path)
        let request = AF.request(url, method: method.toAlamofireHTTPMethod())
        let response = try await request.serializingDecodable(Response.self, decoder: decoder).value
        return response
    }
}

private extension HTTPMethod {
    func toAlamofireHTTPMethod() -> Alamofire.HTTPMethod {
        switch self {
        case .head:
            return .head
        case .get:
            return .get
        case .post:
            return .post
        case .patch:
            return .patch
        case .put:
            return .put
        }
    }
}
