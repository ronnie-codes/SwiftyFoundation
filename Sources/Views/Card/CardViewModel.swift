//
//  CardViewModel.swift
//  NiceTube
//

import Foundation

public protocol CardViewModel {
    var image: URL { get }
    var caption: String { get }
    var title: String { get }
    var subtitle: String { get }
    var footer: String { get }
}

public struct CardViewModelDefault: CardViewModel {
    public let image: URL
    public let caption: String
    public let title: String
    public let subtitle: String
    public let footer: String

    public init(image: URL, caption: String, title: String, subtitle: String, footer: String) {
        self.image = image
        self.caption = caption
        self.title = title
        self.subtitle = subtitle
        self.footer = footer
    }
}

public struct CardViewModelMock: CardViewModel {
    public let image: URL
    public let title: String
    public let subtitle: String
    public let footer: String
    public let caption: String

    public init() {
        let imageString = "https://i.ytimg.com/vi/Ry_3icwd68o/hq720.jpg?sqp=-oaymwEcCNAFEJQDSFXyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLDxFdueq3h_OeVh3UZi7ZZXtJE5lw"
        image = URL(string: imageString)!
        title = "Former FBI agent: Idaho suspect’s change in demeanor ‘concerning’ | NewsNation Prime"
        subtitle = "NewsNation"
        footer = "4.1K views - 49 minutes ago"
        caption = "4:24"
    }
}
