//
//  ContentView.swift
//  SWTestApp
//
//  Created by Ilya Gavrilov on 01.11.2022.
//

import SwiftUI
import SDWebImageSwiftUI

struct MainView: View {
    
    @StateObject var viewModel = MainViewModelBase(service: UnSplashServiceBase())
    
    private var grids = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        
        Group {
            switch viewModel.state {
            case .loading: ProgressView()
            case .failed(let error): Text("\(error.localizedDescription)")
            case .success(let response):
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVGrid(columns: grids, spacing: 20) {
                        ForEach(response) { response in
                            AnimatedImage(url: URL(string: response.urls["thumb"]!))
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: (UIScreen.main.bounds.width - 50) / 2, height: 200)
                                .cornerRadius(15)
                        }
                    }
                }
            }
        }
        .onAppear(perform: viewModel.getPhotos)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
