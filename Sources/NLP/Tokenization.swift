//
//  Tokenizer.swift
//  SwiftyFoundation
//

import NaturalLanguage

public protocol TokenizationService {
    func tokenize(_ content: String) -> [String]
}

public final class TokenizationServiceApple: TokenizationService  {
    private let tokenizer: NLTokenizer

    public init(tokenizer: NLTokenizer = NLTokenizer(unit: .word)) {
        self.tokenizer = tokenizer
    }

    public func tokenize(_ content: String) -> [String] {
        tokenizer.string = content

        var tokens = [String]()
        tokenizer.enumerateTokens(in: content.startIndex..<content.endIndex) { tokenRange, _ in
            tokens.append(content[tokenRange].lowercased())
            return true
        }
        return tokens
    }
}
