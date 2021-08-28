//
//  CharacterInfoCell.swift
//  OfMe
//
//  Created by HanaHan on 2021/08/22.
//

import UIKit

// 데이터 전달 로직
//1. HomeVC(데이터 전달) ->
//2. TableViewCell with TableView Horizental(데이터 전달, 페이지 컨트롤 델리게이트) ->
//3. TableViewCell in TableView of TableView (최종적으로 캐릭터 특성 표시)

class CharacterInfoCell: UITableViewCell {
    @IBOutlet weak var tableView: UITableView!
    let pageControl = UIPageControl()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(userConcept: UserConcept?) {
        
    }

    // 컬렉션뷰 셋업, 데이터 주입
    private func setupUI() {
        self.backgroundColor = .clear
        setupTableView()
    }
    
    private func setupTableView() {
    }
    
    private func setupPageControll() {
        
    }
    
}
