//
//  UIImage.swift
//  NiceTube
//

import CoreImage

public extension CIImage {
    func resized(size: CGSize) -> CIImage {
        let scaleX = size.width / extent.width
        let scaleY = size.height / extent.height
        let transform = CGAffineTransform(scaleX: scaleX, y: scaleY)
        let scaledImage = transformed(by: transform)
        return scaledImage
    }
}
