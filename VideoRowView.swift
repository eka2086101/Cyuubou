//
//  VideoRowView.swift
//  YoutubeSearch1
//
//  Created by 大津 真 on 2020/01/11.
//  Copyright © 2020 大津真. All rights reserved.
//

import SwiftUI
import URLImage

struct VideoRowView: View {
	@State var title: String
	let imgURL: String
	@State var description: String
	
    var body: some View {
		HStack{
			URLImage(URL(string: imgURL)!) {proxy in
				proxy.image
					.resizable()
					.scaledToFit()
			}
			.frame(width: 120, height: 90)
			.border(Color.yellow)
			VStack{
				Text(title)
					.font(.headline)
				Text(description)
					.font(.caption)
					.lineLimit(3)
			}			
		}
    }
}

struct VideoRowView_Previews: PreviewProvider {
    static var previews: some View {
		VideoRowView(title: "これはタイトル", imgURL: "https://o2-m.com/dog1.png", description: "これは動画の説明です。これは動画の説明です。これは動画の説明です。これは動画の説明です。これは動画の説明です。これは動画の説明です。これは動画の説明です。これは動画の説明です。")
    }
}
