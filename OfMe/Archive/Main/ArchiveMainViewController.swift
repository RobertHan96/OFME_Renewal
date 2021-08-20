import UIKit
import FSCalendar

class ArchiveMainViewController: BaseViewController {
    private let dataManager = DiaryDataManager()
    private var adapter: ArchiveMainAdapter?
    private var date = Date()
    private var mainPicker: MainPicker = MainPicker()
    
    lazy var rightButton: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.tintColor = .label
        button.image = UIImage(named: ImgName.imgName(of: .write))
        button.target = self
        button.action = #selector(writeTouchDown)
        return button
    }()
    
    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet weak var dateButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calendar.dataSource = self
        calendar.delegate = self
        calendar.select(date, scrollToDate: true)
        calendar.scope = .week
        calendar.setColor()
        calendar.defaultWeekDay()
        calendar.appearance.weekdayFont = .Notos(.regular, size: 13)
        setButtonText()
        self.navigationItem.rightBarButtonItem = rightButton
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.title = "컨셉 기록"
        middleButton = self.tabBarController?.testMiddleButton()
        middleButton?.addTarget(self, action: #selector(writeTouchDown), for: .touchDown)
        dataManager.getDiary(date: date) { result in
            self.adapter = ArchiveMainAdapter(of: self.collectionView, data: result, vc: self)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        middleButton?.removeFromSuperview()
    }
    
    @IBAction func dateTouchDown(_ sender: Any) {
        mainPicker.setConstraint(view: self.view)
        mainPicker.selectButton?.addTarget(self, action: #selector(selectTouchDown(_:)), for: .touchDown)
    }
    
    @objc func selectTouchDown(_ sender: UIButton) {
        if let pickerView = mainPicker.pickerView {
            let year = pickerView.years[pickerView.selectedRow(inComponent: 0)]
            let month = pickerView.months[pickerView.selectedRow(inComponent: 2)]
            date = Date(year: year, month: Int(month)!, day: 1)
            calendar.reloadData()
            calendar.select(date)
            setButtonText()
            mainPicker.mainView.removeFromSuperview()
            dataManager.getDiary(date: date) { result in
                self.adapter?.updateData(data: result)
            }
        }
    }
    
    func setButtonText() {
        dateButton.setAttributedTitle(NSAttributedString(string: date.monthText+"  ", attributes: [
            .font : UIFont.Notos(.bold, size: 12),
            .foregroundColor : UIColor.mainBlue
        ]), for: .normal)
    }
    
    @objc func writeTouchDown() {
        let vc = ArchiveWriteViewController(date: date)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension ArchiveMainViewController: FSCalendarDataSource {
    func minimumDate(for calendar: FSCalendar) -> Date {
        return date.startOfMonth
    }
    
    func maximumDate(for calendar: FSCalendar) -> Date {
        return date.endOfMonth
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        self.date = date
        dataManager.getDiary(date: date) { result in
            self.adapter?.updateData(data: result)
        }
    }
}

extension ArchiveMainViewController: FSCalendarDelegateAppearance, FSCalendarDelegate {
}
