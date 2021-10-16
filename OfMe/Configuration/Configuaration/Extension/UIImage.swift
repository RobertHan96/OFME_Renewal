import Foundation
import UIKit
import Kingfisher

extension UIImage {    
    func imageWithColor(tintColor: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        let context = UIGraphicsGetCurrentContext()!
        context.translateBy(x: 0, y: self.size.height)
        context.scaleBy(x: 1.0, y: -1.0);
        context.setBlendMode(.normal)

        let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height) as CGRect
        context.clip(to: rect, mask: self.cgImage!)
        tintColor.withAlphaComponent(0.2).setFill()
        context.fill(rect)

        let newImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()

        return newImage
    }
    
    func resizeImage() -> UIImage {
        let bound = UIScreen.main.bounds
        let newHeight = (bound.width / bound.height) * self.size.height
        let newWidth = (bound.height / bound.width) * self.size.width
        let newSize = CGSize(width: newWidth, height: newHeight)
        let renderer = UIGraphicsImageRenderer(size: newSize)

        return renderer.image { _ in
            self.draw(in: CGRect(origin: .zero, size: newSize))
        }
    }
    
    func resizeImage(width: CGFloat, height: CGFloat) -> UIImage {
        let newHeight = height * self.size.height
        let newWidth = width * self.size.width
        let newSize = CGSize(width: newWidth, height: newHeight)
        let renderer = UIGraphicsImageRenderer(size: newSize)

        return renderer.image { _ in
            self.draw(in: CGRect(origin: .zero, size: newSize))
        }
    }
}
