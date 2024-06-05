//
//  ContentView.swift
//  Timeglass
//
//  Created by Saksham Malhotra on 15/05/24.
//

import SwiftUI
import Combine
import CoreMotion

struct ContentView: View {
    
    @State var fTimer = 60
    @State var timerRunning = false
    @State var showingInputBox = false
    @State var userTimerValue = ""
    @State var inputSetTime = 60
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @ObservedObject var motionManager = MotionManager()
    
    var body: some View {
        ZStack{
            VStack{
                HStack {
                    Spacer()
                    FlipTimer(fTimer: $fTimer, timerRunning : $timerRunning, timer: timer)
                        .frame(minWidth: 100, minHeight: 44, alignment: .center)
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
                    .shadow(color: .black.opacity(0.3), radius: 10, x: 0.0, y: 0)
                
                Spacer()
                
                HStack {
                    Spacer()
                    
                    Button("Reset timer") {
                        resetTimer()
                    }
                    .foregroundColor(.black)
                    .fontWeight(.bold)
                    .padding()
                    .background(
                        Capsule(style: .circular)
                            .fill(Color(#colorLiteral(red: 0.6642268896, green: 0.6642268896, blue: 0.6642268896, alpha: 1)))
                    )
                    
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
                .frame(minWidth: 100, minHeight: 44)
                .padding()
                .padding(.trailing, 25)
                .shadow(color: .black.opacity(0.3), radius: 10, x: 0.0, y: 0)
                
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
        .onAppear {
            motionManager.resetCallback = self.resetTimer // Set the reset callback
            motionManager.startGyroscope() // Start gyroscope updates
        }
        
    }
    
    func resetTimer() {
        fTimer = inputSetTime
    }
}

#Preview {
    ContentView()
}


// feature I picked up from a youtube video and documentation, need to revise this more to improve.
// currently a make-shift design which i also tinkered with on ChatGPT and Copilot to get a functioning feature
class MotionManager: ObservableObject {
    private var motionManager: CMMotionManager
    @Published var isUpsideDown: Bool = false
    private let threshold: Double = .pi // 180 degrees in radians
    
    var resetCallback: (() -> Void)?

    init() {
        self.motionManager = CMMotionManager()
        self.startGyroscope()
    }

    func startGyroscope() {
        if motionManager.isGyroAvailable {
            motionManager.gyroUpdateInterval = 0.1
            motionManager.startGyroUpdates(to: .main) { (data, error) in
                guard let data = data else { return }
                self.detectRotation(data: data)
            }
        }
    }

    private func detectRotation(data: CMGyroData) {
        // z-axis rotation rate in radians per second
        let rotationRateZ = data.rotationRate.z

        // Check if the device is rotated more than 180 degrees
        if abs(rotationRateZ) > self.threshold {
            self.isUpsideDown = true
            self.reset()
        } else {
            self.isUpsideDown = false
        }
    }

    private func reset() {
        resetCallback?()
    }
}

// end of code-block that i picked up

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
