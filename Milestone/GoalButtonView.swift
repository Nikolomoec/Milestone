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
    
    let randomImpactRectangleColor = [
        Color(red: 0.10, green: 0.36, blue: 0.47),
        Color(red: 0.67, green: 0.75, blue: 0.76),
        Color(red: 0.52, green: 0.63, blue: 0.67),
        Color(red: 0.11, green: 0.31, blue: 0.36),
        Color(red: 0.49, green: 0.58, blue: 0.60)
    ].shuffled()
    
    var body: some View {
        ZStack {
            // 3 random "Impact Rectangles" when button long press is completed
            ForEach(0..<5) { num in
                ImpactRectangle()
                    .frame(width: Double.random(in: 10...60), height: completedLongPress ? 300 : 0)
                    .padding(.top, 200)
                    .foregroundStyle(randomImpactRectangleColor[num])
                    .rotationEffect(.degrees(Double(70 * num)))
                    .animation(.default, value: completedLongPress)
                    .opacity(completedLongPress ? 0 : Double.random(in: 0.7...1))
                    .animation(/*@START_MENU_TOKEN@*/.easeIn/*@END_MENU_TOKEN@*/.delay(0.1), value: completedLongPress)
                    .opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
            }
            
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
            ForEach(linesArray) { line in
                Rectangle()
                    .foregroundStyle(.white)
                    .rotationEffect(line.angle + .degrees(90))
                    .frame(width: line.width, height: line.height)
                    .offset(x: isPressing ? 0 : line.xStart, y: isPressing ? 0 : line.yStart)
                    .animation(.easeIn(duration: line.duration).speed(isPressing ? 1 : 100), value: isPressing)
                    .opacity(isPressing ? howLongButtonPressed / 7 : 0)
            }
            
            Image(systemName: "checkmark")
                .font(.system(size: 90, weight: .black))
                .opacity(completedLongPress ? 1 : 0)
                .animation(.default.delay(0.1).speed(100), value: completedLongPress)
            
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

// When completedLongPress = true, it will create some of them to show the "blowing up button" effect
struct ImpactRectangle: Shape {
    
    let randomDevisor = Double.random(in: 7...15)
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX + rect.width / randomDevisor, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.midX - rect.width / randomDevisor, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        
        return path
    }
}
