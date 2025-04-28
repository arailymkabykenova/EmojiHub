//
//  HomeView.swift
//  EmojiHub
//
//  Created by Арайлым Кабыкенова on 28.04.2025.
//


import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            VStack {
                
                Spacer()
                
                Text("Привет, ты попал в EmojiHub!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding()
                
                

                Text("Узнаем эмодзи с Марсом и Арай")
                    .font(.title2)
                    .foregroundColor(.gray)
                    .padding()
                
                Image("марсик")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)

                NavigationLink(destination: EmojiListView()) {
                    Text("Поехали 💛")
                        .font(.headline)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                Spacer()
            }
        }
    }
}
