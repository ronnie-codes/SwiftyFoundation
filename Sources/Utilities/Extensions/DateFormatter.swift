//
//  DateFormatter.swift
//  SwiftySeatGeek
//

import Foundation

extension DateFormatter {
    static let rfc822: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        return dateFormatter
    }()

    static let iso8601: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        return dateFormatter
    }()

    static let client: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, d MMM yyyy h:mm a"
        return dateFormatter
    }()
}

extension String {
    var date: Date? {
        DateFormatter.client.date(from: self)
    }
}

extension Date {
    var formattedString: String {
        DateFormatter.client.string(from: self)
    }
}
