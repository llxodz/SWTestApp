//
//  ContentView.swift
//  SWTestApp
//
//  Created by Ilya Gavrilov on 01.11.2022.
//

import SwiftUI

private enum Constants {
    static let lazyGridSpacing: CGFloat = 16
}

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
                    LazyVGrid(columns: grids, spacing: Constants.lazyGridSpacing) {
                        ForEach(response) { response in
                            PhotoCell(imageURL: response.urls.thumb)
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
