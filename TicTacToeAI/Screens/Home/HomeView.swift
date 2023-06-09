//
//  HomeView.swift
//  TicTacToeAI
//
//  Created by Cenk Bahadır Çark on 15.04.2023.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        
        NavigationView {
            ZStack {
                Color(.black)
                    .ignoresSafeArea(.all)
                VStack(spacing: 30){
                    Spacer()
                    GradientTitleTextView(title: "WELCOME")
                    HStack {
                        FireTitleTextView(title: "FIRE")
                        Spacer()
                        WaterTitleTextView(title: "WATER")
                    }.frame(width: UIScreen.main.bounds.width - 120)
                    HStack {
                        LottieView(lottieFile: "fire")
                            .frame(width: UIScreen.main.bounds.width / 2, height: UIScreen.main.bounds.height / 3)
                        LottieView(lottieFile: "water")
                            .frame(width: UIScreen.main.bounds.width / 2, height: UIScreen.main.bounds.height / 3)
                    }
                    NavigationLink {
                        PPView()
                    } label: {
                        HomePageButton(title: "Player vs Player")
                    }
                    NavigationLink {
                        ModeSelect()
                    } label: {
                        HomePageButton(title: "Player vs AI")
                    }
                    Spacer()
                }
            }
        }.accentColor(.white)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

struct HomePageButton: View {
    
    @State var title: String
    var body: some View {
        Text(title)
            .frame(width: 280, height: 50)
            .foregroundColor(Color("indicatorFC"))
            .font(.system(size: 15, weight: .semibold, design: .monospaced))
            .foregroundColor(.white)
            .background(.black.opacity(0.5))
            .cornerRadius(50)
            .overlay(Capsule().stroke(LinearGradient(gradient: Gradient(colors: [.red , .blue]), startPoint: .leading, endPoint: .trailing),lineWidth: 5))
    }
}

struct GradientTitleTextView: View {
    
    @State var title: String
    
    var body: some View {
        Text(title)
            .font(.system(size: 40, weight: .semibold, design: .monospaced))
            .multilineTextAlignment(.center)
            .overlay {
                LinearGradient(
                    colors: [.red, .blue, ],
                    startPoint: .bottom,
                    endPoint: .trailing
                )
                .mask(
                    Text(title)
                        .font(.system(size: 40, weight: .semibold, design: .monospaced))
                        .multilineTextAlignment(.center)
                )
            }
    }
}

struct FireTitleTextView: View {
    
    @State var title: String
    
    var body: some View {
        Text(title)
            .font(.system(size: 40, weight: .semibold, design: .monospaced))
            .multilineTextAlignment(.center)
            .overlay {
                LinearGradient(
                    colors: [.yellow, .yellow, .red, .red ],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .mask(
                    Text(title)
                        .font(.system(size: 40, weight: .semibold, design: .monospaced))
                        .multilineTextAlignment(.center)
                )
            }
    }
}

struct WaterTitleTextView: View {
    
    @State var title: String
    
    var body: some View {
        Text(title)
            .font(.system(size: 40, weight: .semibold, design: .monospaced))
            .multilineTextAlignment(.center)
            .overlay {
                LinearGradient(
                    colors: [.blue, .blue, .white ],
                    startPoint: .bottom,
                    endPoint: .top
                )
                .mask(
                    Text(title)
                        .font(.system(size: 40, weight: .semibold, design: .monospaced))
                        .multilineTextAlignment(.center)
                )
            }
    }
}
