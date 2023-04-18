//
//  PPView.swift
//  TicTacToeAI
//
//  Created by Cenk Bahadır Çark on 15.04.2023.
//

import SwiftUI

struct PPView: View {
    
    @StateObject private var viewModel = PPViewModel()

    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea(.all)
            GeometryReader { geomerty in
                VStack {
                    VStack(spacing: 10){
                        GradientTitleTextView(title: "SCORE")
                            .padding()
                        HStack {
                            FireScoreView(title: $viewModel.player1Score, player: "FIRE")
                            Spacer()
                            WaterScoreView(title: $viewModel.player2Score, player: "WATER")
                        }
                    }
                    Spacer()
                    LazyVGrid(columns: viewModel.columns, spacing: 10) {
                        ForEach(0..<9) { i in
                            ZStack {
                                GameSquareView(proxy: geomerty, i: i)
                                PlayerIndicator(systemImageName: viewModel.moves[i]?.indicator ?? "")
                            }.onTapGesture {
                                viewModel.processPlayerMove(for: i, firstPlayerTurn: viewModel.firstPlayerTurn)
                            }
                        }
                    }
                    Spacer()
                }
                .disabled(viewModel.isGameBoardDisable)
                .padding()
                .alert(item: $viewModel.alertItem) { alertItem in
                    Alert(title: alertItem.title, message: alertItem.message, dismissButton: .default(alertItem.buttonTitle, action: {
                        viewModel.resetGame()
                    }))
                }
            }
        }
    }
}

struct PPView_Previews: PreviewProvider {
    static var previews: some View {
        PPView()
    }
}

struct FireScoreView: View {
    @Binding var title: Int
    @State var player: String
    var body: some View {
            Text("\(player): \(title)")
                .frame(width: 150, height: 75)
                .foregroundColor(Color("indicatorFC"))
                .font(.system(size: 15, weight: .semibold, design: .monospaced))
                .foregroundColor(.white)
                .background(.black.opacity(0.5))
                .cornerRadius(50)
                .overlay(Capsule().stroke(LinearGradient(gradient: Gradient(colors: [.yellow, .yellow, .red, .red ]), startPoint: .leading, endPoint: .trailing),lineWidth: 5))
    }
}

struct WaterScoreView: View {
    @Binding var title: Int
    @State var player: String
    var body: some View {
            Text("\(player): \(title)")
                .frame(width: 150, height: 75)
                .foregroundColor(Color("indicatorFC"))
                .font(.system(size: 15, weight: .semibold, design: .monospaced))
                .foregroundColor(.white)
                .background(.black.opacity(0.5))
                .cornerRadius(50)
                .overlay(Capsule().stroke(LinearGradient(gradient: Gradient(colors: [.blue, .blue, .white ]), startPoint: .leading, endPoint: .trailing),lineWidth: 5))
    }
}
struct GradientSubTitleTextView: View {
    
    @State var title: String
    
    var body: some View {
        Text(title)
            .font(.system(size: 24, weight: .semibold, design: .monospaced))
            .multilineTextAlignment(.center)
            .overlay {
                LinearGradient(
                    colors: [.red,.white, .blue],
                    startPoint: .leading,
                    endPoint: .trailing
                )
                .mask(
                    Text(title)
                        .font(.system(size: 24, weight: .semibold, design: .monospaced))
                        .multilineTextAlignment(.center)
                )
            }
    }
}
