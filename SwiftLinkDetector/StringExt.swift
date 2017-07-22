//
//  StringExt.swift
//  SwiftLinkDetector
//
//  Created by JohnP on 7/22/17.
//  Copyright © 2017 JohnP. All rights reserved.
//

import Foundation

extension String {
    func getAllClickableLinks() -> [NSTextCheckingResult]? {
        let regulaStr = Regex.webURL
        let regex = try? NSRegularExpression.init(pattern: regulaStr, options: NSRegularExpression.Options.caseInsensitive)
        
        let matches = regex?.matches(in: self, options: NSRegularExpression.MatchingOptions.reportCompletion, range: NSRange.init(location: 0, length: self.characters.count))
        return matches
    }
}
