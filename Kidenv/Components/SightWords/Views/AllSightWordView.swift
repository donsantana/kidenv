//
//  AllSightWordView.swift
//  Kidenv
//
//  Created by Done Santana on 3/30/24.
//

import SwiftUI

struct AllSightWordView: View {
    @ObservedObject var viewModel: SightWordsViewModel = SightWordsViewModel()
    @State var levelSelected: String = "ALL"
    
    var body: some View {
        ScrollView {
            SightWordsMenu(levelSelected: levelSelected, viewModel: viewModel)
            LazyVGrid(columns: [GridItem(.adaptive(minimum: Responsive.shared.widthPercent(percent: 35)))]) {
                ForEach(viewModel.sightWordsList.indices, id: \.self) { index in
                    CardView(wordText: viewModel.sightWordsList[index].wordText).aspectRatio(5/3, contentMode: .fit).animation(.snappy, value: viewModel.sightWordsList)
                }
            }.padding(.trailing, 20)
            .padding(.top, 5)
            .padding(.leading, 20)
        }
    }
    
   
}

#Preview {
    AllSightWordView(viewModel: SightWordsViewModel())
}

struct CardView: View {
    let wordText: String
    @State var isSelected = false
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base.fill(Color(.kidenvDarkBlue)).opacity(isSelected ? 0 : 1)
                base.strokeBorder(Color(.kidenvYellow),lineWidth: 2)
                Text(wordText).font(.title).foregroundStyle(Color(isSelected ? .kidenvYellow : .kidenvDarkBlue))
            }
            .opacity(isSelected ? 1 : 1)
        }
        .onTapGesture {
            isSelected = !isSelected
        }
    }
}

struct SightWordsMenu: View {
    @State var levelSelected: String
    var viewModel: SightWordsViewModel
    
    var body: some View {
        HStack {
            Menu {
                Button(SightWordCategory.preKinder.rawValue) {
                    updateLevelSelected(levelSelected: SightWordCategory.preKinder)
                }
                Button(SightWordCategory.kinder.rawValue) {
                    updateLevelSelected(levelSelected: SightWordCategory.kinder)
                }
                Menu {
                    Button(SightWordCategory.oneLetter.rawValue) {
                        updateLevelSelected(levelSelected: SightWordCategory.oneLetter)
                    }
                    Button(SightWordCategory.twoLetters.rawValue) {
                        updateLevelSelected(levelSelected: SightWordCategory.twoLetters)
                    }
                    Button(SightWordCategory.threeLetters.rawValue) {
                        updateLevelSelected(levelSelected: SightWordCategory.threeLetters)
                    }
                    Button(SightWordCategory.fourLetters.rawValue) {
                        updateLevelSelected(levelSelected: SightWordCategory.fourLetters)
                    }
                    Button(SightWordCategory.fivePlusLetters.rawValue) {
                        updateLevelSelected(levelSelected: SightWordCategory.fivePlusLetters)
                    }
                } label: {
                    Label(SightWordCategory.custom.rawValue,systemImage: "arrow")
                }
            } label: {
                Label(levelSelected,image: "filterIcon")
            }
            .menuOrder(.fixed)
            Spacer()
        }.padding(.leading, 20)
    }
    
    internal func updateLevelSelected(levelSelected: SightWordCategory) {
        self.levelSelected = levelSelected.rawValue
        viewModel.filter(levelSelected)
    }
}

