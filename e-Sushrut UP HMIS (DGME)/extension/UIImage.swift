//
//  File.swift
//  e-Sushrut HMIS SAIL Rourkela
//
//  Created by sudeep rai on 12/06/22.
//

import Foundation
import UIKit
extension UIImage {

    convenience init?(barcode: String) {
        let data = barcode.data(using: .ascii)
        guard let filter = CIFilter(name: "CICode128BarcodeGenerator") else {
            return nil
        }
        filter.setValue(data, forKey: "inputMessage")
        guard let ciImage = filter.outputImage else {
            return nil
        }
        self.init(ciImage: ciImage)
    }

    func rotate(radians: Float) -> UIImage? {
           var newSize = CGRect(origin: CGPoint.zero, size: self.size).applying(CGAffineTransform(rotationAngle: CGFloat(radians))).size
           // Trim off the extremely small float value to prevent core graphics from rounding it up
           newSize.width = floor(newSize.width)
           newSize.height = floor(newSize.height)

           UIGraphicsBeginImageContextWithOptions(newSize, false, self.scale)
           let context = UIGraphicsGetCurrentContext()!

           // Move origin to middle
           context.translateBy(x: newSize.width/2, y: newSize.height/2)
           // Rotate around middle
           context.rotate(by: CGFloat(radians))
           // Draw the image at its center
           self.draw(in: CGRect(x: -self.size.width/2, y: -self.size.height/2, width: self.size.width, height: self.size.height))

           let newImage = UIGraphicsGetImageFromCurrentImageContext()
           UIGraphicsEndImageContext()

           return newImage
       }
  
}
