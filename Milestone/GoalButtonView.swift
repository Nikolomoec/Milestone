//
//  GoalButtonView.swift
//  Milestone
//
//  Created by Nikita Kolomoec on 10.05.2024.
//

import SwiftUI

struct GoalButtonView: View {
    
    @State private var isPressing = false
    @State private var completedLongPress = false
    @State private var howLongButtonPressed = 0.0
    
    @State private var timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
    
    @State private var linesArray = [DashLine(), DashLine(), DashLine(), DashLine(), DashLine(), DashLine(), DashLine(), DashLine(), DashLine(), DashLine(), DashLine(), DashLine(), DashLine(), DashLine(), DashLine(), DashLine(), DashLine(), DashLine(), DashLine(), DashLine(), DashLine(), DashLine(), DashLine(), DashLine(), DashLine(), DashLine(), DashLine(), DashLine(), DashLine(), DashLine(), DashLine(), DashLine(), DashLine(), DashLine(), DashLine(), DashLine()]
    @State private var nextCreationTime = Date.now
    
    var body: some View {
        ZStack {
            
            
            // Start Button
            Circle()
                .frame(width: 180)
                .opacity(0.8)
                .overlay {
                    Circle()
                        .frame(width: howLongButtonPressed * 10)
                        .foregroundStyle(.white)
                    
                    if completedLongPress {
//                        AnimatedGradBackground(type: .vibes)
//                            .mask {
//                                Circle()
//                            }
                        Circle()
                            .foregroundStyle(.white)
                    }
                }
            
            // Flying Lines
            ForEach(Array(linesArray.enumerated()), id: \.element) { index, line in
                Rectangle()
                    .foregroundStyle(.white)
                    .rotationEffect(line.angle + .degrees(90))
                    .frame(width: line.width, height: line.height)
                    .offset(x: isPressing ? 0 : line.xStart, y: isPressing ? 0 : line.yStart)
                    .animation(.easeIn(duration: line.duration).speed(isPressing ? 1 : 100), value: isPressing)
                    .opacity(isPressing ? howLongButtonPressed / 7 : 0)
            }
            
            Circle()
                .stroke(lineWidth: completedLongPress ? 0 : 100)
                .animation(.easeInOut.delay(0.01), value: completedLongPress)
                .frame(width: completedLongPress ? 260 : 0)
                .foregroundStyle(Color(red: 0.55, green: 0.72, blue: 0.74))
                .animation(.easeInOut.speed(1.1), value: completedLongPress)
            
            ForEach(1..<5) { num in
                Circle()
                    .trim(from: 0.75, to: /*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
                    .frame(width: completedLongPress ? 160 : 0)
                    .foregroundStyle(Color(red: 0.34, green: 0.37, blue: 0.40))
                    .rotationEffect(.degrees(Double(num * 90)))
                    .offset(x: completedLongPress ? num == 1 || num == 4 ? 100 : -100 : 0, y: completedLongPress ? num == 1 || num == 2 ? 100 : -100 : 0)
                    .opacity(completedLongPress ? 0 : 1)
                    .animation(.default, value: completedLongPress)
            }
        }
        .onLongPressGesture(minimumDuration: 1.3, maximumDistance: 20) {
            completedLongPress = true
            howLongButtonPressed = 0
        } onPressingChanged: { isPressing in
            self.isPressing = isPressing
            
            if !isPressing {
                timer.upstream.connect().cancel()
                
                withAnimation {
                    howLongButtonPressed = 0
                }
            } else {
                timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
            }
        }
        .disabled(completedLongPress)
        .onReceive(timer) { _ in
            howLongButtonPressed += 0.15
            print(howLongButtonPressed)
        }
        .onAppear {
            timer.upstream.connect().cancel()
        }
    }
}

#Preview {
    ZStack {
        AnimatedGradBackground(type: .blackWhite)
        
        GoalButtonView()
    }
}
