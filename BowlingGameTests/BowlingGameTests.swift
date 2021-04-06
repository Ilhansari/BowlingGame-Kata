//
//  BowlingGameTests.swift
//  BowlingGameTests
//
//  Created by Ilhan Sari on 4.04.2021.
//

@testable import BowlingGame
import XCTest

final class Game {

    private var rolls = [Int](repeating: 0, count: 21)
    private var currentRoll = 0

    func roll(_ pins: Int) {
        rolls[currentRoll] = pins
        currentRoll += 1
    }

    func score() -> Int {
        var score = 0
        var i = 0
        for _ in 1...10 {
            if rolls[i] + rolls[i+1] == 10 {
                score += 10 + rolls[i+2]
                i += 2
            } else {
                score += rolls[i] + rolls[i+1]
                i += 2
            }
        }
        return score
    }
}

final class BowlingGameTests: XCTestCase {

    private var game: Game!

    override func setUp() {
        super.setUp()
        game = Game()
    }

    override func tearDown() {
        game = nil
        super.tearDown()
    }

    private func rollMany(pins: Int, times: Int) {
        for _ in 1...times {
            game.roll(pins)
        }
    }

    func testGutterGame() {
        rollMany(pins: 0, times: 20)
        XCTAssertEqual(game.score(), 0)
    }

    func testAllOnes() {
        rollMany(pins: 1, times: 20)
        XCTAssertEqual(game.score(), 20)
    }

    func testOneSpare() {
        game.roll(5)
        game.roll(5)
        game.roll(3)
        rollMany(pins: 0, times: 17)
        XCTAssertEqual(game.score(), 16)
    }
}
