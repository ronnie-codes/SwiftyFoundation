//
//  MyFileImporter.swift
//  Read2Me
//
//  Created by Ronny Vega on 5/9/26.
//

import UniformTypeIdentifiers
import SwiftUI

extension View {
    nonisolated func myFileImporter(
        isPresented: Binding<Bool>,
        allowedContentTypes: [UTType],
        onCompletion: @escaping (_ result: Result<URL, any Error>) -> Void
    ) -> some View {
#if targetEnvironment(macCatalyst)
        self.onChange(of: isPresented.wrappedValue) { _, isShowing in
            guard isShowing else { return }
            isPresented.wrappedValue = false
            MacCatalystFilePicker.presentOpenPanel(allowedFileTypes: allowedContentTypes.map { $0.identifier }) { url in
                guard let url else { return }
                onCompletion(.success(url))
            }
        }
#else
        self
        .fileImporter(
            isPresented: isPresented,
            allowedContentTypes: allowedContentTypes
        ) { result in
            onCompletion(result)
        }
#endif
    }
}

#if targetEnvironment(macCatalyst)
/**
 Mac Catalyst apps primarily build against the iOS SDK. Statically importing and linking AppKit (a macOS framework) in this context is generally not supported.
 If you reference AppKit types directly, you’ll hit compile/link issues for non-Mac builds or risk shipping binaries with unresolved symbols.

 To work around this, the code uses dynamic loading:
    - Bundle(path: "/​System​/​Library​/​Frameworks​/​App​Kit​.framework")?.load() loads AppKit at runtime only when running on Mac Catalyst.
    - NSClass​From​String("​NSOpen​Panel") and perform(_:) avoid any compile-time references to AppKit symbols.
    - This keeps the code building cleanly for iOS while still allowing access to AppKit when available at runtime on macOS.
 */
enum MacCatalystFilePicker {

    static func presentOpenPanel(
        allowedFileTypes: [String],
        completion: @escaping (URL?) -> Void
    ) {
        // 1. Load AppKit dynamically (safe to call multiple times).
        Bundle(path: "/System/Library/Frameworks/AppKit.framework")?.load()

        // 2. Obtain an NSOpenPanel instance via +[NSOpenPanel openPanel].
        guard let openPanelClass = NSClassFromString("NSOpenPanel"),
              let panelObj = (openPanelClass as AnyObject)
                  .perform(NSSelectorFromString("openPanel"))?
                  .takeUnretainedValue()
        else {
            completion(nil)
            return
        }

        // 3. Configure the panel through KVC.
        let panel = panelObj as AnyObject
        panel.setValue(true,  forKey: "canChooseFiles")
        panel.setValue(false, forKey: "canChooseDirectories")
        panel.setValue(false, forKey: "allowsMultipleSelection")
        panel.setValue(allowedFileTypes, forKey: "allowedFileTypes")

        // 4. Present via -[NSSavePanel beginWithCompletionHandler:].
        //    The handler receives NSModalResponse (Int); 1 == OK.
        let handler: @convention(block) (Int) -> Void = { response in
            DispatchQueue.main.async {
                if response == 1 {
                    let urls = panel.value(forKey: "URLs") as? [URL]
                    completion(urls?.first)
                } else {
                    completion(nil)
                }
            }
        }
        _ = panel.perform(
            NSSelectorFromString("beginWithCompletionHandler:"),
            with: handler
        )
    }
}
#endif
