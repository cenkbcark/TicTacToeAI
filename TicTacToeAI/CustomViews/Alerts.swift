//
//  Alerts.swift
//  TicTacToeAI
//
//  Created by Cenk Bahadır Çark on 15.04.2023.
//

import SwiftUI

struct AlertItem: Identifiable {
    let id = UUID()
    var title: Text
    var message: Text
    var buttonTitle: Text
}

struct VSCoopAlertContext {
    static let humanWin = AlertItem(title: Text("You win"),
                                    message: Text("You are so smart. You beat your own AI"),
                                    buttonTitle: Text("Hell yeah"))
    
    static let computerWin = AlertItem(title: Text("You lost"),
                                       message: Text("Your super AI beat you on your own game"),
                                       buttonTitle: Text("Hell yeah"))
    
    static let draw = AlertItem(title: Text("Draw"),
                                message: Text("What a battle of wits we have here..."),
                                buttonTitle: Text("Try again"))
    
}

struct PlayerVsPlayerAlertContext {
    static let player1Win = AlertItem(title: Text("Player 1 win"),
                                    message: Text("It was good. Better luck next time for Player 2"),
                                    buttonTitle: Text("Hell yeah"))
    
    static let player2Win = AlertItem(title: Text("Player 2 win"),
                                       message: Text("It was good. Better luck next time for Player 1"),
                                       buttonTitle: Text("Hell Yeah"))
    
    static let draw = AlertItem(title: Text("Draw"),
                                message: Text("What a battle of wits we have here..."),
                                buttonTitle: Text("Try again"))
    
}


