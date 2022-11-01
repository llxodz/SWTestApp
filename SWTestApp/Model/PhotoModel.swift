//
//  PhotoModel.swift
//  SWTestApp
//
//  Created by Ilya Gavrilov on 01.11.2022.
//

import Foundation

// MARK: - PhotoModel
struct PhotoModel: Identifiable, Codable {
    let id: String
    let urls: Urls
}

// MARK: - URLs
struct Urls: Codable {
    let raw, full, regular, small: String
    let thumb, smallS3: String

    enum CodingKeys: String, CodingKey {
        case raw, full, regular, small, thumb
        case smallS3 = "small_s3"
    }
}
