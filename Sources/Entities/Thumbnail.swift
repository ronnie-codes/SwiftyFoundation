//
//  Thumbnail.swift
//  NiceTube
//

import Foundation

public struct Thumbnail: Decodable, Hashable {
    public let url: URL
    public let width: Double
    public let height: Double
}
