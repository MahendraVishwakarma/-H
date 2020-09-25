//
//  AdaptiveTestReportViewModel.swift
//  ChartDemo
//
//  Created by Mahendra Vishwakarma on 25/09/20.
//  Copyright © 2020 Mahendra. All rights reserved.
//

import Foundation
import Highcharts

class AdaptiveTestReportViewModel {
    var minuteValue  = 24
    var secondValue = 90
    
    func getSeries(value: Int) -> HISeries {
        let series = HISeries()
        series.name = "Speed"
        series.tooltip = HITooltip()
        series.data = [value]
        
        let dataLabel = HIDataLabels()
        dataLabel.backgroundColor = "8BD16E"
        dataLabel.enabled = NSNumber(booleanLiteral: false)
        series.dataLabels = [dataLabel]
        return series
    }
    
    func getPlotBands() -> HIPlotBands{
        let plotband1 = HIPlotBands()
        plotband1.from = 0
        plotband1.to = 0
        plotband1.borderWidth = 0
        plotband1.borderColor = HIColor(hexValue:"8BD16E")
        
        return plotband1
    }
    
    func getPane(frameWidth:Int) -> HIPane{
        let pane = HIPane()
        pane.startAngle = -90
        pane.endAngle = 90
        pane.background = []
        pane.size = frameWidth - 10
        pane.center = ["50%", "70%"]
        return pane
    }
    
    func yAxix(max: Int, meterType:MeterType) -> HIYAxis {
        let yaxis = HIYAxis()
        yaxis.min = 0
        yaxis.max = NSNumber(integerLiteral: max)
        yaxis.minorTickWidth = 1
        yaxis.minorTickLength = 6
        yaxis.minorTickPosition = "inside"
        yaxis.minorTickColor = HIColor(hexValue:"4E5558")
        yaxis.tickPixelInterval = calculatePixelInterval(meterType: meterType)
        yaxis.tickWidth = 2
        yaxis.tickInterval  = meterType == .minute ? 10 : 20
        yaxis.tickPosition = "inside"
        yaxis.tickLength = 10
        yaxis.tickColor = HIColor(hexValue:"4E5558")
        yaxis.labels = HILabels()
        yaxis.lineWidth = 4
        
        yaxis.lineColor = meterType == .minute ? HIColor(hexValue:"00A9E0") : HIColor(hexValue:"8BD16E")
        
        return yaxis
    }
    
    func calculatePixelInterval(meterType: MeterType) -> NSNumber {
        return meterType == .minute ? 60 : 40
    }
}
