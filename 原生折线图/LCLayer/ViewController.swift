//
//  ViewController.swift
//  LCLayer
//
//  Created by LC on 2018/5/21.
//  Copyright © 2018年 LC. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layerView = LCLineChartView()
        layerView.backgroundColor = UIColor.lightGray

//        layerView.frame = CGRect(x: 0, y: 100, width: self.view.frame.width, height: self.view.frame.width)
        self.view.addSubview(layerView)
        
        layerView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview().offset(100)
            make.height.equalTo(layerView.snp.width)
        }
    }
    
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

