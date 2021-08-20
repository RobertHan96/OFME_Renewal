import UIKit

class CharactorPickerView: UIPickerView, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var charctor: [String] = [
        "모스",
        "제이비",
        "리아",
        "이노",
        "시애나",
        "헤더",
        "로하",
        "로키",
        "폴",
        "주주",
        "옐로우",
        "마크",
        "뮤즈",
        "빈",
        "하이",
        "피즈",
        "베어"
    ]
    var name = ""
    
    var onDateSelected: ((_ month: Int, _ year: Int) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonSetup()
    }
    
    func commonSetup() {
        delegate = self
        dataSource = self
        selectRow(0, inComponent: 0, animated: true)
    }
    
    // Mark: UIPicker Delegate / Data Source
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return charctor.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        name = charctor[selectedRow(inComponent: 0)]
        
        guard let label = pickerView.view(forRow: row, forComponent: component) as? UILabel else {
            return
        }
        label.font = .Notos(.bold, size: 20)
        label.textColor = .mainBlue

    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let rowSize = pickerView.rowSize(forComponent: component)
        let width = rowSize.width
        let height = rowSize.height
        let frame = CGRect(x: 0, y: 0, width: width, height: height)
        let label = UILabel(frame: frame)
        label.font = .Notos(.regular, size: 18)
        label.textColor = .gray
        label.textAlignment = .center
        
        label.text = charctor[row]

        return label
    }
    
}
