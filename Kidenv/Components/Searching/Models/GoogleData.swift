//
//  GoogleData.swift
//  Kidenv
//
//  Created by Done Santana on 3/4/24.
//

import Foundation


struct GoogleData: Codable {
    let items: [Item]
    
    struct Item: Codable {
        //var id = UUID()
        let title: String?
        let snippet: String?
        let link: String?
        let pagemap: Pagemap
        
        struct Pagemap: Codable {
            let metatags: [Metatag]
            
            struct Metatag: Codable {
                let ogImage: String?
                let ogTitle: String?
                enum CodingKeys: String, CodingKey {
                    case ogImage = "og:image"
                    case ogTitle = "og:title"
                }
            }
        }
    }
}
