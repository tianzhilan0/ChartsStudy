//
//  ViewController.swift
//  ChartStudy
//
//  Created by LC on 2018/5/22.
//  Copyright © 2018年 LC. All rights reserved.
//

import UIKit
import SnapKit

struct ListModel {
    let title: String
    let subtitle: String
    let `class`: AnyClass
}

class ViewController: UIViewController {
    
    private var dataArray = [ListModel(title: "折线图（单条）",
                                    subtitle: "实现折线图，动画处理，渐变填充，缩放，校准",
                                    class: LCLineChartViewController.self),
                             ListModel(title: "折线图（多条）",
                                       subtitle: "实现多条折线图，动画处理，渐变填充，缩放，校准",
                                       class: LCMoreLineChartViewController.self),
                             ListModel(title: "柱状图",
                                       subtitle: "实现多条折线图，动画处理，渐变填充，缩放，校准",
                                       class: LCMoreLineChartViewController.self)]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Charts学习"
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.delegate = self
        table.dataSource = self
        table.estimatedRowHeight = 44
        table.rowHeight = UITableViewAutomaticDimension
        table.tableHeaderView = UIView(frame: CGRect.zero)
        table.tableFooterView = UIView(frame: CGRect.zero)
        table.register(ListTableViewCell.classForCoder(), forCellReuseIdentifier: "ListTableViewCell")
        return table
    }()

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }


}

extension ViewController:UITableViewDelegate,UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = self.dataArray[indexPath.row]
        let cell = ListTableViewCell.cellForTableView(tableView: tableView, identifier: "ListTableViewCell")
        cell.bind(model)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let def = self.dataArray[indexPath.row]
        
        let vcClass = def.class as! UIViewController.Type
        let vc = vcClass.init()
        
        self.navigationController?.pushViewController(vc, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
