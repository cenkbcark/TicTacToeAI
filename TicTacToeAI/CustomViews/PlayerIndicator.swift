//
//  PlayerIndicator.swift
//  TicTacToeAI
//
//  Created by Cenk Bahadır Çark on 15.04.2023.
//

import SwiftUI

struct PlayerIndicator: View {
    
    var systemImageName: String
    
    var body: some View {
        Image(systemImageName)
            .resizable()
            .frame(width: 55, height: 55)
            .foregroundColor(Color("indicatorFC"))
            .opacity(0.8)
//        LottieView(lottieFile: systemImageName)
//            .frame(width: 75, height: 75)
    }
}
