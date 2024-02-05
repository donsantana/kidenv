//
//  MyCanvas.swift
//  Kidenv
//
//  Created by Done Santana on 2/4/24.
//

import SwiftUI
import PencilKit

struct MyCanvas: UIViewRepresentable {

    @Binding var canvasView: PKCanvasView
    @State var toolPicker = PKToolPicker()
    
    func makeUIView(context: Context) -> PKCanvasView {
        canvasView.drawingPolicy = .anyInput
        canvasView.tool = PKInkingTool(.pen, color: .black, width: 15)
        return canvasView
    }
    
    func updateUIView(_ uiView: PKCanvasView, context: Context) {
        showToolPicker()
    }
    
    func showToolPicker() {
        toolPicker.setVisible(true, forFirstResponder: canvasView)
        toolPicker.addObserver(canvasView)
        canvasView.becomeFirstResponder()
    }
    
    func hideToolPicker() {
        toolPicker.setVisible(false, forFirstResponder: canvasView)
    }
    
}
