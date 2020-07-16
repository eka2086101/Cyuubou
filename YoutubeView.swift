//
//  YoutubeView.swift
//  CyuubouLand
//
//  Created by Miki Arakawa on 2020/07/14.
//  Copyright © 2020 Miki Arakawa. All rights reserved.
//

import SwiftUI
import WebKit

struct YoutubeView: UIViewRepresentable {
    
    
    var url: String
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        //uiView.load(URLRequest(url: URL(string: url)!))
  
    }
}

struct YoutubeView_Previews: PreviewProvider {
    static var previews: some View {
        YoutubeView(url: "https://www.rutles.net")
    }
}
