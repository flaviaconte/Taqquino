//
//  ContentView.swift
//  dudelapp
//
//  Created by Flavia Conte on 12/11/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 20) {
                // Titolo
                Text("")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.horizontal)
                    .padding(.top)
                    .padding(.top, -100)

                // Scrollable Content
                ScrollView {
                    VStack(spacing: 20) {

                        // 👇 2) AGGIUNTO: NavigationLink intorno alla prima card
                        NavigationLink {
                            DrawingView()
                                .frame(maxWidth: .infinity, maxHeight: .infinity)// 👉 va alla schermata di disegno
                        } label: {
                            DudelCard(
                                label: "",
                                title: "",
                                height: 770,
                                backgroundImageName: "taqquino1"   // 👈 nome esatto dell’asset
                            )
                        }
                        .buttonStyle(.plain)   // così la card non diventa “bottone blu”

                        HStack(spacing: 20){
                            // Card archive
                            NavigationLink {
                                GalleryView()   // 👈 schermata con le thumbnail
                            } label: {
                                VStack {
                                    Image("taqquino2")
                                        .resizable()
                                        .frame(width: 484, height: 449)
                                }
                            }
                            .buttonStyle(.plain)
                            NavigationLink {
                                GalleryView()   // 👈 schermata con le thumbnail
                            } label: {
                                VStack {
                                    Image("taqquino3")
                                        .resizable()
                                        .frame(width: 484, height: 449)
                                }
                            }
                            .buttonStyle(.plain)
                        }
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
