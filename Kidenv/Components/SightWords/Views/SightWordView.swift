//
//  SightWordView.swift
//  Kidenv
//
//  Created by Done Santana on 3/28/24.
//

import SwiftUI

struct SightWordView: View {
    var parent: UIViewController
    @ObservedObject var viewModel: SightWordsViewModel = SightWordsViewModel()
    //@State private var sightWordList: [SightWord]?
    var body: some View {
        VStack {
            
            ScrollView {
                TopBar(previousView: parent)
                AllSightWordView(viewModel: viewModel)
//                if !viewModel.filter().isEmpty {
//                    
//                } else {
//                    LoadingView()
//                }
            }
            .background() {
                Image("background")
            }
//            .onAppear {
//                SightWordAPIManager.shared.getSightWords(category: "", completion: {result in
//                    switch result {
//                    case .success(let wordList):
//                        sightWordList = wordList
//                    case .failure(let error):
//                        print(error.localizedDescription)
//                    }
//                })
//            }
            

        }
    }
}

#Preview {
    SightWordView(parent: UIViewController())
}
