//
//  NLP.swift
//  SwiftyFoundation
//

import NaturalLanguage

public enum Language: String {
    case en
}

public protocol LanguageService {
    func detectLanguage(in string: String) -> Language?
}

public final class LanguageServiceApple: LanguageService {
    private let recognizer: NLLanguageRecognizer

    public init(recognizer: NLLanguageRecognizer = NLLanguageRecognizer()) {
        self.recognizer = recognizer
    }

    public func detectLanguage(in string: String) -> Language? {
        // Reset the recognizer to its initial state.
        recognizer.reset()
        // Process additional strings for language identification.
        recognizer.processString(string)
        // Identify the dominant language.
        if let language = recognizer.dominantLanguage {
            return Language(rawValue: language.rawValue)
        } else {
            return nil
        }
    }
}
