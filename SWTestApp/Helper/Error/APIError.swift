//
//  APIError.swift
//  SWTestApp
//
//  Created by Ilya Gavrilov on 01.11.2022.
//

import Foundation

enum APIError: Error {
    case decodingError
    case errorCode(Int)
    case unknown
}

extension APIError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .decodingError:
            return "Не удалось декодировать объект"
        case .errorCode(let code):
            return "\(code) - статус ошибки от сервера"
        case .unknown:
            return "Ошибка неизвестна"
        }
    }
}
