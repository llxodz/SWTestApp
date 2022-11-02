//
//  UnsplashService.swift
//  SWTestApp
//
//  Created by Ilya Gavrilov on 01.11.2022.
//

import Foundation
import Combine

protocol UnsplashService {
    func request(from endpoint: UnsplashAPI, page: Int) -> AnyPublisher<[PhotoModel], APIError>?
}

struct UnsplashServiceBase: UnsplashService {
    
    func request(from endpoint: UnsplashAPI, page: Int) -> AnyPublisher<[PhotoModel], APIError>? {
        guard let request = endpoint.urlRequest(page: page) else { return nil }
        
        return URLSession
            .shared
            .dataTaskPublisher(for: request)
            .receive(on: DispatchQueue.main)
            .mapError { _ in APIError.unknown }
            .flatMap { data, response -> AnyPublisher<[PhotoModel], APIError> in
                guard let response = response as? HTTPURLResponse else
                {
                    return Fail(error: APIError.unknown).eraseToAnyPublisher()
                }
                
                if (200...299).contains(response.statusCode) {
                    let jsonDecoder = JSONDecoder()
                    jsonDecoder.dateDecodingStrategy = .iso8601
                    return Just(data)
                        .decode(type: [PhotoModel].self, decoder: jsonDecoder)
                        .mapError { _ in APIError.decodingError }
                        .eraseToAnyPublisher()
                } else {
                    return Fail(error: APIError.errorCode(response.statusCode))
                        .eraseToAnyPublisher()
                }
            }
            .eraseToAnyPublisher()
    }
}
