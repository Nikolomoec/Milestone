//
//  DashLine.swift
//  Milestone
//
//  Created by Nikita Kolomoec on 10.05.2024.
//

import SwiftUI

struct DashLine: Identifiable, Hashable {
    var id = UUID()
    let xStart: Double
    let yStart: Double
    
    let angle = Angle.degrees(.random(in: 0...360))
    let width = Double.random(in: 2...7)
    let height = Double.random(in: 7...60)
    let duration = Double.random(in: 0.2...1.2)
    
    let randomMultiplier = Double.random(in: 150...550) // Used to calculate xStart, yStart
    
    init() {
        xStart = cos(angle.radians) * randomMultiplier
        yStart = sin(angle.radians) * randomMultiplier
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: DashLine, rhs: DashLine) -> Bool {
        lhs.id == rhs.id
    }
}
