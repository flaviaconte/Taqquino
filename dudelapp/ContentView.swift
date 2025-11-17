//
//  ContentView.swift
//  dudelapp
//
//  Created by Flavia Conte on 12/11/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        // 👇 1) AGGIUNTO: NavigationStack
        NavigationStack {
            VStack(alignment: .leading, spacing: 15) {
                // Titolo
                Text("Let's Dudel!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.horizontal)
                    .padding(.top)

                // Contenuto scrollabile
                ScrollView {
                    VStack(spacing: 15) {

                        // 👇 2) AGGIUNTO: NavigationLink intorno alla prima card
                        NavigationLink {
                            DrawingView()
                                .frame(maxWidth: .infinity, maxHeight: .infinity)// 👉 va alla schermata di disegno
                        } label: {
                            DudelCard(
                                label: "CHALLENGE",
                                title: "Shape of the Day",
                                height: 709,
                                backgroundImageName: "challengeBg"   // 👈 nome esatto dell’asset
                            )
                        }
                        .buttonStyle(.plain)   // così la card non diventa “bottone blu”

                        // Card PRACTICE -> apre la galleria
                        NavigationLink {
                            GalleryView()   // 👈 schermata con le thumbnail
                        } label: {
                            DudelCard(
                                label: "PRACTICE",
                                title: "Random Shapes",
                                height: 404,
                                backgroundImageName: "practice"
                            )
                        }
                        .buttonStyle(.plain)
                    }
                    .padding(.horizontal)
                    .padding(.bottom)
                }
            }
        }
    }
}

// Card riutilizzabile
struct DudelCard: View {
    let label: String
    let title: String
    let height: CGFloat
    let backgroundImageName: String?

    var body: some View {
        ZStack(alignment: .bottomLeading) {

            // Sfondo: immagine se c'è, altrimenti rettangolo giallo
            if let backgroundImageName {
                Image(backgroundImageName)
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: .infinity)
                    .frame(height: height)
                    .clipped()
                    .clipShape(RoundedRectangle(cornerRadius: 20))
            } else {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.yellow.opacity(0.4))
                    .frame(maxWidth: .infinity)
                    .frame(height: height)
            }

            // Testi in basso a sinistra
            VStack(alignment: .leading, spacing: 4) {
                Text(label.uppercased())
                    .font(.caption)
                    .fontWeight(.semibold)
                    .opacity(0.7)

                Text(title)
                    .font(.title2)
                    .fontWeight(.bold)
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
