//
//  ImageLoader.swift
//  PriceTracker
//
//  Created by dread on 23.01.2025.
//

import Foundation
import UIKit

final class ImageLoader {
    static let shared = ImageLoader()
    private var imageCache = NSCache<NSURL, UIImage>()
    
    private init() {}
    
    func loadImage(_ imageURL: URL?, completion: @escaping (UIImage?) -> Void) {
        guard let url = imageURL else {
            completion(nil)
            return
        }
        
        if let cachedImage = imageCache.object(forKey: url as NSURL) {
            completion(cachedImage)
            return
        }
        
        DispatchQueue.global().async {
            guard let data = try? Data(contentsOf: url),
                  let image = UIImage(data: data) else {
                let noImage = UIImage(named: "no_image")
                self.imageCache.setObject(noImage!, forKey: url as NSURL)
                DispatchQueue.main.async {
                    completion(noImage)
                }
                return
            }
            
            self.imageCache.setObject(image, forKey: url as NSURL)
            
            DispatchQueue.main.async {
                completion(image)
            }
        }
    }
}


