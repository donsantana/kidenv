//
//  SearchResultView.swift
//  Kidenv
//
//  Created by Done Santana on 3/4/24.
//

import SwiftUI


extension String {
//    func load() -> UIImage {
//        var image = UIImage()
//        do {
//            guard let url = URL(string: self) else {return UIImage()}
//            DispatchQueue.global().async {
//                let data: Data = try Data(contentsOf: url)
//                image = UIImage(data: data)!
//            }
//            
//        } catch {
//            print(error)
//        }
//        return UIImage()
//    }
}
struct SearchResultView: View {
    @State var itemList: [GoogleData.Item]
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(spacing: 20) {
                ForEach(itemList, id: \.title) { item in
                    if let imageUrl = item.pagemap.metatags.first?.ogImage {
                        AsyncImage(url: URL(string: imageUrl)) {phase in
                            switch phase {
                            case .empty:
                                LoadingView()
                            case .success(let image):
                                image.resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: UIScreen.main.bounds.width)
                            case .failure:
                                Image(systemName: "photo")
                            @unknown default:
                                // Since the AsyncImagePhase enum isn't frozen,
                                // we need to add this currently unused fallback
                                // to handle any new cases that might be added
                                // in the future:
                                EmptyView()
                            }
                        }
                    }
                }
            }
        }
    }
}
//
//#Preview {
//    SearchResultView(index: 0)
//}
