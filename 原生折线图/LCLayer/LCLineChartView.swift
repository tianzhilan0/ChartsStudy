//
//  LCLineChartView.swift
//  LCLayer
//
//  Created by LC on 2018/5/21.
//  Copyright © 2018年 LC. All rights reserved.
//

import UIKit

class LCLineChartView: UIView {
    
    fileprivate var boundsX:CGFloat = 0.0
    fileprivate var boundsY:CGFloat = 0.0
    
    fileprivate var lcRect:CGRect?
    
    
    /// X、Y轴线的宽度
    var XAndYAxis_Width:CGFloat = 1.0
    /// X、Y轴线的颜色
    var XAndYAxis_Color:UIColor = UIColor.red
    
    
    /// X轴字号
    var XAxis_Font:CGFloat = 10
    /// X轴颜色
    var XAxis_Color:UIColor = UIColor.black
    
    /// Y轴字号
    var YAxis_Font:CGFloat = 10
    /// Y轴颜色
    var YAxis_Color:UIColor = UIColor.black
    
    
    /// X轴数据
//    var XAxis_DataArray = [String]()
    var XAxis_DataArray = ["一月","二月","三月","四月","五月","六月","七月","八月","九月","十月","十一月","十二月"]
    /// Y轴数据
//    var YAxis_DataArray = [String]()
    var YAxis_DataArray = ["0","100","200","300","400","500","600"]

    /// 表内背景渐变色
    var gradientLayerColors = [UIColor.yellow.cgColor,UIColor.brown.cgColor]
    
    /// 折线数组
    fileprivate lazy var lineChartArray: Array<CAShapeLayer> = {
        return Array<CAShapeLayer>()
    }()
    

    override func draw(_ rect: CGRect) {
        
        boundsX = rect.width/10
        boundsY = rect.height/10
        
        lcRect = rect
        
        self.createXAndYLine(rect)
        self.createXData(rect)
        self.createYData(rect)
        self.drawGradientBackgroundView(rect)
        self.drawDottedLine(rect)
        
        self.drawLine(rect)
        self.showLine(rect)
    }
    
    
    /// 创建X、Y轴
    fileprivate func createXAndYLine(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        context!.setLineWidth(XAndYAxis_Width)
        context?.setStrokeColor(XAndYAxis_Color.cgColor)
        context?.move(to: CGPoint(x: boundsX, y: boundsY))
        context?.addLine(to: CGPoint(x: boundsX, y: rect.height - boundsY))
        context?.addLine(to: CGPoint(x: rect.width - boundsX, y: rect.height - boundsY))

        context?.strokePath()
    }
    
    
    /// 给X轴添加数据
    fileprivate func createXData(_ rect: CGRect) {
        let count = XAxis_DataArray.count
        
        let width = (rect.width - boundsX*2)/CGFloat(count)

        for i in 0..<count {
            let label = UILabel()
            label.frame = CGRect(x: boundsX+CGFloat(i)*width, y: rect.height - boundsY, width: width, height: boundsY/2)
            label.text = XAxis_DataArray[i]
            label.font = UIFont.systemFont(ofSize: XAxis_Font)
            label.textColor = XAxis_Color
            label.tag = 10000+i
            self.addSubview(label)
        }
    }
    
    
    /// 给Y轴添加数据
    fileprivate func createYData(_ rect: CGRect) {
        let count = YAxis_DataArray.count
        let height = (rect.height - boundsY*2)/CGFloat(count)
        
        for i in 0..<count {
            let label = UILabel()
            label.frame = CGRect(x: 0, y: rect.height - boundsY - height/2 - CGFloat(i)*height, width: boundsX, height: height)
            label.text = YAxis_DataArray[i]
            label.font = UIFont.systemFont(ofSize: YAxis_Font)
            label.textColor = YAxis_Color
            label.tag = 20000+i
            label.textAlignment = .right
            self.addSubview(label)
        }
    }
    
    /// 画渐变背景
    fileprivate func drawGradientBackgroundView(_ rect: CGRect) {
        let gradientLayer = CAGradientLayer.init()
        gradientLayer.frame = CGRect(x: boundsX, y: boundsY, width: rect.width - boundsX*2, height: rect.height - boundsY*2)
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0)
        
        gradientLayer.colors = gradientLayerColors
        self.layer.addSublayer(gradientLayer)
    }
    
    /// 画虚线
    fileprivate func drawDottedLine(_ rect: CGRect) {
        
        for i in 0..<YAxis_DataArray.count {
            let layer = CAShapeLayer.init()
            layer.strokeColor = UIColor.white.cgColor
            layer.fillColor = UIColor.clear.cgColor
            layer.lineWidth = 1.0
            
            let lable = self.viewWithTag(20000+i)
            let path = UIBezierPath.init()
            path.lineWidth = 1
            path.move(to: CGPoint(x: boundsX, y: (lable?.frame.origin.y)! + (lable?.frame.height)!/2))
            path.addLine(to: CGPoint(x: rect.width - boundsX, y: (lable?.frame.origin.y)! + (lable?.frame.height)!/2))
            path.stroke()
            layer.path = path.cgPath
            self.layer.addSublayer(layer)
        }
        
        for i in 0..<XAxis_DataArray.count {
            let layer = CAShapeLayer.init()
            layer.strokeColor = UIColor.white.cgColor
            layer.fillColor = UIColor.clear.cgColor
            layer.lineWidth = 1.0
            
            let lable = self.viewWithTag(10000+i)
            let path = UIBezierPath.init()
            path.lineWidth = 1
            path.move(to: CGPoint(x: (lable?.frame.origin.x)!, y: rect.height - boundsY))
            path.addLine(to: CGPoint(x: (lable?.frame.origin.x)!, y: boundsY))
            path.stroke()
            
            layer.path = path.cgPath
            self.layer.addSublayer(layer)
        }
    }
    
    /// 画折线
    fileprivate func drawLine(_ rect: CGRect) {
        
        let path = UIBezierPath()
        path.lineWidth = 1.0
        
        for i in 0..<XAxis_DataArray.count {
            let lable = self.viewWithTag(10000+i)
            
            let number = arc4random()%600
            print("number == \(number)")
            
            if i == 0{
                path.move(to: CGPoint(x: (lable?.frame.origin.x)!, y: boundsY + (600 - CGFloat(number))/600*(rect.height-2*boundsY)))
            }else{
                path.addLine(to: CGPoint(x: (lable?.frame.origin.x)!, y: boundsY + (600 - CGFloat(number))/600*(rect.height-2*boundsY)))
            }
            let flagLabel = UILabel()
            flagLabel.frame = CGRect(x: (lable?.frame.origin.x)!, y: boundsY + (600 - CGFloat(number))/600*(rect.height-2*boundsY) - (lable?.frame.height)!, width: (lable?.frame.width)!, height: (lable?.frame.height)!)
            flagLabel.text = "\(number)"
            flagLabel.font = UIFont.systemFont(ofSize: 8)
            self.addSubview(flagLabel)
        }
        
        path.stroke()
        path.addClip()
        
        let gradientLayer = CAGradientLayer.init()
        gradientLayer.frame = CGRect(x: boundsX, y: boundsY, width: rect.width - 2*boundsX, height: rect.height - 2*boundsY)
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0)
        
        gradientLayer.colors = [UIColor.red.cgColor,UIColor.blue.cgColor]
        self.layer.addSublayer(gradientLayer)
        
        let layer = CAShapeLayer.init()
        layer.strokeColor = UIColor.green.cgColor
        layer.fillColor = UIColor.clear.cgColor
        layer.lineCap = kCALineCapButt;
        layer.lineJoin = kCALineJoinRound;
        layer.lineWidth = 2.0
        layer.path = path.cgPath
        lineChartArray.append(layer)
        
        gradientLayer.mask = layer
        
    }
    
    /// 动画展示折线
    fileprivate func showLine(_ rect: CGRect) {
        
        for i in 0..<lineChartArray.count {
            let layer = lineChartArray[i]
//            layer.lineWidth = 2.0
            
            let pathAnimation = CABasicAnimation(keyPath: "strokeEnd")
            pathAnimation.duration = 3
            pathAnimation.repeatCount = 1
            pathAnimation.isRemovedOnCompletion = true
            pathAnimation.fromValue = 0
            pathAnimation.toValue = 1
            
            layer.add(pathAnimation, forKey: "strokeEnd")
            
        }
    }
    
    
    
    
    
    
}
