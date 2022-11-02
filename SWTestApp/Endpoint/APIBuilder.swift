//
//  APIBuilder.swift
//  SWTestApp
//
//  Created by Ilya Gavrilov on 01.11.2022.
//

import Foundation

protocol APIBuilder {
    func urlRequest(page: Int) -> URLRequest?
    var baseUrl: URL { get }
    var path: String { get }
    var apiKey: String { get }
}

enum UnsplashAPI {
    case getPhotos
}

extension UnsplashAPI: APIBuilder {
    
    var baseUrl: URL {
        switch self {
        case .getPhotos:
            return URL(string: "https://api.unsplash.com/")!
        }
    }
    
    var path: String {
        switch self {
        case .getPhotos: return "/photos"
        }
    }
    
    var apiKey: String {
        guard let apiKey = Bundle.main.infoDictionary?["apiKey"] as? String else { return "" }
        return apiKey
    }
    
    func urlRequest(page: Int) -> URLRequest? {
        let url = URL(string: "\(self.baseUrl)\(self.path)?client_id=\(self.apiKey)&page=\(page)&content_filter=high")
        guard let url = url else { return nil }
        
        return URLRequest(url: url)
    }
}
