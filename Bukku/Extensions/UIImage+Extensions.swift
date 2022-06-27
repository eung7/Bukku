//
//  UIImage+Extensions.swift
//  Bukku
//
//  Created by 김응철 on 2022/06/23.
//

import UIKit

extension UIImage {
    public var base64: String {
        return self.jpegData(compressionQuality: 1.0)!.base64EncodedString()
    }

    convenience init?(base64: String, withPrefix: Bool) {
        var finalData: Data?

        if withPrefix {
            guard let url = URL(string: base64) else { return nil }
            finalData = try? Data(contentsOf: url)
        } else {
            finalData = Data(base64Encoded: base64)
        }

        guard let data = finalData else { return nil }
        self.init(data: data)
    }
    
    func applyBlur_usingClamp(radius: CGFloat) -> UIImage {
        let context = CIContext()
        guard let ciImage = CIImage(image: self),
              let clampFilter = CIFilter(name: "CIAffineClamp"),
              let blurFilter = CIFilter(name: "CIGaussianBlur") else {
            return self
        }
        clampFilter.setValue(ciImage, forKey: kCIInputImageKey)
        blurFilter.setValue(clampFilter.outputImage, forKey: kCIInputImageKey)
        blurFilter.setValue(radius, forKey: kCIInputRadiusKey)
        guard let output = blurFilter.outputImage,
              let cgimg = context.createCGImage(output, from: ciImage.extent) else {
            return self
        }
        return UIImage(cgImage: cgimg)
    }
}
