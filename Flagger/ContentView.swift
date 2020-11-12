//
//  ContentView.swift
//  Flagger
//
//  Created by Ege Çavuşoğlu on 11/10/20.
//

import SwiftUI

struct ContentView: View {
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    
    @State private var correctAnswer = Int.random(in: 0..<3)
    
    @State private var showScoreAlert = false
    @State private var scoreTitle = ""
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.purple, Color.blue]), startPoint: .topLeading, endPoint: .bottomTrailing).edgesIgnoringSafeArea(.all)
            VStack{
                VStack (spacing: 40) {
                    Text("Guess the country.").font(.callout).foregroundColor(.white)
                    Text(countries[correctAnswer]).font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/).foregroundColor(.white)
            }
            
                Spacer()
                VStack (spacing: 30){
                    ForEach(0..<3) { number in
                        Button(action: {
                            // flag is tapped
                            self.flagTapped(number: number)
                        }){
                            Image(self.countries[number])
                                .clipShape(Capsule())
                                .overlay(Capsule().stroke(Color.black, lineWidth: 2))
                                .shadow(color: .black, radius: 10, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/)
                        }
                    }
                    .alert(isPresented: $showScoreAlert, content: {
                        Alert(title: Text(scoreTitle), message: Text("Would you like to continue?"), dismissButton: .default(Text("Yes"), action: {
                            self.askQuestion()
                        }))
                    })
                }
            }
        }
    }
    
    func flagTapped(number:Int){
        if number == correctAnswer {
            scoreTitle = "Correct"
        }
        else{
            scoreTitle = "Wrong"
        }
        showScoreAlert = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0..<3)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
