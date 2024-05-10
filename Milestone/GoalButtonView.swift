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
    
    var body: some View {
        ZStack {
            Color.red
                .ignoresSafeArea()
            
            Circle()
                .frame(width: 180)
                .opacity(0.8)
                .overlay {
                    Circle()
                        .frame(width: howLongButtonPressed * 10)
                        .foregroundStyle(.white)
                }
        }
        .onLongPressGesture(minimumDuration: 1.4, maximumDistance: 20) {
            completedLongPress = true
            howLongButtonPressed = 0
        } onPressingChanged: { isPressing in
            self.isPressing = isPressing
            
            if !isPressing {
                timer.upstream.connect().cancel()
                howLongButtonPressed = 0
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
