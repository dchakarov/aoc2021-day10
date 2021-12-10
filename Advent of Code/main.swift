//
//  main.swift
//  No rights reserved.
//

import Foundation
import RegexHelper

func main() {
    let fileUrl = URL(fileURLWithPath: "./aoc-input")
    guard let inputString = try? String(contentsOf: fileUrl, encoding: .utf8) else { fatalError("Invalid input") }
    
    let lines = inputString.components(separatedBy: "\n")
        .filter { !$0.isEmpty }

    let points = [Character(")"): 3,
                  Character("]"): 57,
                  Character("}"): 1197,
                  Character(">"): 25137
    ]

    var illegalCharacters = [Character]()

    for line in lines {
        let ar = Array(line)
        if let char = findIllegalChar(in: ar) {
            illegalCharacters.append(char)
        }
    }

    print(illegalCharacters.reduce(0, { partialResult, char in
        partialResult + points[char]!
    }))
}

func findIllegalChar(in line: [Character]) -> Character? {
    var validClosingChars = [Character]()

    for char in line {
        if char == "[" {
            validClosingChars.append("]")
        } else if char == "<" {
            validClosingChars.append(">")
        } else if char == "{" {
            validClosingChars.append("}")
        } else if char == "(" {
            validClosingChars.append(")")
        } else {
            let last = validClosingChars.removeLast()
            if last != char {
                return char
            }
        }
    }
    return nil
}

main()
