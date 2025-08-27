//
//  ContentView.swift
//  DemoLection1
//
//  Created by Anton Marunko on 06.03.2025.
//


import SwiftUI

// MARK: - ContentView

struct ContentView: View {

    @State private var particles = [Particle]()

    private let timer = Timer.publish(every: 0.03, on: .main, in: .common).autoconnect()

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            ForEach(particles) { particle in
                Circle()
                    .fill(particle.color)
                    .frame(width: particle.diameter)
                    .position(particle.position)
                    .opacity(particle.opacity)
            }
        }
        .onReceive(timer) { _ in
            createParticle()
            updateParticles()
        }
    }

    private func createParticle() {
        let new = Particle(position: CGPoint(
            x: CGFloat.random(in: 0...UIScreen.main.bounds.width),
            y: UIScreen.main.bounds.height + 50),
                           color: getRandomColor(),
                           diameter: CGFloat.random(in: 8...20),
                           speed: CGFloat.random(in: 2...10),
                           opacity: 5)
        particles.append(new)
    }

    private func getRandomColor() -> Color {
        [Color.blue, Color.purple, Color.pink, Color.cyan].randomElement() ?? .blue
    }

    private func updateParticles() {
        particles = particles.compactMap({ particle in
            var updatedParticle = particle
            updatedParticle.position.y -= updatedParticle.speed
            updatedParticle.opacity -= 0.01
            return updatedParticle.opacity > 0 ? updatedParticle : nil
        })
    }
}

#Preview {
    ContentView()
}
