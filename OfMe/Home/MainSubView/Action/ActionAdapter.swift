import UIKit

class ActionAdapter: NSObject {
    var selectedIdx: Int = -1
    
    
    weak var bottleButton: UIButton?
    weak var bedButton: UIButton?
    weak var sunButton: UIButton?
    weak var tvButton: UIButton?
    weak var handButton: UIButton?
    weak var resetButton: UIButton?
    weak var applyButton: UIButton?
    
    lazy var menuView: UIView = {
        let device = UIScreen.main.bounds
        let backgroundView = UIView(frame: CGRect(x: 0, y: 0, width: device.width, height: device.height))
        let view = UIView(frame: CGRect(x: 0, y: 0, width: device.width, height: 600))
        view.backgroundColor = .systemBackground
        backgroundView.backgroundColor = .init(white: 0, alpha: 0.42)
        backgroundView.addSubview(view)
        
        view.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(600)
        }
        
        let cancelButton = UIButton()
        cancelButton.setImage(UIImage(named: ImgName.imgName(of: .cancel)), for: .normal)
        view.cornerRadius = 35
        view.addSubview(cancelButton)
        cancelButton.snp.makeConstraints { make in
            make.top.right.equalToSuperview().inset(25)
        }
        cancelButton.addTarget(self, action: #selector(cancelTouchDown(_:)), for: .touchDown)
        
        let titleLabel = UILabel()
        titleLabel.font = .Notos(.bold, size: 20)
        titleLabel.textColor = .mainBlue
        titleLabel.text = "아이템 선택하기"
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(35)
        }
        
        let descriptLabel = UILabel()
        descriptLabel.font = .Notos(.regular, size: 12)
        descriptLabel.textColor = .gray2
        descriptLabel.text = "아이템을 적용하면 캐릭터와 더 가까워질 수 있어요!\n아래 아이템 리스트에서 적용할 아이템을 선택해주세요"
        view.addSubview(descriptLabel)
        descriptLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(76)
        }
        
        let borderView = UIView(frame: device)
        borderView.backgroundColor = .lightGray
        view.addSubview(borderView)
        borderView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(40)
            make.top.equalToSuperview().inset(127)
            make.height.equalTo(1)
        }
        
        let bottleButton = UIButton()
        bottleButton.tag = 0
        bottleButton.setImage(UIImage(named: ImgName.imgName(of: .unchecked)), for: .normal)
        bottleButton.setAttributedTitle(makeAttributedText(text: "물마시기"), for: .normal)
        bottleButton.imageEdgeInsets.left = -20
        self.bottleButton = bottleButton
        let bottleImageView = UIImageView(image: UIImage(named: ImgName.imgName(of: .bottle)))
        bottleImageView.tag = 0
        bottleImageView.isUserInteractionEnabled = true
        bottleImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(bottleGesture(gesture:))))
        view.addSubview(bottleButton)
        view.addSubview(bottleImageView)
        bottleButton.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(40)
            make.top.equalTo(borderView).offset(100)
        }
        bottleImageView.snp.makeConstraints { make in
            make.top.equalTo(bottleButton).offset(-bottleImageView.frame.height-5)
            make.centerX.equalTo(bottleButton)
        }
        
        let bedButton = UIButton()
        bedButton.tag = 1
        bedButton.setImage(UIImage(named: ImgName.imgName(of: .unchecked)), for: .normal)
        bedButton.setAttributedTitle(makeAttributedText(text: "낮잠자기"), for: .normal)
        bedButton.imageEdgeInsets.left = -20
        let bedImageView = UIImageView(image: UIImage(named: ImgName.imgName(of: .bed)))
        bedImageView.tag = 1
        [bedButton, bedImageView].forEach { view.addSubview($0) }
        bedImageView.isUserInteractionEnabled = true
        bedImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(bedGesture(gesture:))))
        bedButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(borderView).offset(100)
        }
        bedImageView.snp.makeConstraints { make in
            make.top.equalTo(bottleButton).offset(-bedImageView.frame.height-5)
            make.centerX.equalTo(bedButton)
        }
        
        let sunButton = UIButton()
        sunButton.tag = 2
        sunButton.setImage(UIImage(named: ImgName.imgName(of: .unchecked)), for: .normal)
        sunButton.setAttributedTitle(makeAttributedText(text: "햇빛보기"), for: .normal)
        sunButton.imageEdgeInsets.left = -20
        let sunImageView = UIImageView(image: UIImage(named: ImgName.imgName(of: .sun)))
        [sunButton, sunImageView].forEach { view.addSubview($0) }
        sunImageView.isUserInteractionEnabled = true
        sunImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(sunGesture(gesture:))))
        sunButton.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(40)
            make.top.equalTo(borderView).offset(100)
        }
        sunImageView.snp.makeConstraints { make in
            make.top.equalTo(bottleButton).offset(-sunImageView.frame.height-5)
            make.centerX.equalTo(sunButton)
        }
        
        let tvButton = UIButton()
        tvButton.tag = 3
        tvButton.setImage(UIImage(named: ImgName.imgName(of: .unchecked)), for: .normal)
        tvButton.setAttributedTitle(makeAttributedText(text: "티비보기"), for: .normal)
        tvButton.imageEdgeInsets.left = -20
        let tvImageView = UIImageView(image: UIImage(named: ImgName.imgName(of: .tv)))
        tvImageView.tag = 0
        tvImageView.isUserInteractionEnabled = true
        tvImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tvGesture(gesture:))))
        view.addSubview(tvButton)
        view.addSubview(tvImageView)
        tvButton.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(40)
            make.bottom.equalTo(bottleButton).offset(100)
        }
        tvImageView.snp.makeConstraints { make in
            make.top.equalTo(tvButton).offset(-tvImageView.frame.height-5)
            make.centerX.equalTo(tvButton)
        }
        
        let handButton = UIButton()
        handButton.tag = 4
        handButton.setImage(UIImage(named: ImgName.imgName(of: .unchecked)), for: .normal)
        handButton.setAttributedTitle(makeAttributedText(text: "물구나무"), for: .normal)
        handButton.imageEdgeInsets.left = -20
        let handImageView = UIImageView(image: UIImage(named: ImgName.imgName(of: .hand)))
        handImageView.isUserInteractionEnabled = true
        handImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handGesture(gesture:))))
        view.addSubview(handButton)
        view.addSubview(handImageView)
        handButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(bottleButton).offset(100)
        }
        handImageView.snp.makeConstraints { make in
            make.top.equalTo(handButton).offset(-handImageView.frame.height-5)
            make.centerX.equalTo(handButton)
        }
        
        let resetButton = UIButton()
        resetButton.tag = 5
        resetButton.setImage(UIImage(named: ImgName.imgName(of: .unchecked)), for: .normal)
        resetButton.setAttributedTitle(makeAttributedText(text: "돌아가기"), for: .normal)
        resetButton.imageEdgeInsets.left = -20
        let resetImageView = UIImageView(image: UIImage(named: ImgName.imgName(of: .reset)))
        resetImageView.tag = 0
        resetImageView.isUserInteractionEnabled = true
        resetImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(resetGesture(gesture:))))
        view.addSubview(resetButton)
        view.addSubview(resetImageView)
        resetButton.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(40)
            make.bottom.equalTo(bottleButton).offset(100)
        }
        resetImageView.snp.makeConstraints { make in
            make.top.equalTo(resetButton).offset(-resetImageView.frame.height-5)
            make.centerX.equalTo(resetButton)
        }
        
        self.bedButton = bedButton
        self.sunButton = sunButton
        self.tvButton = tvButton
        self.handButton = handButton
        self.resetButton = resetButton
        
        bottleButton.addTarget(self, action: #selector(bottleTouchDown(_:)), for: .touchDown)
        bedButton.addTarget(self, action: #selector(bedTouchDown(_:)), for: .touchDown)
        sunButton.addTarget(self, action: #selector(sunTouchDown(_:)), for: .touchDown)
        tvButton.addTarget(self, action: #selector(tvTouchDown(_:)), for: .touchDown)
        handButton.addTarget(self, action: #selector(handTouchDown(_:)), for: .touchDown)
        resetButton.addTarget(self, action: #selector(resetTouchDown(_:)), for: .touchDown)
        
        let applyButton = UIButton()
        applyButton.cornerRadius = 6
        applyButton.borderWidth = 1
        applyButton.isUserInteractionEnabled = false
        applyButton.borderColor = #colorLiteral(red: 0.8546940684, green: 0.8816700578, blue: 0.9684409499, alpha: 1)
        applyButton.setAttributedTitle(
            NSAttributedString(string: "아이템 적용하기",
                               attributes: [
                                .font : UIFont.Notos((.regular), size: 14),
                                .foregroundColor : UIColor.mainBlue
                               ]), for: .normal)
        view.addSubview(applyButton)
        applyButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(40)
            make.top.equalTo(resetButton).inset(50)
            make.height.equalTo(50)
        }
        applyButton.addTarget(self, action: #selector(cancelTouchDown(_:)), for: .touchDown)
        self.applyButton = applyButton
        
        return backgroundView
    }()
    
    func setConstraint(view: UIView) {
        view.addSubview(menuView)
        menuView.snp.makeConstraints { make in
            make.top.bottom.right.left.equalToSuperview()
        }
    }

    private func makeAttributedText(text: String) -> NSAttributedString {
        let attributedString = NSAttributedString(string: text, attributes: [
            .font : UIFont.Notos(.regular, size: 12),
            .foregroundColor : UIColor.gray2
        ])
        
        return attributedString
    }
    
    private func setButton() {
        applyButton?.isUserInteractionEnabled = true
        applyButton?.backgroundColor = .mainBlue
        applyButton?.setAttributedTitle(
            NSAttributedString(string: "아이템 적용하기",
                               attributes: [
                                .font : UIFont.Notos((.bold), size: 14),
                                .foregroundColor : UIColor.white
                               ]), for: .normal)
    }
    
    @objc func bottleGesture(gesture: UITapGestureRecognizer){
        setButton()
        [bottleButton, bedButton ,sunButton, tvButton, handButton, resetButton].forEach {
            $0?.setImage(UIImage(named: ImgName.imgName(of: .unchecked)), for: .normal)
        }
        self.applyButton?.tag = 0
        selectedIdx = 0
        bottleButton!.setImage(UIImage(named: ImgName.imgName(of: .checked)), for: .normal)
    }
    
    @objc func bedGesture(gesture: UITapGestureRecognizer){
        setButton()
        [bottleButton, bedButton ,sunButton, tvButton, handButton, resetButton].forEach {
            $0?.setImage(UIImage(named: ImgName.imgName(of: .unchecked)), for: .normal)
        }
        self.applyButton?.tag = 1
        selectedIdx = 1
        bedButton!.setImage(UIImage(named: ImgName.imgName(of: .checked)), for: .normal)
    }
    
    @objc func sunGesture(gesture: UITapGestureRecognizer){
        setButton()
        [bottleButton, bedButton ,sunButton, tvButton, handButton, resetButton].forEach {
            $0?.setImage(UIImage(named: ImgName.imgName(of: .unchecked)), for: .normal)
        }
        self.applyButton?.tag = 2
        selectedIdx = 2
        sunButton!.setImage(UIImage(named: ImgName.imgName(of: .checked)), for: .normal)
    }
    
    @objc func tvGesture(gesture: UITapGestureRecognizer){
        setButton()
        [bottleButton, bedButton ,sunButton, tvButton, handButton, resetButton].forEach {
            $0?.setImage(UIImage(named: ImgName.imgName(of: .unchecked)), for: .normal)
        }
        self.applyButton?.tag = 3
        selectedIdx = 3
        tvButton!.setImage(UIImage(named: ImgName.imgName(of: .checked)), for: .normal)
    }
    
    @objc func handGesture(gesture: UITapGestureRecognizer){
        setButton()
        [bottleButton, bedButton ,sunButton, tvButton, handButton, resetButton].forEach {
            $0?.setImage(UIImage(named: ImgName.imgName(of: .unchecked)), for: .normal)
        }
        self.applyButton?.tag = 4
        selectedIdx = 4
        handButton!.setImage(UIImage(named: ImgName.imgName(of: .checked)), for: .normal)
    }
    
    @objc func resetGesture(gesture: UITapGestureRecognizer){
        setButton()
        [bottleButton, bedButton ,sunButton, tvButton, handButton, resetButton].forEach {
            $0?.setImage(UIImage(named: ImgName.imgName(of: .unchecked)), for: .normal)
        }
        self.applyButton?.tag = 5
        selectedIdx = 5
        resetButton!.setImage(UIImage(named: ImgName.imgName(of: .checked)), for: .normal)
    }
    
    @objc func bottleTouchDown(_ sender: UIView) {
        setButton()
        [bottleButton, bedButton ,sunButton, tvButton, handButton, resetButton].forEach {
            $0?.setImage(UIImage(named: ImgName.imgName(of: .unchecked)), for: .normal)
        }
        self.applyButton?.tag = 0
        selectedIdx = sender.tag
        bottleButton!.setImage(UIImage(named: ImgName.imgName(of: .checked)), for: .normal)
    }
    
    @objc func bedTouchDown(_ sender: UIView) {
        setButton()
        [bottleButton, bedButton ,sunButton, tvButton, handButton, resetButton].forEach {
            $0?.setImage(UIImage(named: ImgName.imgName(of: .unchecked)), for: .normal)
        }
        self.applyButton?.tag = 1
        selectedIdx = sender.tag
        bedButton!.setImage(UIImage(named: ImgName.imgName(of: .checked)), for: .normal)
    }
    
    @objc func sunTouchDown(_ sender: UIView) {
        setButton()
        [bottleButton, bedButton ,sunButton, tvButton, handButton, resetButton].forEach {
            $0?.setImage(UIImage(named: ImgName.imgName(of: .unchecked)), for: .normal)
        }
        self.applyButton?.tag = 2
        selectedIdx = sender.tag
        sunButton!.setImage(UIImage(named: ImgName.imgName(of: .checked)), for: .normal)
    }
    
    @objc func tvTouchDown(_ sender: UIView) {
        setButton()
        [bottleButton, bedButton ,sunButton, tvButton, handButton, resetButton].forEach {
            $0?.setImage(UIImage(named: ImgName.imgName(of: .unchecked)), for: .normal)
        }
        self.applyButton?.tag = 3
        selectedIdx = sender.tag
        tvButton!.setImage(UIImage(named: ImgName.imgName(of: .checked)), for: .normal)
    }
    
    @objc func handTouchDown(_ sender: UIView) {
        setButton()
        [bottleButton, bedButton ,sunButton, tvButton, handButton, resetButton].forEach {
            $0?.setImage(UIImage(named: ImgName.imgName(of: .unchecked)), for: .normal)
        }
        self.applyButton?.tag = 4
        selectedIdx = sender.tag
        handButton!.setImage(UIImage(named: ImgName.imgName(of: .checked)), for: .normal)
    }
    
    @objc func resetTouchDown(_ sender: UIView) {
        setButton()
        [bottleButton, bedButton ,sunButton, tvButton, handButton, resetButton].forEach {
            $0?.setImage(UIImage(named: ImgName.imgName(of: .unchecked)), for: .normal)
        }
        self.applyButton?.tag = 5
        selectedIdx = sender.tag
        resetButton!.setImage(UIImage(named: ImgName.imgName(of: .checked)), for: .normal)
    }
    
    @objc func cancelTouchDown(_ sender: UIButton) {
        menuView.removeFromSuperview()
    }
}
