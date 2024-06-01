//
//  ContentView.swift
//  Timeglass
//
//  Created by Saksham Malhotra on 15/05/24.
//

import SwiftUI
import Combine

struct ContentView: View {
    
    @State var fTimer = 60
    @State var timerRunning = false
    @State var showingInputBox = false
    @State var userTimerValue = ""
    @State var inputSetTime = 60
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack{
            VStack{
                HStack {
                    Spacer()
                    FlipTimer(fTimer: $fTimer, timerRunning : $timerRunning, timer: timer)
                        .frame(minWidth: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, minHeight: 44, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .padding(10)
                        .background(
                            Color(#colorLiteral(red: 0.6642268896, green: 0.6642268896, blue: 0.6642268896, alpha: 1)))
                        .cornerRadius(10)
                    Spacer()
                }
                .padding(.top, 10)
                
                Spacer()
                
                
                
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.white)
                    .frame(maxWidth: .infinity, maxHeight: 500)
                    .padding()
                    .shadow(color: /*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/.opacity(0.3), radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 0)
                
                Spacer()
                
                HStack {
                    Spacer()
                    
                    Button(action: {
                        resetTimer()
                    }, label: {
                        Text("Reset timer")
                    })
                    
                    Button("Set timer") {
                        showingInputBox = true
                    }
                    .foregroundColor(.black)
                    .fontWeight(.bold)
                    .padding()
                    .background(
                        Capsule(style: .circular)
                            .fill(Color(#colorLiteral(red: 0.6642268896, green: 0.6642268896, blue: 0.6642268896, alpha: 1)))
                    )
                    
                    Button("Start timer") {
                        timerRunning.toggle()
                    }
                    .foregroundColor(.black)
                    .fontWeight(.bold)
                    .padding()
                    .background(
                        Capsule(style: .circular)
                            .fill(Color(#colorLiteral(red: 0.6642268896, green: 0.6642268896, blue: 0.6642268896, alpha: 1)))
                    )
                }
                .frame(minWidth: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, minHeight: 44)
                .padding()
                .padding(.trailing, 25)
                .shadow(color: /*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/.opacity(0.3), radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 0)
                
            }
        }
        .sheet(isPresented : $showingInputBox) {
            VStack {
                Text("Enter the timer value")
                    .font(.headline)
                TextField("Seconds", text: $userTimerValue)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.numberPad)
                    .padding()
                Button("Set Timer") {
                    if let value = Int(userTimerValue), value > 0 {
                        fTimer = value
                        inputSetTime = value
                        timerRunning = false
                    }
                    showingInputBox = false
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .clipShape(Capsule(style: .circular))
            }
            .padding()
        }
        .background(Color.green)
        
    }
    
    func resetTimer() {
        fTimer = inputSetTime
    }
}

#Preview {
    ContentView()
}

struct FlipTimer : View {
    
    @Binding var fTimer : Int
    @Binding var timerRunning : Bool
    let timer : Publishers.Autoconnect<Timer.TimerPublisher>
    
    var body: some View {
        VStack{
            Text("\(fTimer)")
                .onReceive(timer, perform: { _ in
                    if fTimer > 0 && timerRunning {
                        fTimer -= 1
                    } else {
                        timerRunning = false
                    }
                })
                .font(.system(size: 80, weight: .bold))
                .opacity(0.8)
        }
    }
}
