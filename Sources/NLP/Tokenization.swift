//
//  Tokenizer.swift
//  SwiftyFoundation
//

import NaturalLanguage

public typealias Token = (text: String, range: Range<String.Index>)

public enum TokenizationUnit: Sendable, CaseIterable {
    case word
    case sentence
    case paragraph
    case document
}

public protocol TokenizationService {
    func tokenize(_ content: String) -> [Token]
}

public final class TokenizationServiceApple: TokenizationService  {
    private let tokenizer: NLTokenizer

    public init(tokenizationUnit: TokenizationUnit) {
        self.tokenizer = NLTokenizer(unit: tokenizationUnit.appleNLTokenUnit)
    }

    public func tokenize(_ content: String) -> [Token] {
        tokenizer.string = content

        var tokens = [Token]()
        tokenizer.enumerateTokens(in: content.startIndex..<content.endIndex) { tokenRange, _ in
            let token = content[tokenRange].trimmingCharacters(in: .whitespacesAndNewlines)

            if !token.isEmpty {
                tokens.append((token, tokenRange))
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
