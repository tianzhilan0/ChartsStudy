//
//  LCLineChartViewController.swift
//  ChartStudy
//
//  Created by LC on 2018/5/22.
//  Copyright © 2018年 LC. All rights reserved.
//

import UIKit
import Charts

class LCLineChartViewController: UIViewController {
    
    fileprivate var lineChartView = LineChartView()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.add, target: self, action: #selector(clickRightItem))
        self.view.backgroundColor = UIColor.white
        
        self.title = "折线图（LCLineChartViewController）"
        
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
        
        //X轴 设置限制线绘制在柱形图的后面
        leftAxis.drawLimitLinesBehindDataEnabled = false
        
        
        
        //左侧轴
        let rightAxis = lineChartView.rightAxis
        rightAxis.labelFont = .systemFont(ofSize: 11)
        rightAxis.labelTextColor = .blue
        //左侧轴 文字的位置
        rightAxis.labelPosition = .outsideChart
        //左侧轴 线是否显示
        rightAxis.drawAxisLineEnabled = false
        //左侧轴 标签是否展示
        rightAxis.drawLabelsEnabled = false
        //左侧轴 标签是否由granularity控制
        rightAxis.granularityEnabled = false
        
        //左侧轴 虚线样式
        rightAxis.gridLineDashLengths = [5, 5]
        //X轴 虚线是否展示
        rightAxis.drawGridLinesEnabled = true
        //左侧轴 限制线
        let rightLimitLine = ChartLimitLine(limit: 60, label: "限制线")
        rightLimitLine.lineWidth = 3.0
        rightLimitLine.lineDashLengths = [5,5]
        rightLimitLine.labelPosition = .rightTop
        rightLimitLine.lineColor = UIColor.brown
        rightLimitLine.valueTextColor = UIColor.brown
        leftAxis.addLimitLine(rightLimitLine)
        
        //X轴 设置限制线绘制在柱形图的后面
        leftAxis.drawLimitLinesBehindDataEnabled = false
        
        

        self.updateChartData()
        
        lineChartView.animate(xAxisDuration: 2.5)
        
    }
    
    
    func updateChartData() {
        
        self.setDataCount(Int(45), range: UInt32(100))
    }
    
    func setDataCount(_ count: Int, range: UInt32) {
        let values = (0..<count).map { (i) -> ChartDataEntry in
            let val = Double(arc4random_uniform(range) + 3)
            if i%2 == 1{
                //折线 交叉点加图标
                return ChartDataEntry(x: Double(i), y: val, icon: UIImage(named: "star"))
            }else{
                return ChartDataEntry(x: Double(i), y: val)
            }
        }
        
        let set1 = LineChartDataSet(values: values, label: "消费额")
        //折线 线宽
        set1.lineWidth = 1
        //折线 线的颜色
        set1.setColor(.black)
        //折线 线的样式
        set1.lineDashLengths = [5, 2.5]
        //折线 是否添加图标
        set1.drawIconsEnabled = true
        
        //校准线
        set1.highlightLineDashLengths = [5, 5]
        set1.highlightColor = UIColor.red
        
        //折线 圆的颜色 外
        set1.circleRadius = 6
        set1.setCircleColor(.brown)
        set1.drawCirclesEnabled = true
        //折线 圆的颜色 内
        set1.circleHoleRadius = 3
        set1.circleHoleColor = .brown
        set1.drawCircleHoleEnabled = true
        
        set1.valueFont = .systemFont(ofSize: 9)
        
        //折线 对应的图例样式
        set1.formLineDashLengths = [5, 2.5]
        set1.formLineWidth = 2
        set1.formSize = 15
        
        //折线 填充
        let gradientColors = [ChartColorTemplates.colorFromString("#00ff0000").cgColor,
                              ChartColorTemplates.colorFromString("#ffff0000").cgColor]
        let gradient = CGGradient(colorsSpace: nil, colors: gradientColors as CFArray, locations: nil)!
        //折线 填充透明度
        set1.fillAlpha = 1
        //折线 填充颜色
        set1.fill = Fill(linearGradient: gradient, angle: 90) //.linearGradient(gradient, angle: 90)
        //折线 是否显示填充
        set1.drawFilledEnabled = true
        
        let data = LineChartData(dataSet: set1)
        
        lineChartView.data = data
    }
    
    
    @objc func clickRightItem() {
        
        UIAlertController.sheet(target: self, actions: ["测试","确定"]) { (index) in
            print(index)
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
