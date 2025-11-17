//
//  dudelappApp.swift
//  dudelapp
//
//  Created by Flavia Conte on 12/11/25.
//

import SwiftUI

@main
struct dudelappApp: App {
    @StateObject private var galleryStore = GalleryStore()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(galleryStore)   // 👈 lo vedono tutte le view
        }
    }
}
