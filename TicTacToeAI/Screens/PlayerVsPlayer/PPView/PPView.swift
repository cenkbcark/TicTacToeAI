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
            LinearGradient(gradient: Gradient(colors: [.blue, .red]), startPoint: .leading, endPoint: .trailing)
                .ignoresSafeArea(.all)
            GeometryReader { geomerty in
                VStack {
                    VStack(spacing: 10){
                        GradientTitleTextView(title: "SCORE")
                            .padding()
                        HStack {
                            ScoreView(title: "FIRE: \(viewModel.player1Score)")
                            Spacer()
                            ScoreView(title: "WATER: \(viewModel.player2Score)")
                        }
//                        GradientSubTitleTextView(title: "YOUR TURN\n\(viewModel.firstPlayerTurn ? "FIRE":"WATER" )")
//                            .padding(.top)
                    }
                    Spacer()
                    LazyVGrid(columns: viewModel.columns, spacing: 5) {
                        ForEach(0..<9) { i in
                            ZStack {
                                GameSquareView(proxy: geomerty)
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

struct ScoreView: View {
    
    @State var title: String
    var body: some View {
        Text(title)
            .frame(width: 150, height: 75)
            .foregroundColor(Color("indicatorFC"))
            .font(.system(size: 15, weight: .semibold, design: .monospaced))
            .foregroundColor(.white)
            .background(.black.opacity(0.5))
            .cornerRadius(50)
            .overlay(Capsule().stroke(LinearGradient(gradient: Gradient(colors: [.red , .blue]), startPoint: .leading, endPoint: .trailing),lineWidth: 5))
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
