//
//  PictureCell.swift
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

struct PhotoCell: View {
    let imageURL: String
    
    var body: some View {
        AnimatedImage(url: URL(string: imageURL))
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: Constants.imageWidth, height: Constants.imageHeight)
            .cornerRadius(Constants.imageCornerRadius)
    }
}

struct PictureCell_Previews: PreviewProvider {
    static var previews: some View {
        PhotoCell(imageURL: "")
    }
}
