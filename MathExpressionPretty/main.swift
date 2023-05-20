//
//  main.swift
//  MathExpressionPretty
//
//  Created by Connor Reed on 5/19/23.
//

import Foundation



let text = "2 + 3 * 6 / 9"
let lexer = Lexer(text: text)
let parser = Parser(tokens: lexer.lex())
let tree = parser.expression()
let evaluator = Evaluator()
print(evaluator.evaluate(expr: tree))
//expr.display(level: 0)
