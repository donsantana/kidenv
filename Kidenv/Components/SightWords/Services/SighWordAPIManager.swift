//
//  APIManager.swift
//  Kidenv
//
//  Created by Done Santana on 3/28/24.
//

import Foundation


class SightWordAPIManager {
    static var shared: SightWordAPIManager {
        SightWordAPIManager()
    }
    private let mockAllWords = ["a","and","away","big","blue","can","come","down","find","for","funny","go","help","here","I","in","is","it","jump","little","look","make","me","my","not","one","play","red","run","said","see","the","three","to","two","up","we","where","yellow","you","all","am","are","at","ate","be","black","brown","but","came","did","do","eat","four","get","good","have","he","into","like","must","new","no","now","on","our","out","please","pretty","ran","ride","saw","say","she","so","soon","that","there","they","this","too","under","want","was","well","went","what","white","who","will","with","yes"]
    private let mockWordsPreKindergarten =  ["a","and","away","big","blue","can","come","down","find","for","funny","go","help","here","I","in","is","it","jump","little","look","make","me","my","not","one","play","red","run","said","see","the","three","to","two","up","we","where","yellow","you"]
    private let mockWordsKindergarten = ["all","am","are","at","ate","be","black","brown","but","came","did","do","eat","four","get","good","have","he","into","like","must","new","no","now","on","our","out","please","pretty","ran","ride","saw","say","she","so","soon","that","there","they","this","too","under","want","was","well","went","what","white","who","will","with","yes"]
    
    func getSightWords(category: String, completion: (Result<[SightWord],Error>) -> Void) {
        var sightWords: [SightWord] = []
        switch category {
        case SightWordCategory.preKinder.rawValue:
            for sightword in mockWordsPreKindergarten {
                sightWords.append(SightWord(category: SightWordCategory.preKinder, wordText: sightword))
            }
        case SightWordCategory.kinder.rawValue:
            for sightWord in mockWordsKindergarten {
                sightWords.append(SightWord(category: SightWordCategory.kinder, wordText: sightWord))
            }
        case SightWordCategory.oneLetter.rawValue:
            for sightWord in mockAllWords {
                if sightWord.count == 1 {
                    sightWords.append(SightWord(category: SightWordCategory.kinder, wordText: sightWord))
                }
            }
        case SightWordCategory.twoLetters.rawValue:
            for sightWord in mockAllWords {
                if sightWord.count == 2 {
                    sightWords.append(SightWord(category: SightWordCategory.kinder, wordText: sightWord))
                }
            }
        case SightWordCategory.threeLetters.rawValue:
            for sightWord in mockAllWords {
                if sightWord.count == 3 {
                    sightWords.append(SightWord(category: SightWordCategory.kinder, wordText: sightWord))
                }
            }
        case SightWordCategory.fourLetters.rawValue:
            for sightWord in mockAllWords {
                if sightWord.count == 4 {
                    sightWords.append(SightWord(category: SightWordCategory.kinder, wordText: sightWord))
                }
            }
        case SightWordCategory.fivePlusLetters.rawValue:
            for sightWord in mockAllWords {
                if sightWord.count > 4 {
                    sightWords.append(SightWord(category: SightWordCategory.kinder, wordText: sightWord))
                }
            }
        default:
            for sightword in mockWordsPreKindergarten {
                sightWords.append(SightWord(category: SightWordCategory.preKinder, wordText: sightword))
            }
            for sightWord in mockWordsKindergarten {
                sightWords.append(SightWord(category: SightWordCategory.kinder, wordText: sightWord))
            }
        }
        
        completion(.success(sightWords.sorted(by: {$0 < $1})))
    }
}
