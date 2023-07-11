//
//  Label.swift
//  NiceTube
//

public struct Label: Decodable, Hashable {
    public let text: String?

    public init(text: String) {
        self.text = text
    }
}
