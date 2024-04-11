//
//  SightWord.swift
//  Kidenv
//
//  Created by Done Santana on 3/27/24.
//

import Foundation


enum SightWordCategory: String {
    case preKinder = "PRE-KINDERGARTEN"
    case kinder = "KINDERGARTEN"
    case firstGrade = "FIRST GRADE"
    case secondGrade = "SECOND GRADE"
    case custom = "CUSTOM"
    case oneLetter = "1 LETTER"
    case twoLetters = "2 LETTERS"
    case threeLetters = "3 LETTERS"
    case fourLetters = "4 LETTERS"
    case fivePlusLetters = "5+ LETTERS"
    case fourWords = "4 WORDS"
    case eightWords = "8 WORDS"
}

struct SightWord: Identifiable, Comparable {
    static func < (lhs: SightWord, rhs: SightWord) -> Bool {
        return lhs.wordText.lowercased() < rhs.wordText.lowercased()
    }
    
    var id = UUID().uuidString
    var isSelected = false
    var category: SightWordCategory
    var wordText: String
    
    mutating func select() {
        self.isSelected = true
    }
}

class SightWordsViewModel: ObservableObject {
    @Published private var model: SightWordsGame
    
    var sightWordsList: [SightWord] {
        model.sightWords
    }
    
    init() {
        self.model = SightWordsGame()
    }
    
    func select(_ sightWord: SightWord) {
        model.select(sightWord)
    }
    
    func filter(_ category: SightWordCategory? = nil) {
        model.filter(category)
    }

}

struct SightWordsGame {
    private(set) var sightWords: [SightWord] = []

    init() {
        fetchSightWords()
    }
    
    private mutating func fetchSightWords(category: String = "") {
        SightWordAPIManager.shared.getSightWords(category: category, completion: { result in
            switch result {
            case .success(let wordList):
                self.sightWords = wordList
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
    
    mutating func filter(_ category: SightWordCategory? = nil) {
        fetchSightWords(category: category!.rawValue)
    }
    
    mutating func select(_ sightWord: SightWord) {
        //sightWords.first({$0 == sightWord})?.select()
    }
}
