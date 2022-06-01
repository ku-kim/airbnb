//
//  ImageManager.swift
//  AirbnbApp
//
//  Created by 김상혁 on 2022/05/29.
//

import Foundation
import Alamofire
import UIKit.UIImage

class ImageManager {
    
    private let fileManager = FileManager()
    
    func fetchImage(from url: URL?, completion: @escaping (UIImage?) -> Void) {
        
        guard let url = url else { return } // TODO: 에러 처리하기
        
        let fileName = url.lastPathComponent
        
        guard let cachesDirectory = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first else {
            return
        }
        
        let destination = cachesDirectory.appendingPathComponent(fileName)
        
        if fileManager.fileExists(atPath: destination.path) {
            let image = UIImage(contentsOfFile: destination.path)
            completion(image)
            return
        }
        
        let request = AF.download(url)
        
        request.response { [weak self] response in
            if response.error == nil, // TODO: 에러 처리하기
               let filePath = response.fileURL {
                try? self?.fileManager.copyItem(at: filePath, to: destination)
                let image = UIImage(contentsOfFile: destination.path)
                completion(image)
            }
        }
    }
    
}
