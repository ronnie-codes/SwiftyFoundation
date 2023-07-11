//
//  Bundle.swift
//  NiceTube
//

import Foundation

public extension Bundle {
    enum InfoKey: String {
        case serverURL = "ServerURL"
    }

    func value<T>(for infoKey: InfoKey) -> T? {
        guard let info = infoDictionary else {
            assertionFailure("Missing Info.plist")
            return nil
        }
        return info[infoKey.rawValue] as? T
    }
}
