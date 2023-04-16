//
//  ModeSelect.swift
//  TicTacToeAI
//
//  Created by Cenk Bahadır Çark on 15.04.2023.
//

import SwiftUI

struct ModeSelect: View {
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .red]), startPoint: .leading, endPoint: .trailing)
                .ignoresSafeArea(.all)
            VStack(spacing: 30) {
                NavigationLink {
                    VSCoopView(mode: .constant("EASY"))
                } label: {
                    HomePageButton(title: "EASY")
                }
                NavigationLink {
                    VSCoopView(mode: .constant("MEDIUM"))
                } label: {
                    HomePageButton(title: "MEDIUM")
                }
                NavigationLink {
                    VSCoopView(mode: .constant("HARD"))
                } label: {
                    HomePageButton(title: "HARD")
                }
            }
        }

    }
}

struct ModeSelect_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ModeSelect()
        }
    }
}
