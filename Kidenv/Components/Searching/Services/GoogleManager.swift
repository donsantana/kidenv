//
//  GoogleManager.swift
//  Kidenv
//
//  Created by Done Santana on 3/4/24.
//

import Foundation

enum NetworkError: Error {
    case badResponse(statusCode: Int)
    case serverError(String)
    case invalidURL
    case noData
}

class GoogleManager: ObservableObject {
    @Published var items = ItemsData(allItems: [])
    @Published var images  = ImagesData(allImages: [])
    
    private static var sharedNetworkManager: GoogleManager = {
        let googleManager = GoogleManager()
        return googleManager
    }()
    
    class func shared() -> GoogleManager {
        return sharedNetworkManager
    }
    
    func anotherAPI(completion: @escaping (Result<ItemsData, NetworkError>) -> Void) {
        if let url = URL(string: "stringURL") {
            let session = URLSession(configuration: .default)
            session.dataTask(with: url, completionHandler: {data, response, error in
                
            })
        } else {
            completion(.failure(.invalidURL))
        }
    }
    
    func fetchGoogle(searchWord: String, completion: @escaping (Result<[GoogleData.Item],NetworkError>)->Void) {
        let urlString = "https://www.googleapis.com/customsearch/v1?q=\(searchWord)&key=\(GlobalStrings.Google.API_KEY)&cx=\(GlobalStrings.Google.API_ID)&sclient=photos"
        
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
           
            let task = session.dataTask(with: url) {(data, response, error) in
                if error != nil {
                    completion(.failure(.serverError(error!.localizedDescription)))
                    print(error!)
                    return
                }
                
                if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
                    completion(.failure(.badResponse(statusCode: response.statusCode)))
                    return
                }
                
                if let safeData = data {
                    do {
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        let responseItems = try decoder.decode(GoogleData.self, from: safeData)
                        completion(.success(responseItems.items))
//                        let thumbnail = responseItems.items.map({$0.pagemap.metatags.map({$0.ogImage})})
//                        let allImages = Array(thumbnail.joined())
//                        let title = responseItems.items.map({$0.litle})
//                        let description = responseItems.items.map({$0.snippet})
//                        let link = responseItems.items.map({$0.link})
//                        
//                        DispatchQueue.main.async {
//                            let googleImages = GoogleImage(image: allImages)
//                            GoogleManager.shared().images.allImages.append(googleImages)
//                        }
//                        
//                        let googleResult = GoogleModel(title: title, description: description, link: link)
//                        DispatchQueue.main.async {
//                            GoogleManager.shared().items.allItems.append(googleResult)
//                        }
                        
                    } catch {
                        completion(.failure(.noData))
                        print(error)
                    }
                }
            }
            task.resume()
        }
//
//        [{"category":"FIRST GRADE","word_list":["always", "around", "because", "been", "before", "best", "both", "buy", "call", "cold", "does", "don't", "fast", "first", "five", "found", "gave", "goes", "green", "its", "made", "many", "off", "or", "pull", "read", "right", "sing", "sit", "sleep", "tell", "their", "these", "those", "upon", "us", "use", "very", "wash", "which", "why", "wish", "work", "would", "write", "your",
//            ]
    }
}
