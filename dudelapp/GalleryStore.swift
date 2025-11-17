//
//  GalleryStore.swift
//  dudelapp
//
//  Created by Flavia Conte on 15/11/25.
//

import SwiftUI
import PencilKit
import UIKit

// Un singolo disegno salvato
struct DudelArtwork: Identifiable {
    let id = UUID()
    var title: String
    var drawingData: Data
    var thumbnail: UIImage
}

// Store condiviso tra DrawingView e GalleryView
final class GalleryStore: ObservableObject {
    @Published var artworks: [DudelArtwork] = []

    func addArtwork(from drawing: PKDrawing,
                    title: String = "Opera senza titolo") {

        let data = drawing.dataRepresentation()

        // bounds: se è vuoto, uso una dimensione di default
        let bounds = drawing.bounds.isEmpty
            ? CGRect(x: 0, y: 0, width: 2048, height: 2048)
            : drawing.bounds

        let image = drawing.image(from: bounds,
                                  scale: UIScreen.main.scale)

        let artwork = DudelArtwork(
            title: title,
            drawingData: data,
            thumbnail: image
        )

        artworks.append(artwork)
    }
}
