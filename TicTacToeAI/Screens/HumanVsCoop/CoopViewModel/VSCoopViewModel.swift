//
//  GameViewModel.swift
//  TicTacToeAI
//
//  Created by Cenk Bahadır Çark on 15.04.2023.
//

import SwiftUI

enum VSCoopPlayers {
    case human
    case computer
}

struct VSCoopMoves {
    let player: VSCoopPlayers
    let boardIndex: Int
    
    var indicator: String {
        return player == .human ? "fire-cartoon":"water-cartoon"
    }
}

final class VSCoopViewModel: ObservableObject {
    let columns: [GridItem] = [
                            GridItem(.flexible()),
                            GridItem(.flexible()),
                            GridItem(.flexible())
                               ]
    
    @Published var moves: [VSCoopMoves?] = Array(repeating: nil, count: 9) // empty game board
    @Published var isGameBoardDisable: Bool = false
    @Published var alertItem : AlertItem?
    
    @Published var humanScore: Int = 0
    @Published var computerScore: Int = 0
    @Published var mode: String = "EASY"
    
    func processPlayerMove(for position: Int) {
        if isSquareOccupied(in: moves, forIndex: position){ return }
        moves[position] = VSCoopMoves(player: .human, boardIndex: position)
        
        //check for win condition or draw
        if checkWinCondition(for: .human, in: moves) {
            alertItem = VSCoopAlertContext.humanWin
            humanScore += 1
            return
        }
        
        if checkForDraw(in: moves) {
            alertItem = VSCoopAlertContext.draw
            return
        }
        isGameBoardDisable = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [self] in
            // computer make a move
            let computerPosition = determineComputerMovesPosition(in: moves, mode: mode)
            moves[computerPosition] = VSCoopMoves(player: .computer, boardIndex: computerPosition)
            isGameBoardDisable = false
            
            if checkWinCondition(for: .computer, in: moves) {
                alertItem = VSCoopAlertContext.computerWin
                computerScore += 1
                return
            }
            if checkForDraw(in: moves) {
                alertItem = VSCoopAlertContext.draw
                return
            }
        }
    }
    
    func isSquareOccupied(in move: [VSCoopMoves?], forIndex index: Int) -> Bool {
        return moves.contains(where: {$0?.boardIndex == index}) // check index is exist
    }
    
    func determineComputerMovesPosition(in moves: [VSCoopMoves?], mode: String) -> Int {
        let winPatterns: Set<Set<Int>> = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]]
        
        if mode == "HARD" {
            //If AI can win, then win
            let computerMoves = moves.compactMap({$0}).filter({$0.player == .computer}) // clear the nill
            let computerPosition = Set(computerMoves.map({$0.boardIndex}))
            
            for pattern in winPatterns {
                let winPosition = pattern.subtracting(computerPosition)
                if winPosition.count == 1 {
                    let isAvailable = !isSquareOccupied(in: moves, forIndex: winPosition.first!)
                    if isAvailable { return winPosition.first!}
                }
            }
        }
        if mode == "MEDIUM" || mode == "HARD" {
            //If I cant win, block
            let humanMoves = moves.compactMap({$0}).filter({$0.player == .human}) // clear the nill
            let humanPosition = Set(humanMoves.map({$0.boardIndex}))
            
            for pattern in winPatterns {
                let winPosition = pattern.subtracting(humanPosition)
                if winPosition.count == 1 {
                    let isAvailable = !isSquareOccupied(in: moves, forIndex: winPosition.first!)
                    if isAvailable { return winPosition.first!}
                }
            }
        }
        //If AI can't block, then take middle
        let centerSquare = 4
        if !isSquareOccupied(in: moves, forIndex: centerSquare) {
            return centerSquare
        }
        
        var movePosition = Int.random(in: 0..<9)
        while isSquareOccupied(in: moves, forIndex: movePosition) {
            //change position
            movePosition = Int.random(in: 0..<9)
        }
        return movePosition
    }
    
    func checkWinCondition(for player: VSCoopPlayers, in moves: [VSCoopMoves?]) -> Bool {
        let winPatterns: Set<Set<Int>> = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]]
        
        let playerMoves = moves.compactMap({$0}).filter({$0.player == player}) // clear the nill
        let playerPosition = Set(playerMoves.map({$0.boardIndex}))
        
        for pattern in winPatterns where pattern.isSubset(of: playerPosition) { return true }
        
        return false
    }
    func checkForDraw(in moves: [VSCoopMoves?]) -> Bool {
        // if 9 moves made means draw
        return moves.compactMap{$0}.count == 9
    }
    func resetGame() {
        moves = Array(repeating: nil, count: 9)
    }
}
