//
//  Destination.swift
//  NiceTube
//

import Foundation
import SwiftUI

public protocol Destination {
    var id: UUID { get }
    var title: String { get }
    var systemImage: String { get }
    var view: AnyView { get }
}

public struct DestinationDefault: Destination {
    public let id: UUID = .init()
    public let title: String
    public let systemImage: String
    public let view: AnyView

    public init(title: String, systemImage: String, view: some View) {
        self.title = title
        self.systemImage = systemImage
        self.view = AnyView(view)
    }
}
