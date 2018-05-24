//
//  LCMoreLineChartViewController.swift
//  ChartStudy
//
//  Created by LC on 2018/5/24.
//  Copyright © 2018年 LC. All rights reserved.
//

import UIKit
import Charts

class LCMoreLineChartViewController: UIViewController {

    fileprivate var lineChartView = LineChartView()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.add, target: self, action: #selector(clickRightItem))
        self.view.backgroundColor = UIColor.white
        
        self.title = "折线图（多条）"
        
        self.view.addSubview(lineChartView)
        lineChartView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview().offset(100)
            make.height.equalTo(lineChartView.snp.width)
        }
        
        //无数据字样
        lineChartView.noDataText = "暂无数据"
        //图表描述文字
        lineChartView.chartDescription?.text = "折线图"
        //图表描述颜色
        lineChartView.chartDescription?.textColor = UIColor.red
        //启用拖动手势
        lineChartView.dragEnabled = true
        //启用缩放收拾
        lineChartView.setScaleEnabled(true)
        
        //X轴 缩放倍数
        lineChartView.viewPortHandler.setMaximumScaleX(2)
        //Y轴 缩放倍数
        lineChartView.viewPortHandler.setMaximumScaleY(2)
        
        //图例的样式
        let legend = lineChartView.legend
        legend.form = .line
        legend.font = UIFont(name: "HelveticaNeue-Light", size: 11)!
        legend.textColor = .black
        //图例的位置
        legend.horizontalAlignment = .left
        legend.verticalAlignment = .bottom
        //图例中 上下还是左右
        legend.orientation = .horizontal
        //图例中 文字和标签的位置
        legend.direction = .leftToRight
        //图例中 是否会在图表内或外部绘制
        legend.drawInside = false
        
        
        //X轴
        let xAxis = lineChartView.xAxis
        xAxis.labelFont = .systemFont(ofSize: 11)
        xAxis.labelTextColor = .red
        //X轴 线的位置
        xAxis.labelPosition = .bottom
        //X轴 线是否显示
        xAxis.drawAxisLineEnabled = true
        //X轴 标签是否展示
        xAxis.drawLabelsEnabled = true
        //X轴 标签是否由granularity控制
        xAxis.granularityEnabled = false
        
        //X轴 虚线样式
        xAxis.gridLineDashLengths = [5, 5]
        //X轴 虚线是否展示
        xAxis.drawGridLinesEnabled = true
        //X轴 限制线
        let limitLine = ChartLimitLine(limit: 30, label: "限制线")
        limitLine.lineWidth = 2.0
        limitLine.lineDashLengths = [5,5]
        limitLine.labelPosition = .leftBottom
        limitLine.lineColor = UIColor.green
        limitLine.valueTextColor = UIColor.green
        xAxis.addLimitLine(limitLine)
        
        //X轴 设置限制线绘制在柱形图的后面
        xAxis.drawLimitLinesBehindDataEnabled = false
        
        
        //左侧轴
        let leftAxis = lineChartView.leftAxis
        leftAxis.labelFont = .systemFont(ofSize: 11)
        leftAxis.labelTextColor = .blue
        //左侧轴 文字的位置
        leftAxis.labelPosition = .outsideChart
        //左侧轴 线是否显示
        leftAxis.drawAxisLineEnabled = true
        //左侧轴 标签是否展示
        leftAxis.drawLabelsEnabled = true
        //左侧轴 标签是否由granularity控制
        leftAxis.granularityEnabled = false
        
        //左侧轴 虚线样式
        leftAxis.gridLineDashLengths = [5, 5]
        //X轴 虚线是否展示
        leftAxis.drawGridLinesEnabled = true
        //左侧轴 限制线
        let leftLimitLine = ChartLimitLine(limit: 30, label: "限制线")
        leftLimitLine.lineWidth = 2.0
        leftLimitLine.lineDashLengths = [5,5]
        leftLimitLine.labelPosition = .leftBottom
        leftLimitLine.lineColor = UIColor.yellow
        leftLimitLine.valueTextColor = UIColor.yellow
        leftAxis.addLimitLine(leftLimitLine)
        
//        leftAxis.axisMaximum = 400
//        leftAxis.axisMinimum = 0
        //X轴 设置限制线绘制在柱形图的后面
        leftAxis.drawLimitLinesBehindDataEnabled = false
        
        
        //右侧轴
        let rightAxis = lineChartView.rightAxis
        rightAxis.labelFont = .systemFont(ofSize: 11)
        rightAxis.labelTextColor = .blue
        //右侧轴 文字的位置
        rightAxis.labelPosition = .outsideChart
        //右侧轴 线是否显示
        rightAxis.drawAxisLineEnabled = false
        //右侧轴 标签是否展示
        rightAxis.drawLabelsEnabled = false
        //右侧轴 标签是否由granularity控制
        rightAxis.granularityEnabled = false
        
        //右侧轴 虚线样式
        rightAxis.gridLineDashLengths = [5, 5]
        //X轴 虚线是否展示
        rightAxis.drawGridLinesEnabled = true
        //右侧轴 限制线
        let rightLimitLine = ChartLimitLine(limit: 60, label: "限制线")
        rightLimitLine.lineWidth = 3.0
        rightLimitLine.lineDashLengths = [5,5]
        rightLimitLine.labelPosition = .rightTop
        rightLimitLine.lineColor = UIColor.brown
        rightLimitLine.valueTextColor = UIColor.brown
        leftAxis.addLimitLine(rightLimitLine)
        
        //X轴 设置限制线绘制在柱形图的后面
        leftAxis.drawLimitLinesBehindDataEnabled = false
        
        //提醒浮框
        let marker = LCBalloonMarker(color: UIColor(white: 51/255, alpha: 0.5),
                                     font: .systemFont(ofSize: 12),
                                     textColor: .white,
                                     insets: UIEdgeInsets(top: 8, left: 8, bottom: 20, right: 8))
        marker.chartView = lineChartView
        marker.minimumSize = CGSize(width: 50, height: 40)
        lineChartView.marker = marker
        
        
        self.updateChartData()
        
        lineChartView.animate(xAxisDuration: 2.5)
        
    }
    
    func updateChartData() {
        
        self.setDataCount(Int(20), range: UInt32(60))
    }
    
    func setDataCount(_ count: Int, range: UInt32) {
        let yVals1 = (0..<count).map { (i) -> ChartDataEntry in
            let mult = range / 2
            let val = Double(arc4random_uniform(mult) + 50)
            return ChartDataEntry(x: Double(i), y: val)
        }
        let yVals2 = (0..<count).map { (i) -> ChartDataEntry in
            let val = Double(arc4random_uniform(range) + 150)
            return ChartDataEntry(x: Double(i), y: val)
        }
        let yVals3 = (0..<count).map { (i) -> ChartDataEntry in
            let val = Double(arc4random_uniform(range) + 250)
            return ChartDataEntry(x: Double(i), y: val)
        }
        
        let set1 = LineChartDataSet(values: yVals1, label: "DataSet 1")
        set1.axisDependency = .left
        set1.setColor(UIColor(red: 51/255, green: 181/255, blue: 229/255, alpha: 1))
        set1.setCircleColor(.white)
        set1.lineWidth = 2
        set1.circleRadius = 3
        set1.fillAlpha = 65/255
        set1.fillColor = UIColor(red: 51/255, green: 181/255, blue: 229/255, alpha: 1)
        set1.highlightColor = UIColor(red: 244/255, green: 117/255, blue: 117/255, alpha: 1)
        set1.drawCircleHoleEnabled = false
        
        let set2 = LineChartDataSet(values: yVals2, label: "DataSet 2")
        set2.axisDependency = .left
        set2.setColor(.red)
        set2.setCircleColor(.white)
        set2.lineWidth = 2
        set2.circleRadius = 3
        set2.fillAlpha = 65/255
        set2.fillColor = .red
        set2.highlightColor = UIColor(red: 244/255, green: 117/255, blue: 117/255, alpha: 1)
        set2.drawCircleHoleEnabled = false
        
        let set3 = LineChartDataSet(values: yVals3, label: "DataSet 3")
        set3.axisDependency = .left
        set3.setColor(.yellow)
        set3.setCircleColor(.white)
        set3.lineWidth = 2
        set3.circleRadius = 3
        set3.fillAlpha = 65/255
        set3.fillColor = UIColor.yellow.withAlphaComponent(200/255)
        set3.highlightColor = UIColor(red: 244/255, green: 117/255, blue: 117/255, alpha: 1)
        set3.drawCircleHoleEnabled = false
        
        let data = LineChartData(dataSets: [set1, set2, set3])
        data.setValueTextColor(.red)
        data.setValueFont(.systemFont(ofSize: 9))
        
        lineChartView.data = data
    }
    
    @objc func clickRightItem() {
        
        UIAlertController.sheet(target: self, actions: ["折线值","填充","柱状","圆润","校准"]) { (index) in
            
            if index == 0{
                for set in self.lineChartView.data!.dataSets as! [LineChartDataSet] {
                    set.drawValuesEnabled = !set.drawValuesEnabled
                }
                self.lineChartView.setNeedsDisplay()
            }
            if index == 1{
                for set in self.lineChartView.data!.dataSets as! [LineChartDataSet] {
                    set.drawFilledEnabled = !set.drawFilledEnabled
                }
                self.lineChartView.setNeedsDisplay()
            }
            if index == 2{
                for set in self.lineChartView.data!.dataSets as! [LineChartDataSet] {
                    set.mode = (set.mode == .stepped) ? .linear : .stepped
                }
                self.lineChartView.setNeedsDisplay()
            }
            if index == 3{
                for set in self.lineChartView.data!.dataSets as! [LineChartDataSet] {
                    set.mode = (set.mode == .cubicBezier) ? .linear : .cubicBezier
                }
                self.lineChartView.setNeedsDisplay()
            }
            if index == 4{
                self.lineChartView.data!.highlightEnabled = !self.lineChartView.data!.isHighlightEnabled
                self.lineChartView.setNeedsDisplay()
            }
            
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
