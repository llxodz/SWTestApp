//
//  UnSplashService.swift
//  SWTestApp
//
//  Created by Ilya Gavrilov on 01.11.2022.
//

import Foundation
import Combine

protocol UnSplashService {
    func request(from endpoint: UnSplashAPI) -> AnyPublisher<>
}
