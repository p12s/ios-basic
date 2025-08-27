//
//  Particle.swift
//  DemoLection1
//
//  Created by Anton Marunko on 06.03.2025.
//

import SwiftUI

struct Particle: Identifiable {
    let id = UUID()
    var position: CGPoint
    var color: Color
    var diameter: CGFloat
    var speed: CGFloat
    var opacity: Double
}
