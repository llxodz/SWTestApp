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
    
    private let service: UnSplashService
    private(set) var photos = [PhotoModel]()
    private var cancellables = Set<AnyCancellable>()
    
    @Published private(set) var state: ResultState = .loading
    
    init(service: UnSplashService) {
        self.service = service
    }
    
    func getPhotos() {
        self.state = .loading
        
        let cancellable = service
            .request(from: .getPhotos)
            .sink { result in
                switch result {
                case .finished:
                    self.state = .success(content: self.photos)
                case .failure(let error):
                    self.state = .failed(error: error)
                }
            } receiveValue: { response in
                self.photos.append(contentsOf: response)
            }
        self.cancellables.insert(cancellable)
    }
}
