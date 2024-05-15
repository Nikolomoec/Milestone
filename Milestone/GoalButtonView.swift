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
            Circle()
                .frame(width: 180)
                .opacity(0.8)
                .overlay {
                    Circle()
                        .frame(width: howLongButtonPressed * 10)
                        .foregroundStyle(.white)
                }
            
            ForEach(Array(linesArray.enumerated()), id: \.element) { index, line in
                Rectangle()
                    .foregroundStyle(.white)
                    .rotationEffect(line.angle + .degrees(90))
                    .frame(width: line.width, height: line.height)
                    .offset(x: isPressing ? 0 : line.xStart, y: isPressing ? 0 : line.yStart)
                    .animation(.easeIn(duration: line.duration).speed(isPressing ? 1 : 100), value: isPressing)
                    .opacity(isPressing ? howLongButtonPressed / 7 : 0)
            }
        }
        .onLongPressGesture(minimumDuration: 1.5, maximumDistance: 20) {
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
        .onReceive(timer) { _ in
            howLongButtonPressed += 0.15
        }
        .onAppear {
            timer.upstream.connect().cancel()
        }
    }
}

#Preview {
    GoalButtonView()
}
