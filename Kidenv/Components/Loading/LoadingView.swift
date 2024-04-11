//
//  LoadingView.swift
//  Kidenv
//
//  Created by Done Santana on 3/12/24.
//

import SwiftUI

struct LoadingView: View {
    @State var isLoading = false
    var body: some View {
        Circle()
            .trim(from: 0, to: 0.7)
            .stroke(Color.green, lineWidth: 5)
            .frame(width: 50, height: 50)
            .rotationEffect(Angle(degrees: isLoading ? 360 : 0))
            .animation(.linear
                        .repeatForever(autoreverses: false), value: isLoading)
            .onAppear {
                isLoading = true
            }
    }
}

#Preview {
    LoadingView()
}
