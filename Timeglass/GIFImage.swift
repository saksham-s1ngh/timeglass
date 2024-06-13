//
//  GIFImage.swift
//  Timeglass
//
//  Created by Saksham Malhotra on 12/06/24.
//

import SwiftUI
import WebKit

struct GIFImage: UIViewRepresentable {
    private let imageName: String
    @Binding var replay: Bool // to control replaying the hourglass GIF
    
    init(_ name: String, replay: Binding<Bool>){
        self.imageName = name
        self._replay = replay
    }
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        let url = Bundle.main.url(forResource: imageName, withExtension: "gif")!
        let data = try! Data(contentsOf: url)
        
        webView.load(
            data,
            mimeType: "image/gif",
            characterEncodingName: "UTF-8",
            baseURL: url.deletingLastPathComponent()
        )
        
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        if replay {
            let url = Bundle.main.url(forResource: imageName, withExtension: "gif")!
            let data = try! Data(contentsOf: url)
            
            uiView.load(
                data,
                mimeType: "image/gif",
                characterEncodingName: "UTF-8",
                baseURL: url.deletingLastPathComponent()
            )
            
            replay = false
        }
    }

  
}

#Preview {
    GIFImage("hourglass2", replay: .constant(true))
}
