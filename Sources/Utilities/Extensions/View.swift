//
//  View.swift
//  NiceTube
//

import SwiftUI

public extension View {
    // Reference(25:56): https://www.youtube.com/watch?v=uC3X4FoielU
    func iOS<Content: View>(_ modifier: (Self) -> Content) -> some View {
        #if os(iOS)
            modifier(self)
        #else
            self
        #endif
    }

    func tvOS<Content: View>(_ modifier: (Self) -> Content) -> some View {
        #if os(tvOS)
            modifier(self)
        #else
            self
        #endif
    }

    func macOS<Content: View>(_ modifier: (Self) -> Content) -> some View {
        #if os(macOS)
            modifier(self)
        #else
            self
        #endif
    }

    func watchOS<Content: View>(_ modifier: (Self) -> Content) -> some View {
        #if os(watchOS)
            modifier(self)
        #else
            self
        #endif
    }

    func refreshable(action: @escaping () -> Void) -> some View {
        toolbar {
            Button(action: action) {
                Image(systemName: "arrow.clockwise")
            }
        }
    }
}
