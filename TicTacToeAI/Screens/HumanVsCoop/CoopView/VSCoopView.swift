//
//  HumanVsCoop.swift
//  TicTacToeAI
//
//  Created by Cenk Bahadır Çark on 15.04.2023.
//

import SwiftUI


struct VSCoopView: View {
    
    @StateObject private var viewModel = VSCoopViewModel()
    @Binding var mode: String
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea(.all)
            GeometryReader { geomerty in
                VStack {
                    VStack(spacing: 10){
                        GradientTitleTextView(title: "SCORE")
                        HStack {
                            FireScoreView(title: $viewModel.humanScore, player: "YOU: ")
                            Spacer()
                            WaterScoreView(title: $viewModel.computerScore,player: "COOP: ")
                        }
                    }
                    Spacer()
                    LazyVGrid(columns: viewModel.columns, spacing: 5) {
                        ForEach(0..<9) { i in
                            ZStack {
                                GameSquareView(proxy: geomerty, i: i)
                                PlayerIndicator(systemImageName: viewModel.moves[i]?.indicator ?? "")
                            }.onTapGesture {
                                viewModel.mode = mode
                                viewModel.processPlayerMove(for: i)
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        VSCoopView(mode: .constant("EASY"))
    }
}

