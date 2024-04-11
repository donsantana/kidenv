//
//  SearchKid.swift
//  Kidenv
//
//  Created by Done Santana on 3/4/24.
//

import SwiftUI

//TODO: - Implement the Search menu using the ImageType struct
struct SearchKidView: View {
    @State var itemsList: [GoogleData.Item]?
    @State private var fetch = GoogleManager()
    @State var searchWord = "Toyota+Rav4+car+image"
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack () {
            HStack() {
                Spacer()
                Button() {
                    dismiss()
                }label: {
                    Image("barCloseBtn")
                }
            }.padding(.all,10)
            ScrollView(.vertical) {
                if let itemsList = itemsList {
                    SearchResultView(itemList: itemsList)
                } else {
                    LoadingView()
                }
                
            }
        }
        .onAppear {
            fetch.fetchGoogle(searchWord: searchWord, completion: {result in
                switch result {
                case .success(let items):
                    itemsList = items
                case .failure(let error):
                    print(error.localizedDescription)
                }
            })
        }
    }
}

//#Preview {
//    //SearchKid(parent: UIViewController())
//}
