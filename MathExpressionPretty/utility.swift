//
//  utility.swift
//  MathExpressionPretty
//
//  Created by Connor Reed on 5/19/23.
//

import Foundation

extension String {
    func index(from: Int) -> Index {
        return self.index(startIndex, offsetBy: from)
    }
    
    func substring(from: Int) -> String {
        let fromIndex = index(from: from)
        return String(self[fromIndex...])
    }
    
    func substring(to: Int) -> String {
        let toIndex = index(from: to)
        return String(self[..<toIndex])
    }
    
    func substring(with r: Range<Int>) -> String {
        let startIndex = index(from: r.lowerBound)
        let endIndex = index(from: r.upperBound)
        return String(self[startIndex..<endIndex])
    }
    func charAt(index: Int) -> String{
        return self.substring(with: Range(index...index))
    }
    var isNumber: Bool{
        let digitChars = CharacterSet(charactersIn: "0123456789")
        return CharacterSet(charactersIn: self).isSubset(of: digitChars)
    }
    var isAlpha: Bool{
        let alphaChars = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ")
        return CharacterSet(charactersIn: self).isSubset(of: alphaChars)
    }
    var isAlphaNumeric: Bool{
        return isAlpha || isNumber
    }
}
