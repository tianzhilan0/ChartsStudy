//
//  LCAlertViewController.swift
//  ChartStudy
//
//  Created by LC on 2018/5/22.
//  Copyright © 2018年 LC. All rights reserved.
//

import UIKit

extension UIAlertController
{
    
    static func sheet(target:UIViewController,actions:[String],handler:((Int)->Void)?) {
        UIAlertController.sheet(target: target, title: nil, message: nil, actions: actions, handler: handler)
    }
    
    static func sheet(target:UIViewController,title:String?,message:String?,actions:[String],handler:((Int)->Void)?) {
        let alert = UIAlertController.init(title: title, message: message, preferredStyle: UIAlertControllerStyle.actionSheet)
        
        for i in 0..<actions.count {
            let action = UIAlertAction(title: actions[i], style: UIAlertActionStyle.default) { (action) in
                if handler != nil{
                    handler!(i)
                }
            }
            alert.addAction(action)
        }
        let cancel = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        
        alert.addAction(cancel)
        target.present(alert, animated: true, completion: nil)
    }
    
    
}
