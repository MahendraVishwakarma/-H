//


import UIKit
import Highcharts

class ViewController: UIViewController {
    
    @IBOutlet weak var minuteView: HIChartView!
    @IBOutlet weak var secondView: HIChartView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var shadowView: UIView!
    
    @IBOutlet weak var headerView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        headerView.addBtnGradient("header", gradientColor: AppColors.yellowDark, lightColor: AppColors.yellowLight, cornerRadius: 0, width: headerView.frame.width)
        shadowView.applyshadowWithCorner(containerView: mainView, cornerRadious: 20)
        
    }
    private func setup() {
        
        let optionsMinute = HIOptions()
        let optionsSecond = HIOptions()
        
        let chart = HIChart()
        chart.type = "gauge"
        chart.plotBorderWidth = 0
        chart.plotBorderColor = HIColor(hexValue:"FFFFFF")
        chart.height = minuteView.frame.height
        
        let credits = HICredits()
        credits.enabled = false
        
        let exporting = HIExporting()
        exporting.enabled = false
                
        let pane = getPane()
        
        let yaxisMinute = yAxix(max: 60, meterType: .minute)
        let yaxisSecond = yAxix(max: 120, meterType: .second)
        
        let plotband1 = getPlotBands()
        yaxisMinute.plotBands = [plotband1]
        
        let seriesMinute = getSeries(value: 24)
        let seriesSecond = getSeries(value: 90)
        
        let title = HITitle()
        title.text = ""
        
        let tooltip = HITooltip()
        tooltip.enabled = false
        
        //for minute
        optionsMinute.series = NSArray(object: seriesMinute) as? [HISeries]
        optionsMinute.chart = chart
        optionsMinute.pane = pane
        optionsMinute.exporting = exporting
        optionsMinute.credits = credits
        optionsMinute.chart = chart
        optionsMinute.title = title
        optionsMinute.pane = pane
        optionsMinute.tooltip = tooltip
        optionsMinute.yAxis = [yaxisMinute]
        
        //for second
        optionsSecond.series = NSArray(object: seriesSecond) as? [HISeries]
        optionsSecond.chart = chart
        optionsSecond.pane = pane
        optionsSecond.exporting = exporting
        optionsSecond.credits = credits
        optionsSecond.chart = chart
        optionsSecond.title = title
        optionsSecond.pane = pane
        optionsSecond.tooltip = tooltip
        optionsSecond.yAxis = [yaxisSecond]
        
        //minuteView.
        minuteView.options = optionsMinute
        secondView.options = optionsSecond
        
    }
    
    private func getSeries(value: Int) -> HISeries {
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
    
    private func getPlotBands() -> HIPlotBands{
        let plotband1 = HIPlotBands()
        
        plotband1.from = 0
        plotband1.to = 0
        plotband1.borderWidth = 0
        plotband1.borderColor = HIColor(hexValue:"8BD16E")
        return plotband1
    }
    
    private func getPane() -> HIPane{
        let pane = HIPane()
        pane.startAngle = -90
        pane.endAngle = 90
        pane.background = []
        pane.size = minuteView.frame.width - 10
        pane.center = ["50%", "70%"]
        return pane
    }
    
    private func yAxix(max: Int, meterType:MeterType) -> HIYAxis {
        let yaxis = HIYAxis()
        yaxis.min = 0
        yaxis.max = NSNumber(integerLiteral: max)
        yaxis.minorTickWidth = 1
        yaxis.minorTickLength = 6
        yaxis.minorTickPosition = "inside"
        yaxis.minorTickColor = HIColor(hexValue:"4E5558")
        yaxis.tickPixelInterval = calculatePixelInterval(meterType: meterType)
        yaxis.tickWidth = 2
        yaxis.tickPosition = "inside"
        yaxis.tickLength = 10
        yaxis.tickColor = HIColor(hexValue:"4E5558")
        yaxis.labels = HILabels()
        yaxis.lineWidth = 4
        yaxis.lineColor = meterType == .minute ? HIColor(hexValue:"00A9E0") : HIColor(hexValue:"8BD16E")
        
        return yaxis
    }
    
    private func calculatePixelInterval(meterType: MeterType) -> NSNumber {
        return meterType == .minute ? 60 : 40
    }

}

enum MeterType {
    case minute
    case second
}
