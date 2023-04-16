//
//  PPViewModel.swift
//  TicTacToeAI
//
//  Created by Cenk Bahadır Çark on 15.04.2023.
//

import SwiftUI


enum PvsPPlayers {
    case firstPlayer
    case secondPlayer
}

struct PvsPMoves {
    let player: PvsPPlayers
    let boardIndex: Int
    
    var indicator: String {
        return player == .firstPlayer ? "fire-cartoon":"water-cartoon"
    } // system name of image
}

final class PPViewModel: ObservableObject {
    let columns: [GridItem] = [
                            GridItem(.flexible()),
                            GridItem(.flexible()),
                            GridItem(.flexible())
                               ]
    
    @Published var moves: [PvsPMoves?] = Array(repeating: nil, count: 9) // empty game board
    @Published var isGameBoardDisable: Bool = false
    @Published var alertItem : AlertItem?
    @Published var firstPlayerTurn: Bool = true
    
    @Published var player1Score: Int = 0
    @Published var player2Score: Int = 0
    
    
    func processPlayerMove(for position: Int, firstPlayerTurn: Bool) {
        if firstPlayerTurn {
            //First Player Move
            if isSquareOccupied(in: moves, forIndex: position){ return }
            moves[position] = PvsPMoves(player: .firstPlayer, boardIndex: position)
            
            //check for win condition or draw
            if checkWinCondition(for: .firstPlayer, in: moves) {
                player1Score += 1
                alertItem = PlayerVsPlayerAlertContext.player1Win
                return
            }
            
            if checkForDraw(in: moves) {
                alertItem = PlayerVsPlayerAlertContext.draw
                return
            }
            self.firstPlayerTurn = false
            isGameBoardDisable = true
        }else {
            //Second Player Move
                // computer make a move
                if isSquareOccupied(in: moves, forIndex: position){ return }
                moves[position] = PvsPMoves(player: .secondPlayer, boardIndex: position)
                
                
                if checkWinCondition(for: .secondPlayer, in: moves) {
                    alertItem = PlayerVsPlayerAlertContext.player2Win
                    player2Score += 1
                    return
                }
                if checkForDraw(in: moves) {
                    alertItem = PlayerVsPlayerAlertContext.draw
                    return
                }
            isGameBoardDisable = true
            self.firstPlayerTurn = true
        }
        isGameBoardDisable = false
    }
    
    func isSquareOccupied(in move: [PvsPMoves?], forIndex index: Int) -> Bool {
        return moves.contains(where: {$0?.boardIndex == index}) // check index is exist
    }
    
    func checkWinCondition(for player: PvsPPlayers, in moves: [PvsPMoves?]) -> Bool {
        let winPatterns: Set<Set<Int>> = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]]
        
        let playerMoves = moves.compactMap({$0}).filter({$0.player == player}) // clear the nill
        let playerPosition = Set(playerMoves.map({$0.boardIndex}))
        
        for pattern in winPatterns where pattern.isSubset(of: playerPosition) { return true }
        
        return false
    }
    func checkForDraw(in moves: [PvsPMoves?]) -> Bool {
        // if 9 moves made means draw
        return moves.compactMap{$0}.count == 9
    }
    func resetGame() {
        moves = Array(repeating: nil, count: 9)
        self.isGameBoardDisable = false
        firstPlayerTurn = true
    }
}

