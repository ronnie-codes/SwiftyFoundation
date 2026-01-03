//
//  Tokenizer.swift
//  SwiftyFoundation
//

import NaturalLanguage

public enum TokenizationUnit: Sendable, CaseIterable {
    case word
    case sentence
    case paragraph
    case document
}

public protocol TokenizationService {
    func tokenize(_ content: String) -> [String]
}

public final class TokenizationServiceApple: TokenizationService  {
    private let tokenizer: NLTokenizer

    public init(tokenizationUnit: TokenizationUnit) {
        self.tokenizer = NLTokenizer(unit: tokenizationUnit.appleNLTokenUnit)
    }

    public func tokenize(_ content: String) -> [String] {
        tokenizer.string = content

        var tokens = [String]()
        tokenizer.enumerateTokens(in: content.startIndex..<content.endIndex) { tokenRange, _ in
            let token = content[tokenRange].trimmingCharacters(in: .whitespacesAndNewlines)

            if !token.isEmpty {
                tokens.append(token)
            }
 
            return true
        }
        return tokens
    }
}

private extension TokenizationUnit {
    var appleNLTokenUnit: NLTokenUnit {
        switch self {
        case .word:
            return .word
        case .sentence:
            return .sentence
        case .paragraph:
            return .paragraph
        case .document:
            return .document
        }
    }
}
