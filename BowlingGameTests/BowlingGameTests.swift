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
            if isStrike(roll) {
                score += 10 + strikeBonus(roll)
                roll += 1
            } else if isSpare(roll) {
                score += 10 + spareBonus(roll)
                roll += 2
            } else {
                score += sumOfBallsInFrame(roll)
                roll += 2
            }
        }
        return score
    }

    private func isStrike(_ roll: Int) -> Bool {
        return rolls[roll] == 10
    }

    private func isSpare(_ roll: Int) -> Bool {
        return rolls[roll] + rolls[roll + 1] == 10
    }

    private func strikeBonus(_ roll: Int) -> Int {
        return rolls[roll + 1] + rolls[roll + 2]
    }

    private func spareBonus(_ roll: Int) -> Int {
        return rolls[roll + 2]
    }

    private func sumOfBallsInFrame(_ roll: Int) -> Int {
        return rolls[roll] + rolls[roll + 1]
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

    private func rollStrike() {
        game.roll(10)
    }

    func testOneSpare() {
        rollSpare()
        game.roll(3)
        rollMany(pins: 0, times: 17)

        XCTAssertEqual(game.score(), 16)
    }

    func testOneStrike() {
        rollStrike()
        game.roll(3)
        game.roll(4)
        rollMany(pins: 0, times: 10)

        XCTAssertEqual(game.score(), 24)
    }

    func testPerfectGame() {
        rollMany(pins: 10, times: 12)
        
        XCTAssertEqual(game.score(), 300)
    }
}
