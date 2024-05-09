//
//  AnimatedGradBackground.swift
//  Milestones test learning
//
//  Created by Nikita Kolomoec on 08.05.2024.
//

import SwiftUI
import MulticolorGradient

struct AnimatedGradBackground: View {
    
    var type: BackgroundTypes
    
    @State private var animationAmount: CGFloat = 0.0
    @State private var timer = Timer.publish(every: 1.0 / 60.0, on: .main, in: .common).autoconnect()
    
    @State private var date = Date()
    
    var backTime: Double {
        switch type {
        case .blackWhite:
            3.5
        case .vibes:
            6
        case .fluid:
            3
        }
    }
    
    var body: some View {
        
        Group {
            switch type {
            case .blackWhite:
                TimelineView(.animation) { tl in
                    let time = Double(date.distance(to: tl.date))
                    
                    ZStack {
                        MulticolorGradient {
                            ColorStop(position: .top, color: Color(white: 0.0))
                            ColorStop(position: UnitPoint(x: 0.7, y: animationAmount), color: Color(white: 0.2))
                            ColorStop(position: UnitPoint(x: animationAmount, y: 0.3), color: Color(white: 0.3))
                            ColorStop(position: UnitPoint(x: 1.2, y: 1.2), color: Color(white: 0.16))
                        }
                        .noise(64)
                        .power(10.0)
                        .onChange(of: time) {
                            animationAmount = (sin(time / 9) + 1) / 2
                        }
                    }
                }
            case .vibes:
                ZStack {
                    MulticolorGradient {
                        ColorStop(position: .top, color: Color(hex: 0xd62828))
                        ColorStop(position: UnitPoint(x: 0.5 + sin(animationAmount * 0.8) * 0.5, y: 0.5 + cos(animationAmount * 0.8) * 0.5), color: Color(hex: 0x003049))
                        ColorStop(position: UnitPoint(x: 0.5 - sin(animationAmount) * 0.45, y: 0.5 + cos(animationAmount) * 0.5), color: Color(hex: 0x003049))
                        ColorStop(position: UnitPoint(x: 0.5, y: 0.5), color: Color(hex: 0xf77f00))
                    }
                    .noise(32.0)
                    .onReceive(timer) { time in
                        animationAmount += 1.0 / 60.0
                    }
                }
                .onAppear {
                    timer = Timer.publish(every: 1.0 / 60.0, on: .main, in: .common).autoconnect()
                }.onDisappear {
                    timer.upstream.connect().cancel()
                }
            case .fluid:
                TimelineView(.animation) { tl in
                    ZStack {
                        let time = Double(date.distance(to: tl.date))
                        
                        MulticolorGradient {
                            ColorStop(position: .top, color: Color(red: 0.27, green: 0.36, blue: 0.41))
                            ColorStop(position: UnitPoint(x: 0.7, y: animationAmount), color: Color(red: 0.47, green: 0.58, blue: 0.65))
                            ColorStop(position: UnitPoint(x: animationAmount, y: 0.3), color: Color(red: 0.42, green: 0.55, blue: 0.62))
                            ColorStop(position: UnitPoint(x: 1.2, y: 1.2), color: Color(red: 0.27, green: 0.36, blue: 0.41))
                        }
                        .noise(10)
                        .power(10.0)
                        .onChange(of: time) {
                            animationAmount = (sin(time / backTime) + 1) / 2
                        }
                    }
                }
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    AnimatedGradBackground(type: .blackWhite)
}

extension Color {
    init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: alpha
        )
    }
}

enum BackgroundTypes {
    case blackWhite, vibes, fluid
}
