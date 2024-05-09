//
//  ContentView.swift
//  Milestones test learning
//
//  Created by Nikita Kolomoec on 07.05.2024.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isLinePressed = false
    
    @State private var date = Date()
    
    @State private var isSettingsPressed = false
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                // Gradient Background
                AnimatedGradBackground(type: .blackWhite)
                
                // Properties are here because we need geo access
                var lineSize: (Double, Double) {
                    isLinePressed ? (geo.size.width / 7, height: geo.size.height) : (geo.size.width / 4, height: geo.size.height)
                }
                
                var lineXOffset: Double {
                    isLinePressed ? geo.frame(in: .global).midX - geo.size.width / 14 : 0
                }
                
                LazyVStack {
                    HStack {
                        // MARK: Main Line
                        ZStack {
                            // Base line and a fluid on top
                            ZStack(alignment: .bottom) {
                                // Base line
                                Rectangle()
                                    .opacity(0.7)
                                
                                // Timeline for water animation
                                TimelineView(.animation) { tl in
                                    let time = date.distance(to: tl.date)
                                    
                                    // "Fluid"
                                    AnimatedGradBackground(type: .fluid)
                                        .frame(height: geo.size.height / 3)
                                        .mask {
                                            Rectangle()
                                                .frame(height: geo.size.height / 3.2)
                                                .distortionEffect(ShaderLibrary.wave(.float(time)), maxSampleOffset: .init(width: 0, height: 50))
                                        }
                                        .offset(y: geo.size.height / 60)
                                }
                            }
                            
                            
                            // Sides
                            HStack {
                                Rectangle()
                                    .frame(width: geo.size.width / 40)
                                
                                Spacer()
                                
                                Rectangle()
                                    .frame(width: geo.size.width / 40)
                            }
                            .foregroundStyle(Color(white: 0.5))
                            
                            // Milestone checkpoints plus side decorations
                            VStack {
                                Spacer()
                                
                                ForEach(0..<2) { num in
                                    Spacer()
                                    
                                    // Left side mini bar
                                    HStack(spacing: 0) {
                                        UnevenRoundedRectangle(cornerRadii: .init(topLeading: 3, bottomLeading: 3))
                                            .foregroundStyle(Color(white: 0.5))
                                            .frame(width: 10)
                                        
                                        // Center
                                        Rectangle()
                                            .opacity(0.3)
                                            .frame(width: lineSize.0 - geo.size.width / 40)
                                            .overlay {
                                                AnimatedGradBackground(type: .blackWhite)
                                                    .mask {
                                                        Image(systemName: "checkmark.circle")
                                                            .resizable()
                                                            .scaledToFit()
                                                            .padding(10)
                                                    }
                                            }
                                        
                                        // Right side mini bar
                                        UnevenRoundedRectangle(cornerRadii: .init(bottomTrailing: 3, topTrailing: 3))
                                            .foregroundStyle(Color(white: 0.5))
                                            .frame(width: 10)
                                    }
                                    .frame(width: lineSize.0 - geo.size.width / 50, height: geo.size.height / 15)
                                    
                                    Spacer()
                                }
                            }
                            .padding(.bottom)
                        }
                        .frame(width: lineSize.0, height: lineSize.1)
                        .animation(.easeInOut.speed(0.4).delay(0.3), value: isLinePressed)
                        .offset(x: lineXOffset)
                        .animation(.easeInOut.speed(0.4), value: isLinePressed)
                        .onTapGesture { isLinePressed.toggle() }
                        .padding(.leading, 16)
                        
                        Spacer()
                        
                        // MARK: Text
                        VStack {
                            Spacer()
                            
                            Circle()
                                .frame(width: 180)
                                .opacity(0.8)
                            
                            VStack(alignment: .center) {
                                Text("The Hardest Part")
                                    .font(.title3.bold())
                                Text("This is actually the most important step you can take")
                            }
                            .foregroundStyle(.white)
                            .frame(width: geo.size.width / 1.8, height: geo.size.height / 4, alignment: .center)
                        }
                        .padding(.bottom, geo.size.height / 10)
                        .offset(x: isLinePressed ? geo.size.width * 1.3 : 0)
                        .animation(.easeInOut.speed(0.3), value: isLinePressed)
                        
                        Spacer()
                    }
                }
            }
            // Settings
            .overlay(alignment: .topTrailing) {
                Button {
                    // Open settings sheet
                    isSettingsPressed = true
                } label: {
                    ZStack {
                        Circle()
                            .foregroundStyle(.gray)
                            .opacity(0.2)
                            .frame(width: geo.size.height / 20)
                        
                        Circle()
                            .frame(width: 10)
                    }
                }
                .buttonStyle(.plain)
                .padding()
                .padding(.top, 40)
            }
            .sheet(isPresented: $isSettingsPressed) {
                
            }      
        }
        .ignoresSafeArea()
    }
}

#Preview {
    ContentView()
}
