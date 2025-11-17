//
//  GalleryView.swift
//  dudelapp
//
//  Created by Flavia Conte on 15/11/25.
//

import SwiftUI

struct GalleryView: View {
    @EnvironmentObject var galleryStore: GalleryStore

    let columns = [GridItem(.adaptive(minimum: 220), spacing: 24)]

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 24) {
                    ForEach($galleryStore.artworks) { $artwork in
                        VStack(alignment: .leading, spacing: 8) {
                            // Thumbnail
                            Image(uiImage: artwork.thumbnail)
                                .resizable()
                                .scaledToFill()
                                .frame(height: 160)
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                                .clipped()

                            // Titolo rinominabile
                            TextField("Titolo", text: $artwork.title)
                                .font(.caption)
                                .textFieldStyle(.roundedBorder)
                        }
                    }
                }
                .padding(24)
            }
            .navigationTitle("Pila")
        }
    }
}

#Preview {
    GalleryView()
        .environmentObject(GalleryStore())
}
