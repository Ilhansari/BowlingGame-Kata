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
        var roll = 0
        for _ in 1...10 {
            if rolls[roll] == 10 {
                score += 10 + rolls[roll + 1] + rolls[roll + 2]
                roll += 1
            } else if isSpare(roll) {
                score += 10 + rolls[roll + 2]
                roll += 2
            } else {
                score += rolls[roll] + rolls[roll + 1]
                roll += 2
            }
        }
        return score
    }

    private func isSpare(_ roll: Int) -> Bool {
        return rolls[roll] + rolls[roll + 1] == 10
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

    private func rollSpare() {
        game.roll(5)
        game.roll(5)
    }

    func testOneSpare() {
        rollSpare()
        game.roll(3)
        rollMany(pins: 0, times: 17)
        XCTAssertEqual(game.score(), 16)
    }

    func testOneStrike() {
        game.roll(10)
        game.roll(3)
        game.roll(4)
        rollMany(pins: 0, times: 16)
        XCTAssertEqual(game.score(), 24)
    }
}
