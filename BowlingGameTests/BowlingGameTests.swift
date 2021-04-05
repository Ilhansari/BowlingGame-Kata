//
//  BowlingGameTests.swift
//  BowlingGameTests
//
//  Created by Ilhan Sari on 4.04.2021.
//

@testable import BowlingGame
import XCTest

final class Game {

    private var theScore = 0

    func roll(_ pins: Int) {
        theScore += pins
    }

    func score() -> Int {
        return theScore
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
}
