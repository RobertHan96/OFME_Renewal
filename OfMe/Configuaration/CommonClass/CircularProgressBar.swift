import UIKit

class CircularProgressBar: UIView, CAAnimationDelegate {
    private var progress: CGFloat = 0
    private var rect: CGRect = CGRect()
    private var circleLayer = CAShapeLayer()
    private var progressLayer = CAShapeLayer()
    private var startPoint = CGFloat(-Double.pi / 2)
    private var endPoint = CGFloat(3 * Double.pi / 2)
    private let gradientLayer: CAGradientLayer = CAGradientLayer()
    
    init(frame: CGRect, progress: CGFloat) {
        super.init(frame: frame)
        self.rect = frame
        self.progress = progress
        self.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        createCircularPath(rect: rect)
    }
    
    func createCircularPath(rect: CGRect) {
        // created circularPath for circleLayer and progressLayer
        var circularPath = UIBezierPath(
                arcCenter: CGPoint(
                x: rect.origin.x,
                y: rect.origin.y),
                radius: 20, startAngle: startPoint,
                endAngle: startPoint+endPoint*progress,
                clockwise: true)
        if progress == 1 {
            circularPath = UIBezierPath(
                arcCenter: CGPoint(
                x: rect.origin.x,
                y: rect.origin.y),
                radius: 20, startAngle: startPoint,
                endAngle: endPoint,
                clockwise: true)
        }
        // circleLayer path defined to circularPath
        circleLayer.path = circularPath.cgPath
        // ui edits
        circleLayer.fillColor = nil
        circleLayer.lineCap = .round
        circleLayer.lineWidth = 6.0
        circleLayer.strokeEnd = 1.0
        circleLayer.strokeColor = UIColor.white.cgColor
        circleLayer.backgroundColor = UIColor.white.cgColor
        // added circleLayer to layer
        layer.addSublayer(circleLayer)
        // progressLayer path defined to circularPath
        progressLayer.path = circularPath.cgPath
        // ui edits
        progressLayer.fillColor = nil
        progressLayer.lineCap = .round
        progressLayer.lineWidth = 3.0
        progressLayer.strokeEnd = 0
        progressLayer.strokeColor = UIColor.black.cgColor
        
        // added progressLayer to layer
        layer.addSublayer(progressLayer)
        
        self.gradientLayer.colors = [UIColor.gradientLeft.cgColor, UIColor.gradientRight.cgColor]
        self.gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.5)
        self.gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.0)
        self.gradientLayer.type = .conic
        self.gradientLayer.frame = CGRect(x: rect.origin.x-22.5,
                                          y: rect.origin.x-22.5,
                                          width: 45,
                                          height: 45)
        self.gradientLayer.shadowPath = circularPath.cgPath
        self.layer.addSublayer(self.gradientLayer)
        self.layer.mask = progressLayer
    }
    
    func progressAnimation(duration: TimeInterval) {
        // created circularProgressAnimation with keyPath
        let circularProgressAnimation = CABasicAnimation(keyPath: "strokeEnd")
        // set the end time
        circularProgressAnimation.duration = duration
        circularProgressAnimation.toValue = 1.0
        circularProgressAnimation.fillMode = .forwards
        circularProgressAnimation.isRemovedOnCompletion = false
        progressLayer.add(circularProgressAnimation, forKey: "progressAnim")
    }
}
