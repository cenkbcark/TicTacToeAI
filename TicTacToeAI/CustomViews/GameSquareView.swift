//
//  GameSquareView.swift
//  TicTacToeAI
//
//  Created by Cenk Bahadır Çark on 15.04.2023.
//

import SwiftUI

struct GameSquareView: View {
    var proxy: GeometryProxy
    
    var body: some View {
        Circle()
//            .foregroundColor(Color("circleBG"))
            .foregroundColor(.black)
            .frame(width: proxy.size.width / 3 - 15, height: proxy.size.width / 3 - 15)
            .opacity(0.5)
//            .background(
//                LinearGradient(gradient: Gradient(colors: [.red , .blue]), startPoint: .leading, endPoint: .trailing)
//            )
//            .cornerRadius((proxy.size.height / 3 - 15) / 2)
            .overlay(Capsule().stroke(LinearGradient(gradient: Gradient(colors: [.red , .blue]), startPoint: .leading, endPoint: .trailing),lineWidth: 5))
    }
}
