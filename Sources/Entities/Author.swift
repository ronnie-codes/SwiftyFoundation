//
//  Author.swift
//  NiceTube
//

public struct Author: Decodable, Hashable {
    public let id: String
    public let name: String
    public let thumbnails: [Thumbnail]
}
