//
//  ApiBuilder.swift
//  SWTestApp
//
//  Created by Ilya Gavrilov on 01.11.2022.
//

import Foundation

protocol APIBuilder {
    var urlRequest: URLRequest { get }
    var baseUrl: URL { get }
    var path: String { get }
    var apiKey: String { get }
}

enum UnSplashAPI {
    case getPhotos
}

extension UnSplashAPI: APIBuilder {
    
    var baseUrl: URL {
        switch self {
        case .getPhotos:
            return URL(string: "https://api.unsplash.com/")!
        }
    }
    
    var path: String {
        return "/photos/random"
    }
    
    var urlRequest: URLRequest {
        let url = URL(string: "\(self.baseUrl)\(self.path)?count=30$client_id=\(self.apiKey)")
        print(url)
        return URLRequest(url: url!)
    }
    
    var apiKey: String {
        guard let apiKey = Bundle.main.infoDictionary?["apiKey"] as? String else { return "" }
        return apiKey
    }
}
