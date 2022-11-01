//
//  PhotoModel.swift
//  SWTestApp
//
//  Created by Ilya Gavrilov on 01.11.2022.
//

import Foundation

struct PhotoModel: Identifiable, Codable {
    let id: String
    let urls: [String : String]
}
