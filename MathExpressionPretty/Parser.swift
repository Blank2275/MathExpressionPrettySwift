//
//  Parser.swift
//  MathExpressionPretty
//
//  Created by Connor Reed on 5/19/23.
//

import Foundation

class Parser{
    var tokens: [Token]
    var current: Int = 0
    init(tokens: [Token]){
        self.tokens = tokens
    }
    
    func expression() -> Expr{
        return term()
    }
    
    func term() -> Expr{
        var expr = factor()
        
        while(match(types: [.Addition, .Subtraction])){
            let op = previous()
            let r = factor()
            expr = Expr.Binary(left: expr, op: op, right: r)
        }
        return expr
    }
    func factor() -> Expr {
        var expr = power()
        
        while(match(types: [.Multiplication, .Division])){
            let op = previous()
            let r = power()
            expr = Expr.Binary(left: expr, op: op, right: r)
        }
        return expr
    }
    
    func power() -> Expr {
        var expr = unary()
        
        while(match(types: [.Exp])){
            let op = previous()
            let r = unary()
            expr = Expr.Binary(left: expr, op: op, right: r)
        }
        return expr
    }
    
    func unary() -> Expr {
        if(match(types: [.Subtraction])){
            let op = previous()
            let right = unary()
            return Expr.Unary(op: op, right: right)
        }
        
        return primary()
    }
    
    func primary() -> Expr{
        if(match(types: [.Number])){
            return Expr.Literal(value: previous().value ?? "")
        }
        
        if(match(types: [.lParen])){
            let expr = expression()
            _ = consume(type: .rParen, message: "Expected a )")
            return Expr.Grouping(content: expr)
        }
        
        if(match(types: [.Literal])){
            let literal = previous()
            if(match(types: [.lParen])){
                let body = expression()
                _ = consume(type: .rParen, message: "Expected a )")
                return Expr.Call(literal: literal, value: body)
            }
            return Expr.Literal(value: literal.value ?? "")
        }
        return Expr()
    }
    
    func consume(type: TokenType, message: String) -> Token?{
        if(check(type)) {return advance()}
        
        print("error: \(message)")
        return nil
    }
    
    func match(types: [TokenType]) -> Bool {
        for type in types{
            if(check(type)){
                _ = advance()
                return true
            }
        }
        return false
    }
    func check(_ type: TokenType) -> Bool{
        if(isAtEnd()) {return false}
        return peek().type == type
            
    }
    func advance() -> Token{
        if(!isAtEnd()) {current += 1}
        return previous()
    }
    
    func isAtEnd() -> Bool{
        return current >= tokens.count
    }
    
    func peek() -> Token {
        return tokens[current]
    }
    
    func previous() -> Token {
        return tokens[current - 1]
    }
}
