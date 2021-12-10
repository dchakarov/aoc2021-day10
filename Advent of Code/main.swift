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

func findClosingChars(in line: [Character]) -> [Character]? {
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
                return nil
            }
        }
    }
    return validClosingChars
}


func main2() {
    let fileUrl = URL(fileURLWithPath: "./aoc-input")
    guard let inputString = try? String(contentsOf: fileUrl, encoding: .utf8) else { fatalError("Invalid input") }

    let lines = inputString.components(separatedBy: "\n")
        .filter { !$0.isEmpty }

    var sorted = lines
        .map { Array($0) }
        .compactMap { findClosingChars(in: $0) }
        .map { score($0.reversed()) }
        .sorted()
    print(sorted.remove(at: sorted.count / 2))
}

func score(_ line: [Character]) -> Int {
    let points = [Character(")"): 1,
                  Character("]"): 2,
                  Character("}"): 3,
                  Character(">"): 4
    ]

    let score = line.reduce(0) { partialResult, char in
        5 * partialResult + points[char]!
    }

    return score
}

//main()
main2()
