import UIKit

class ConceptResultMusicCell: UICollectionViewCell {
    static let identifier = "ConceptResultMusicCell"
    private let data: ConceptDummy = ConceptDummy()

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var musicTitleFirstLabel: UILabel!
    @IBOutlet weak var musicTitleSecondLabel: UILabel!
    @IBOutlet weak var musicianFirstLabel: UILabel!
    @IBOutlet weak var musicianSecondLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        [musicTitleFirstLabel, musicTitleSecondLabel].forEach {
            $0?.font = .Notos(.regular, size: 13)
        }
        
        [musicianFirstLabel, musicianSecondLabel].forEach {
            $0?.font = .Notos(.regular, size: 10)
            $0?.textColor = .gray3
        }
    }
    
    func updateUI() {
        titleLabel.makeHightledText(
            all: data.titles[4],
            for: data.titleHightLightText[4],
            font: .Notos(.regular, size: 18))
        var idx: Int = 0
        [musicTitleFirstLabel, musicTitleSecondLabel].forEach {
            $0?.text = data.songTitle[idx]
            idx += 1
        }
        idx = 0
        [musicianFirstLabel, musicianSecondLabel].forEach {
            $0?.text = data.artists[idx]
            idx += 1
        }
    }
    
    func updateUI(result: ConceptResult) {
        titleLabel.makeHightledText(
            all: "\(result.name)\(data.titles[4])",
            for: data.titleHightLightText[4],
            font: .Notos(.regular, size: 18))
        let list = result.music.components(separatedBy: ",")
        if list[0].components(separatedBy: "-").count > 1 {
            musicTitleFirstLabel.text = list[0].components(separatedBy: "-")[1]
            musicianFirstLabel.text = list[0].components(separatedBy: "-")[0]
        }
        if list[1].components(separatedBy: "-").count > 1 {
            musicTitleSecondLabel.text = list[1].components(separatedBy: "-")[1]
            musicianSecondLabel.text = list[1].components(separatedBy: "-")[0]
        }
        
    }

}
