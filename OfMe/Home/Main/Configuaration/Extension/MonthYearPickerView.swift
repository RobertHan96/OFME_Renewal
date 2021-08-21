import UIKit

class MonthYearPickerView: UIPickerView, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var months = [String]()
    var years = [Int]()
    var selectYearIdx: Int = 0
    var selectMonthIdx: Int = 0
    
    var month = Calendar.current.component(.month, from: Date()) {
        didSet {
            selectRow(month - 1, inComponent: 2, animated: false)
        }
    }
    
    var year = Calendar.current.component(.year, from: Date()) {
        didSet {
            if let firstYearIndex = years.firstIndex(of: year) {
                selectRow(firstYearIndex, inComponent: 0, animated: true)
            }
        }
    }
    
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
        // population years
        var years: [Int] = []
        if years.count == 0 {
            var year = Calendar(identifier: .gregorian).component(.year, from: Date())
            for _ in 1...15 {
                years.append(year)
                year += 1
            }
        }
        self.years = years
        
        // population months with localized names
        var months: [String] = []
        var month = 0
        for i in 1...12 {
            months.append("\(i)")
            month += 1
        }
        self.months = months
        
        delegate = self
        dataSource = self
        
        let currentMonth = Calendar(identifier: .gregorian).component(.month, from: Date())
        selectRow(currentMonth - 1, inComponent: 2, animated: true)
        selectRow(0, inComponent: 0, animated: true)
        selectMonthIdx = currentMonth - 1
    }
    
    // Mark: UIPicker Delegate / Data Source
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 4
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 2:
            return months.count
        case 0:
            return years.count
        case 1:
            return 1
        case 3:
            return 1
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let month = selectedRow(inComponent: 2) + 1
        let year = years[selectedRow(inComponent: 0)]
        if let block = onDateSelected {
            block(month, year)
        }
        
        self.month = month
        self.year = year
        
        guard let label = pickerView.view(forRow: row, forComponent: component) as? UILabel else {
            return
        }
        if component == 0 {
            selectYearIdx = row
        }
        if component == 2 {
            selectMonthIdx = row
        }
        if component == 0 || component == 2 {
            label.font = .Notos(.bold, size: 20)
            label.textColor = .mainBlue
        } else {
            label.textColor = .label
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        switch component {
        case 0:
            return 60
        case 2:
            return 45
        default:
            return 30
        }
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
        
        switch component {
        case 0:
            label.text = "\(years[row])"
        case 1:
            label.text = "년"
            label.textColor = .label
        case 2:
            label.text = "\(months[row])"
        case 3:
            label.text = "월"
            label.textColor = .label
        default:
            label.text = ""
        }

        return label
    }
    
}
