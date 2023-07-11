//
//  Network.swift
//  NiceTube
//

import Foundation

public enum HTTPMethod: String {
    case head
    case get
    case post
    case put
    case patch
}

public protocol RESTNetwork {
    func request<Parameters: Encodable, Response: Decodable>(method: HTTPMethod, path: String, params: Parameters) async throws -> Response
    func request<Response: Decodable>(method: HTTPMethod, path: String) async throws -> Response
}
