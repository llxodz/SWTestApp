//
//  HStackPhotosView.swift
//  SWTestApp
//
//  Created by Ilya Gavrilov on 02.11.2022.
//

import SwiftUI
import SDWebImageSwiftUI

private enum Constants {
    static let imageHeight: CGFloat = 200
    static let imageWidth: CGFloat = (UIScreen.main.bounds.width - 50) / 2
    static let imageCornerRadius: CGFloat = 12
}

struct HStackPhotosView: View {
    
    let photos: [PhotoModel]
    let onTileCallback: ((PhotoModel) -> Void)?
    
    init(_ pictures: [PhotoModel], onTileAppear: ((PhotoModel) -> Void)? = nil) {
        self.photos = pictures
        self.onTileCallback = onTileAppear
    }

    private var splitArray: [[PhotoModel]] {
        var result: [[PhotoModel]] = []
        var list1: [PhotoModel] = []
        var list2: [PhotoModel] = []
        
        photos.forEach { photo in
            let index = photos.firstIndex {$0.id == photo.id }
            
            if let index = index {
                if index % 2 == 0  {
                    list1.append(photo)
                } else {
                    list2.append(photo)
                }
            }
        }
        
        result.append(list1)
        result.append(list2)
        return result
    }
    
    var body: some View {
        HStack(alignment: .top) {
            LazyVStack(spacing: 8) {
                ForEach(splitArray[0]) { photo in
                    NavigationLink(destination: DetailPhotoView(imageURL: photo.urls.full)) {
                        PhotoCell(imageURL: photo.urls.thumb)
                            .onAppear(perform: {onAppearClosure(photo)})
                    }
                }
            }
            LazyVStack(spacing: 8) {
                ForEach(splitArray[1]) { photo in
                    NavigationLink(destination: DetailPhotoView(imageURL: photo.urls.full)) {
                        PhotoCell(imageURL: photo.urls.thumb)
                            .onAppear(perform: {onAppearClosure(photo)})
                    }
                }
            }
        }
    }
    
    private func onAppearClosure(_ photo: PhotoModel) {
        guard let onTileCallback = onTileCallback else {
            return
        }
        onTileCallback(photo)
    }
}
