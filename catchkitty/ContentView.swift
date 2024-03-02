//
//  ContentView.swift
//  catchkitty
//
//  Created by Olgun ‏‏‎‏‏‎ on 2.03.2024.
//

import SwiftUI

struct ContentView: View {
    @State var score = 0
    @State var timeLeft = 10.0
    @State var chosenX = 200
    @State var chosenY = 110
    @State var showAlert = false
    
    //tuple
    let (x1,y1) = (200,100)
    let (x2,y2) = (70,100)
    let (x3,y3) = (330,100)
    let (x4,y4) = (200,270)
    let (x5,y5) = (70,270)
    let (x6,y6) = (330,270)
    let (x7,y7) = (200,-100)
    let (x8,y8) = (70,-100)
    let (x9,y9) = (330,-100)
    
    
    var counterTimer : Timer {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if self.timeLeft < 0.5 {
                self.showAlert = true
            }
            else {
                self.timeLeft -= 1
            }
         
        }
    }
    
    var timer : Timer {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            let tupleArray = [(self.x1,self.y1),(self.x2,self.y2),(self.x3,self.y3),(self.x4,self.y4),(self.x5,self.y5),(self.x6,self.y6),(self.x7,self.y7),(self.x8,self.y8),(self.x9,self.y9)]
            
            var previewNumber : Int?
            func randomNumberGenerator() -> Int {
                var randomNumber = Int(arc4random_uniform(UInt32(tupleArray.count-1)))
                while previewNumber == randomNumber {
                    var randomNumber = Int(arc4random_uniform(UInt32(tupleArray.count-1)))
                }
                previewNumber = randomNumber
                return randomNumber
            }
            
            
            self.chosenX = tupleArray[randomNumberGenerator()].1
            self.chosenY = tupleArray[randomNumberGenerator()].1
        }
    }
    
    
    var body: some View {
      

        VStack {
            Spacer().frame(height: 90)
            Text("Catch The Kitty").bold().font(.largeTitle)
            HStack {
                Text("Time Left:").font(.title)
                Text(String(self.timeLeft)).font(.title)
            }
                
            HStack{
                Text("Score:").font(.title)
                Text(String(self.score)).font(.title)
            }
            Spacer()
            Image("hello").resizable()
                .frame(width: 100, height: 100)
                .position(CGPoint(x: self.chosenX, y: self.chosenY))
                .gesture(TapGesture(count: 1).onEnded({ _ in
                    self.score += 1
                }))
                .onAppear(perform: {
                   _ = self.timer
                    _ = self.counterTimer
                })
            Spacer()
        }.alert(isPresented: $showAlert, content: {
            return Alert(title: Text("Time Over!"), message: Text("Want to Play Again?"), primaryButton: Alert.Button.default(Text("Ok"), action: {
                self.score = 0
                self.timeLeft = 10.0
                
                
            }), secondaryButton: Alert.Button.cancel())
        })
        
        
        
    
    }
}

#Preview {
    ContentView()
}
