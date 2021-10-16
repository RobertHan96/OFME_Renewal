import UIKit

extension UITextField {
    func addLeftPadding() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    
    func addRightFalse() {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 25, height: 55))
        let imageView = UIImageView(image: UIImage(named: ImgName.imgName(of: .falseCheck)))
        imageView.frame = CGRect(x: 0, y: 25, width: imageView.frame.width, height: imageView.frame.height)
        view.addSubview(imageView)
        self.rightView = view
        self.leftViewMode = .always
    }
    
    func addRightTrue() {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 25, height: 55))
        let imageView = UIImageView(image: UIImage(named: ImgName.imgName(of: .trueCheck)))
        imageView.frame = CGRect(x: 0, y: 25, width: imageView.frame.width, height: imageView.frame.height)
        view.addSubview(imageView)
        self.rightView = view
        self.leftViewMode = .always
    }
}
