//
//  Exp.swift
//  MathExpressionPretty
//
//  Created by Connor Reed on 5/19/23.
//

import Foundation

class Expr{
    var type: String
    init(_ type: String = "None") {
        self.type = type
    }
    func display(level: Int){
        
    }
    class Binary: Expr{
        var left: Expr
        var op: Token
        var right: Expr
        init(left: Expr, op: Token, right: Expr){
            self.left = left
            self.op = op
            self.right = right
            super.init("Binary")
        }
        override func display(level: Int){
            var indent = "";
            for _ in 0..<level{
                indent += "    "
            }
            print(indent, "Binary(")
            print(indent, "op:")
            print(indent, "    ", op.type)
            print(indent, "left:")
            left.display(level: level + 1)
            print(indent, "right:")
            right.display(level: level + 1)
            print(indent, ")")
        }
    }
    class Unary: Expr{
        var op: Token
        var right: Expr
        init(op: Token, right: Expr){
            self.op = op
            self.right = right
            super.init("Unary")
        }
        override func display(level: Int) {
            var indent = "";
            for _ in 0..<level{
                indent += "    "
            }
            
            print(indent, "Unary(")
            print(indent, "op:")
            print(indent, "    ", op.type)
            print(indent, "right:")
            right.display(level: level + 1)
            print(indent, ")")
        }
    }
    class Literal: Expr {
        var value: String
        init(value: String){
            self.value = value
            super.init("Literal")
        }
        override func display(level: Int) {
            var indent = "";
            for _ in 0..<level{
                indent += "    "
            }
            
            print(indent, value)
        }
    }
    class Grouping: Expr {
        var content: Expr
        init(content: Expr){
            self.content = content
            super.init("Grouping")
        }
        override func display(level: Int) {
            var indent = "";
            for _ in 0..<level{
                indent += "    "
            }
            
            print(indent, "Grouping(")
            content.display(level: level + 1)
            print(indent, ")")
        }
    }
    class Call: Expr{
        var literal: Token
        var value: Expr
        init(literal: Token, value: Expr){
            self.literal = literal
            self.value = value
            super.init("Call")
        }
        
        override func display(level: Int) {
            var indent = ""
            for _ in 0..<level{
                indent += "    "
            }
            
            print(indent, "Call(")
            print(indent, "literal:")
            print(indent, "    ", literal.value ?? "")
            print(indent, "value:")
            value.display(level: level + 1)
            print(indent, ")")
        }
    }
}
