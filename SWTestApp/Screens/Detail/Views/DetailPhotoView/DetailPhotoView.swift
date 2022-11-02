//
//  DetailView.swift
//  SWTestApp
//
//  Created by Ilya Gavrilov on 02.11.2022.
//

import SwiftUI
import SDWebImageSwiftUI

private enum Constants {
    static let imageHeight: CGFloat = 300
}

struct DetailPhotoView: View {
    
    let imageURL: String
    
    var body: some View {
        WebImage(url: URL(string: imageURL))
            .resizable()
            .indicator(.activity)
            .scaledToFill()
            .frame(width: UIScreen.main.bounds.width, height: Constants.imageHeight, alignment: .center)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailPhotoView(imageURL: "")
    }
}
