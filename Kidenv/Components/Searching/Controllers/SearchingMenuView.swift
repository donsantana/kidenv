//
//  SearchingMenu.swift
//  Kidenv
//
//  Created by Done Santana on 3/13/24.
//

import SwiftUI

struct SearchMenuOption: Identifiable {
    var id = UUID()
    var title, imageName, searchQuery: String
}

struct SearchingMenuView: View {
    @State private var showingSearchView = false

    let parent: UIViewController
    private let menuOptions = [
        SearchMenuOption(title: "Cars", imageName: "carsIcon", searchQuery: "toyota models pictures"),
        SearchMenuOption(title: "Flags", imageName: "flagsIcon", searchQuery: "all+countries+flags+images")
    ]
    private let adaptativeColumns = [GridItem(.adaptive(minimum: 150))]
    
    var body: some View {
        var searchWordSelected = ""
        TopBar(previousView: parent)
        ScrollView {
            LazyVGrid(columns: adaptativeColumns) {
                ForEach(menuOptions) { menuOption in
                    Image(menuOption.imageName)
                        .resizable()
                        .frame(width: 150,height: 150)
                        .padding(.bottom, 25)
                        .shadow(radius: 25)
                        .clipShape(.rect(cornerRadius: 25))
                        .onTapGesture {
                            searchWordSelected = menuOption.searchQuery
                            showingSearchView = true
                        }
                        .fullScreenCover(isPresented: $showingSearchView, content: {SearchKidView(searchWord: searchWordSelected)})
                }
                //            VStack{
                //            ForEach(menuOptions) { menuOption in
                //                    NavigationLink {
                //                        SearchKidView(searchWord: menuOption.searchQuery)
                //                    } label: {
                //                        Image(menuOption.imageName)
                //                            .resizable()
                //                            .frame(width: 200,height: 200)
                //                            .padding(.bottom, 25)
                //                            .shadow(radius:25)
                //                            .clipShape(.rect(cornerRadius: 25))
                //                        //                        .onTapGesture {
                //                        //                            showingSearchView = true
                //                        //                        }
                //                    }
                //                }
                //            }
            }
            
        }
    }
}

#Preview {
    SearchingMenuView(parent: UIViewController())
}
