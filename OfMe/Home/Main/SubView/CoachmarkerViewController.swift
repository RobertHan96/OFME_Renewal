//
//  CoahmarkerViewController.swift
//  OfMe
//
//  Created by HanaHan on 2021/09/08.
//

import UIKit

class CoachmarkerViewController: BaseViewController {
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var skipButtonYpostion: NSLayoutConstraint!
    var coachMarkCaseType = CoachMarkCaseType.mainFirst
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    init(coachMarkCase: CoachMarkCaseType) {
        super.init(nibName: "CoachmarkerViewController", bundle: nil)
        self.coachMarkCaseType = coachMarkCase
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    private func setupUI() {
        switch coachMarkCaseType {
        case .mainFirst:
            backgroundImageView.image = UIImage(named: CoachMarkImageName.mainFirst.rawValue)
            skipButtonYpostion.constant = view.bounds.height * 0.8
        case .testResultFirst:
            backgroundImageView.image = UIImage(named: CoachMarkImageName.testResultFirst.rawValue)
        default:
            backgroundImageView.image = UIImage(named: CoachMarkImageName.mainFirst.rawValue)
        }
    }

    @IBAction func skipButtonDidClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: false)
    }

}

enum CoachMarkCaseType: String {
    case mainFirst = "mainFirst"
    case testResultFirst = "testResultFirst"
}

enum CoachMarkImageName: String {
    case mainFirst = "coachmark_main"
    case testResultFirst = "coachmark_test_result"
}
