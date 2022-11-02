//
//  MainViewModel.swift
//  SWTestApp
//
//  Created by Ilya Gavrilov on 01.11.2022.
//

import Foundation
import Combine

protocol MainViewModel {
    func getPhotos()
}

class MainViewModelBase: ObservableObject, MainViewModel {
    
    private let service: UnsplashService
    private(set) var photos = [PhotoModel]()
    private var cancellables = Set<AnyCancellable>()
    private var page: Int = 0
    
    @Published private(set) var state: ResultState = .loading
    
    init(service: UnsplashService) {
        self.service = service
    }
    
    func getPhotos() {
        let cancellable = service
            .request(from: .getPhotos, page: self.page)?
            .sink { [weak self] result in
                switch result {
                case .finished: break
                case .failure(let error):
                    guard let self = self else { return }
                    self.state = .failed(error: error)
                }
            } receiveValue: { [weak self] response in
                guard let self = self else {return}
                self.photos.append(contentsOf: response)
                self.state = .success(content: self.photos)
                self.page += 10
            }
        guard let cancellable = cancellable else { return }
        self.cancellables.insert(cancellable)
    }
}
