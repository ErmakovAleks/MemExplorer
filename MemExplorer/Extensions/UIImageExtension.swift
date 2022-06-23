//
//  UIImageExtension.swift
//  MemExplorer
//
//  Created by Александр Ермаков on 23.06.2022.
//

import UIKit

extension UIImage {
    func scalePreservingAspectRatio(targetSize: CGFloat) -> UIImage {
      
        let widthRatio = targetSize / size.width
        let heightRatio = targetSize / size.height
        
        let scaleFactor = min(widthRatio, heightRatio)

        let scaledImageSize = CGSize(
            width: size.width * scaleFactor,
            height: size.height * scaleFactor
        )
        
        print("New image width: \(scaledImageSize.width), height: \(scaledImageSize.height)")
        
        let renderer = UIGraphicsImageRenderer(
            size: scaledImageSize
        )
        
        let scaledImage = renderer.image { _ in
            self.draw(in: CGRect(
                origin: .zero,
                size: scaledImageSize
            ))
        }
        
        return scaledImage
    }
}
