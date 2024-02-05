//
//  DrawingView.swift
//  Kidenv
//
//  Created by Done Santana on 2/4/24.
//

import SwiftUI
import PencilKit

struct DrawingView: View {
    let parent: UIViewController!
//    @StateObject private var drawingManager = DrawingManager()
    @Environment(\.undoManager) private var undoManager
    @State private var canvasView = PKCanvasView()
    
    var body: some View {
        Spacer()
        VStack(spacing: 60) {
            HStack(spacing: 40) {
                Button() {
                    canvasView.drawing = PKDrawing()
                } label: {
                    Image("drawclean")
                }
                Button() {
                    undoManager?.undo()
                }label: {
                    Image("undo")
                }
                Button() {
                    undoManager?.redo()
                }label: {
                    Image("redo")
                }
                Button() {
                    parent.dismiss(animated: true)
                }label: {
                    Image("barCloseBtn")
                }
            }
        }
        MyCanvas(canvasView: $canvasView)
//            .onDisappear() {
//            MyCanvas(canvasView: $canvasView).hideToolPicker()
//        }
    }
}
//
//private final class DrawingManager: ObservableObject {
//  let toolPicker = PKToolPicker()
//  var canvasView: PKCanvasView?
//
//  func register(_ canvasView: PKCanvasView) {
//    self.canvasView = canvasView
//    toolPicker.setVisible(true, forFirstResponder: canvasView)
//    toolPicker.addObserver(canvasView)
//  }
//
//  func unregister() {
//    guard let canvasView else {
//      return
//    }
//    toolPicker.setVisible(false, forFirstResponder: canvasView)
//    toolPicker.removeObserver(canvasView)
//    self.canvasView = nil
//  }
//}

#Preview {
    DrawingView(parent: UIViewController())
}
