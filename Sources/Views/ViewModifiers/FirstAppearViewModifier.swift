//
//  FirstAppearViewModifier.swift
//  SwiftyFoundation
//
//  Created by Ronny Vega on 10/22/25.
//

import SwiftUI

private struct FirstOnAppearViewModifier: ViewModifier {
    @State private var isFirst: Bool = true
    let action: () -> Void

    func body(content: Content) -> some View {
        content
            .onAppear {
                guard isFirst else {
                    return
                }
                isFirst = false
                action()
            }
    }
}

private struct FirstTaskViewModifier: ViewModifier {
    @State private var isFirst: Bool = true
    let action: () async -> Void

    func body(content: Content) -> some View {
        content
            .task {
                guard isFirst else {
                    return
                }
                isFirst = false
                await action()
            }
    }
}

public extension View {
    func onFirstAppear(perform action: @escaping () -> Void) -> some View {
        modifier(FirstOnAppearViewModifier(action: action))
    }

    func onFirstAppear(perform action: @escaping () async -> Void) -> some View {
       modifier(FirstTaskViewModifier(action: action))
    }
}
