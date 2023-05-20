//
//  Lexer.swift
//  MathExpressionPretty
//
//  Created by Connor Reed on 5/19/23.
//

import Foundation

enum TokenType: Codable{
    case Number, Division, Multiplication, Addition, Subtraction, lParen, rParen, Literal, Exp
}

class Lexer{
    var text: String
    var tokens: [Token] = []
    var current: Int = 0
    init(text: String){
        self.text = text
    }
    
    func lex() -> [Token]{
        tokens = []
        while(current < text.count){
            let currentChar = peek()
            lexChar(currentChar)
            current += 1;
        }
        return tokens
    }
    func lexChar(_ char: String){
        switch(char){
        case "+":
            addToken(Token(.Addition, nil))
            break
        case "-":
            addToken(Token(.Subtraction, nil))
            break
        case "*":
            addToken(Token(.Multiplication, nil))
            break
        case "/":
            addToken(Token(.Division, nil))
            break
        case "(":
            addToken(Token(.lParen, nil))
            break
        case ")":
            addToken(Token(.rParen, nil))
            break
        case "^":
            addToken(Token(.Exp, nil))
            break
        default:
            if(char.isNumber){
                number()
            } else if(char.isAlpha){
                literal()
            }
        }
    }
    
    func addToken(_ token: Token){
        tokens.append(token)
    }
    
    func literal(){
        var text = peek()
        
        while(peekNext().isAlphaNumeric && peekNext() != ""){
            text += consume()
        }
        
        addToken(Token(.Literal, text))
    }
    
    func number(){
        var text = peek()
        
        while(peekNext().isNumber && peekNext() != ""){
            text += consume()
        }
        if(peekNext() == "."){
            text += consume()
        }
        while(peekNext().isNumber && peekNext() != ""){
            text += consume()
        }
        
        addToken(Token(.Number, text))
    }
    
    func peek() -> String{
        return text.charAt(index: current)
    }
    func peekNext() -> String{
        if(current >= text.count - 1) { return ""}
        return text.charAt(index: current + 1)
    }
    func consume() -> String{
        if(current >= text.count - 1) { return ""}
        current += 1
        return text.charAt(index: current)
    }
}

class Token: Codable{
    var type: TokenType
    var value: String?
    
//    public var description: String {
//        return "Token(type: \(type), value: \(value ?? "N/A"))"
//    }
    
    init(_ type: TokenType, _ value: String?){
        self.type = type
        self.value = value
    }
}
