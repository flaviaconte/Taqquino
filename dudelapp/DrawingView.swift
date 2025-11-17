//
//  Untitled.swift
//  dudelapp
//
//  Created by Flavia Conte on 15/11/25.
//
import SwiftUI
import PencilKit
import UIKit

// MARK: - Schermata di disegno

struct DrawingView: View {
    @EnvironmentObject var galleryStore: GalleryStore
    @StateObject private var controller = CanvasController()

    @State private var isErasing = false
    @State private var lineWidth: CGFloat = 8

    var body: some View {
        ZStack {
            // Canvas
            DrawingCanvas(
                isErasing: isErasing,
                lineWidth: lineWidth,
                controller: controller
            )
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.white)
            .ignoresSafeArea()

            // Barra in basso
            VStack {
                Spacer()

                HStack(spacing: 16) {
                    // penna + gomma
                    HStack(spacing: 12) {
                        Button {
                            isErasing = false
                        } label: {
                            Circle()
                                .fill(Color.black)
                                .frame(width: 24, height: 24)
                        }

                        Button {
                            isErasing = true
                        } label: {
                            Image(systemName: "eraser.fill")
                                .imageScale(.large)
                        }
                    }

                    Divider().frame(height: 24)

                    // undo / redo
                    HStack(spacing: 12) {
                        Button { controller.undo() } label: {
                            Image(systemName: "arrow.uturn.backward")
                                .imageScale(.large)
                        }
                        Button { controller.redo() } label: {
                            Image(systemName: "arrow.uturn.forward")
                                .imageScale(.large)
                        }
                    }

                    Divider().frame(height: 24)

                    // slider spessore
                    HStack(spacing: 8) {
                        Image(systemName: "line.horizontal.3.decrease")
                            .font(.caption)

                        Slider(value: $lineWidth, in: 2...40)
                            .frame(width: 120)

                        Circle()
                            .fill(Color.gray.opacity(0.8))
                            .frame(
                                width: max(6, lineWidth / 2),
                                height: max(6, lineWidth / 2)
                            )
                    }
                }
                .padding(10)
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 24))
                .padding(.horizontal, 24)
                .padding(.bottom, 24)
            }
        }
        .onDisappear {
            saveToGallery()
        }
    }

    // Salva il disegno nella galleria (se non è vuoto)
    private func saveToGallery() {
        guard let canvas = controller.canvasView else { return }
        let drawing = canvas.drawing
        if drawing.bounds.isEmpty { return }
        galleryStore.addArtwork(from: drawing)
    }
}

#Preview {
    DrawingView()
        .environmentObject(GalleryStore())
}

// MARK: - Controller undo/redo

final class CanvasController: ObservableObject {
    weak var canvasView: PKCanvasView?

    func undo() {
        canvasView?.undoManager?.undo()
    }

    func redo() {
        canvasView?.undoManager?.redo()
    }
}

// MARK: - Canvas PencilKit dentro SwiftUI

struct DrawingCanvas: UIViewRepresentable {
    var isErasing: Bool
    var lineWidth: CGFloat
    @ObservedObject var controller: CanvasController

    func makeUIView(context: Context) -> PKCanvasView {
        let canvasView = PKCanvasView()
        canvasView.drawingPolicy = .pencilOnly         // dito + Pencil
        
        canvasView.tool = makeTool()
        controller.canvasView = canvasView
        return canvasView
    }

    func updateUIView(_ uiView: PKCanvasView, context: Context) {
        uiView.tool = makeTool()
    }

    private func makeTool() -> PKTool {
        let width = max(lineWidth, 1)
        
        if isErasing {
            return PKEraserTool(.vector)
        } else {
            return PKInkingTool(
                .pen,
                color: .black,
                width: width
            )
        }
    }
}
