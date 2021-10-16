//
//  invalidConceptTestAlert.swift
//  OfMe
//
//  Created by HanaHan on 2021/09/04.
//
import Foundation
import UIKit

class CustomInformAlert: NSObject {
    weak var confirmButton: UIButton?
    var titleText = ""
    var subText = ""

    init(titleText: String, subText: String) {
        self.subText = subText
        self.titleText = titleText
    }
    
    lazy var mainView: UIView = {
        let device = UIScreen.main.bounds
        let backgroundView = UIView(frame: CGRect(x: 0, y: 0, width: device.width, height: device.height))
        let view = UIView(frame: CGRect(x: 0, y: 0, width: device.width, height: 600))
        view.backgroundColor = .systemBackground
        view.cornerRadius = 6
        backgroundView.backgroundColor = .init(white: 0, alpha: 0.42)
        backgroundView.addSubview(view)
        
        view.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(215)
        }
        
        let titleLabel = UILabel()
        titleLabel.font = .Notos(.bold, size: 20)
        titleLabel.textColor = .mainBlue
        titleLabel.text = titleText
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(24)
            make.centerX.equalToSuperview()
        }
        
        let subLabel = UILabel()
        subLabel.font = .Notos(.regular, size: 14)
        subLabel.numberOfLines = 0
        subLabel.textAlignment = .center
        
        subLabel.makeAlertTextHighlight(all: subText, for: subText, font: UIFont.Notos(.regular, size: 14))
        
        view.addSubview(subLabel)
        subLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(70)
            make.left.right.equalToSuperview().inset(10)
        }
        
        let borderView = UIView()
        borderView.backgroundColor = .lightGray
        view.addSubview(borderView)
        borderView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(65)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(1)
        }
        
        let verticalView = UIView()
        verticalView.backgroundColor = .lightGray
        view.addSubview(verticalView)
        verticalView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(1)
            make.bottom.equalToSuperview().inset(19)
            make.height.equalTo(22)
        }
        
        let confirmButton = UIButton()
        confirmButton.setAttributedTitle(NSAttributedString(string: "확인",
                                                           attributes: [
                                                            .font : UIFont.Notos(.regular, size: 14),
                                                            .foregroundColor : UIColor.label
                                                           ]), for: .normal)
        confirmButton.addTarget(self, action: #selector(confirmButtonDidClicked), for: .touchDown)

        self.confirmButton = confirmButton
        view.addSubview(confirmButton)
        verticalView.isHidden = true
        confirmButton.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.centerX.equalTo(verticalView)
            make.top.equalTo(borderView)
            make.bottom.equalToSuperview()
        }
        
        return backgroundView
    }()
    
    func setConstraint(view: UIView) {
        view.addSubview(mainView)
        mainView.snp.makeConstraints { make in
            make.top.bottom.right.left.equalToSuperview()
        }
    }
    
    @objc func confirmButtonDidClicked() {
        mainView.removeFromSuperview()
    }
}
