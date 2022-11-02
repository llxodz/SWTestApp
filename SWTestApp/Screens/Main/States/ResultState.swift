//
//  ResultState.swift
//  SWTestApp
//
//  Created by Ilya Gavrilov on 01.11.2022.
//

import Foundation

enum ResultState {
    case loading
    case success(content: [PhotoModel])
    case failed(error: Error)
}
