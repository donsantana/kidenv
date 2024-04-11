//
//  TopBar.swift
//  Kidenv
//
//  Created by Done Santana on 3/13/24.
//

import SwiftUI

struct TopBar: View {
    let previousView: UIViewController
    let hasMenu = false
    var body: some View {
        HStack() {
            Spacer()
            Button() {
                previousView.dismiss(animated: true)
            }label: {
                Image("barCloseBtn")
            }
        }.padding(.top,10)
        .padding(.trailing,10)
    }
}

#Preview {
    TopBar(previousView: UIViewController())
}
