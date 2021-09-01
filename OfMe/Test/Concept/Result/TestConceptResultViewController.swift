import UIKit
import Kingfisher

class TestConceptResultViewController: BaseViewController {
    private let dataManager = ConceptResultDataManager()
    private var circularProgressBar: CircularProgressBar?
    private var data: ConceptDummy = ConceptDummy()
    private var adapter: ConceptResultAdapter?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var charactorLabel: UILabel!
    @IBOutlet weak var descriptLabel: UILabel!
    @IBOutlet weak var charactorImageView: UIImageView!
    @IBOutlet weak var charactorPageControl: UIPageControl!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataManager.getConcept() { result in
            if result.count != 0 {
                self.setUP(result: result[0])
                self.adapter = ConceptResultAdapter(of: self.collectionView, sub: self.charactorPageControl, data: result[0])
            } else {
                self.presentAlert(title: "다시 시도해 주시기 바랍니다.")
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "컨셉 추천 결과"
        circularProgressBar = self.tabBarController?.circularProgressBar(duration: 0.6, progress: 1)
        self.view.addSubview(circularProgressBar!)
        self.navigationItem.setHidesBackButton(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        circularProgressBar?.removeFromSuperview()
    }
    
    
    func setUP(result: ConceptResult) {
        if let url = URL(string: result.url) {
            charactorImageView.kf.setImage(with: url)
        }
        
        charactorLabel.text = result.name
        charactorLabel.font = .Notos(.bold, size: 22)
        charactorLabel.textColor = .mainBlue
        
        let attirbutedText = NSMutableAttributedString(string: result.subName)
        attirbutedText.addAttributes([
            .font : UIFont.Notos(.regular, size: 12),
            .foregroundColor : UIColor.gray2
        ], range: (result.subName as NSString).range(of: result.subName))
        attirbutedText.addAttribute(.underlineStyle, value: NSUnderlineStyle.thick.rawValue,
                                    range: (result.subName as NSString).range(of: result.subName))
        attirbutedText.addAttribute(.underlineColor, value: UIColor.gray2,
                                    range: (result.subName as NSString).range(of: result.subName))
        titleLabel.attributedText = attirbutedText
        
        descriptLabel.font = .Notos(.regular, size: 12)
        descriptLabel.textColor = .gray2
        descriptLabel.text = result.description
        
        charactorPageControl.numberOfPages = 5
        charactorPageControl.currentPage = 0
    }

}
