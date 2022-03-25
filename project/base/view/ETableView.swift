//
//  ETableView.swift
//  project
//
//  Created by lintong on 2020/12/14.
//  Copyright © 2020 lintong. All rights reserved.
//

import UIKit

class ETableView: UITableView {
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        configTableView()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configTableView()
    }
    
    private func configTableView() {
        separatorStyle = .none
        tableHeaderView = UIView(frame: .init(x: 0, y: 0, width: 0, height: 0.01))
        tableFooterView = UIView(frame: .init(x: 0, y: 0, width: 0, height: 0.01))
        backgroundColor = .backgroundColor
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
