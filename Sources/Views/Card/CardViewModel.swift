//
//  CardViewModel.swift
//  NiceTube
//

import Foundation

public protocol CardViewModel {
    var image: URL { get }
    var caption: String { get }
    var title: String { get }
    var subtitle: String? { get }
    var footer: String { get }
}

public struct CardViewModelDefault: CardViewModel {
    public let image: URL
    public let caption: String
    public let title: String
    public let subtitle: String?
    public let footer: String

    public init(image: URL, caption: String, title: String, subtitle: String? = nil, footer: String) {
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
    public let subtitle: String?
    public let footer: String
    public let caption: String

    public init(subtitle: String? = "NewsNation") {
        let imageString = "https://i.ytimg.com/vi/Ry_3icwd68o/hq720.jpg?sqp=-oaymwEcCNAFEJQDSFXyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLDxFdueq3h_OeVh3UZi7ZZXtJE5lw"
        self.image = URL(string: imageString)!
        self.title = "Former FBI agent: Idaho suspect’s change in demeanor ‘concerning’ | NewsNation Prime"
        self.subtitle = subtitle
        self.footer = "4.1K views - 49 minutes ago"
        self.caption = "4:24"
    }
}
