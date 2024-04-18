//
//  ImageRequestManager.swift
//  CocinaChallenge
//
//  Created by William Brando Estrada Tepec on 16/04/24.
//

import Foundation
import UIKit


class ImageRequestManager {
    private static let _shared = ImageRequestManager()
    static var shared: ImageRequestManager { return _shared }
    let imageCache = NSCache<NSString,UIImage>()
    
    func downloadImg(url: URL, completion: @escaping(_ image: UIImage?, _ error: Error?, _ onCache: Bool )->Void) {
        if let cacheImg = imageCache.object(forKey: url.absoluteString as NSString) {
            completion(cacheImg, nil, true)
        } else {
            let configuration = URLSessionConfiguration.default
            configuration.timeoutIntervalForRequest = 100
            let session = URLSession(configuration: configuration)

            let task = session.dataTask(with: url){ (data, response, error) in
                
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 ,let mimeType = response.mimeType,  mimeType.contains("image"), let data = data, let image = UIImage(data: data) else {
                    //completion(nil,nil,false)
                    return }
                if let error = error {
                    completion(nil,error,false)
                } else {
                    self.imageCache.setObject(image, forKey: url.absoluteString as NSString)
                    completion(image,nil,false)
                }   
            }
            task.resume()
        }
    }
}
