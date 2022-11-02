//
//  HStackPhotosView.swift
//  SWTestApp
//
//  Created by Ilya Gavrilov on 02.11.2022.
//

import SwiftUI
import SDWebImageSwiftUI

private enum Constants {
    static let spacingLazyVStack: CGFloat = 8
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
        var firstList: [PhotoModel] = []
        var secondList: [PhotoModel] = []
        
        photos.forEach { photo in
            let index = photos.firstIndex {$0.id == photo.id }
            
            if let index = index {
                if index % 2 == 0  {
                    firstList.append(photo)
                } else {
                    secondList.append(photo)
                }
            }
        }
        
        result.append(firstList)
        result.append(secondList)
        return result
    }
    
    var body: some View {
        HStack(alignment: .top) {
            LazyVStack(spacing: Constants.spacingLazyVStack) {
                ForEach(splitArray[0]) { photo in
                    NavigationLink(destination: DetailPhotoView(imageURL: photo.urls.full)) {
                        PhotoCell(imageURL: photo.urls.thumb)
                            .onAppear(perform: { onAppearClosure(photo) })
                    }
                }
            }
            LazyVStack(spacing: Constants.spacingLazyVStack) {
                ForEach(splitArray[1]) { photo in
                    NavigationLink(destination: DetailPhotoView(imageURL: photo.urls.full)) {
                        PhotoCell(imageURL: photo.urls.thumb)
                            .onAppear(perform: { onAppearClosure(photo) })
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
