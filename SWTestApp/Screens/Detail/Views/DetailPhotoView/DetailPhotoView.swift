//
//  DetailView.swift
//  SWTestApp
//
//  Created by Ilya Gavrilov on 02.11.2022.
//

import SwiftUI
import SDWebImageSwiftUI

struct DetailPhotoView: View {
    
    let imageURL: String
    
    var body: some View {
        AnimatedImage(url: URL(string: imageURL))
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: UIScreen.main.bounds.width - 16 / 2, height: (UIScreen.main.bounds.height - 12) / 2)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailPhotoView(imageURL: "")
    }
}
