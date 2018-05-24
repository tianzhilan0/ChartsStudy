//
//  ListTableViewCell.swift
//  ChartStudy
//
//  Created by LC on 2018/5/22.
//  Copyright © 2018年 LC. All rights reserved.
//

import UIKit

class ListTableViewCell: UITableViewCell {
    
    fileprivate var titleLable = UILabel()
    fileprivate var detailLabel = UILabel()
    
    class func cellForTableView(tableView:UITableView,identifier:String) -> ListTableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        if cell==nil {
            cell = ListTableViewCell.init(style: .subtitle, reuseIdentifier:identifier)
        }
        return cell! as! ListTableViewCell
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.accessoryType = .disclosureIndicator
        
        addSubview(titleLable)
        titleLable.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.top.right.equalToSuperview().offset(10)
            make.height.equalTo(20)
        }
        
        addSubview(detailLabel)
        detailLabel.textColor = UIColor.lightGray
        detailLabel.font = UIFont.systemFont(ofSize: 14)
        detailLabel.numberOfLines = 0
        detailLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(20)
            make.top.equalTo(titleLable.snp.bottom).offset(5)
            make.right.equalToSuperview().offset(-40)
            make.bottom.equalToSuperview().offset(-10)
        }
    }
    
    func bind(_ model:ListModel) {
        titleLable.text = model.title
        detailLabel.text = model.subtitle
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
