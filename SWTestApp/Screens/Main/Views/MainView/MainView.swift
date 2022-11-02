//
//  MainView.swift
//  SWTestApp
//
//  Created by Ilya Gavrilov on 01.11.2022.
//

import SwiftUI

private enum Constants {
    static let lazyGridSpacing: CGFloat = 16
    
    static let titleLabel: String = "Photos"
}

struct MainView: View {
    
    @StateObject var viewModel = MainViewModelBase(service: UnsplashServiceBase())
    
    var body: some View {
        ZStack {
            switch viewModel.state {
            case .loading: ProgressView()
            case .failed(let error): Text(error.localizedDescription)
            case .success(let photos):
                NavigationView {
                    ScrollView(.vertical, showsIndicators: false) {
                        HStackPhotosView(photos) { photo in
                            checkUpdatePhotos(photos, photo)
                        }
                    }
                    .navigationTitle(Constants.titleLabel)
                }
            }
        }
        .onAppear(perform: viewModel.getPhotos)
    }
    
    private func checkUpdatePhotos(_ photos: [PhotoModel], _ photo: PhotoModel) {
        guard let lastPhoto = photos.last else { return }
        if lastPhoto.id == photo.id {
            viewModel.getPhotos()
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
