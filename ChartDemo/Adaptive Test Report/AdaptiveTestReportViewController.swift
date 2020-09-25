//


import UIKit
import Highcharts

class AdaptiveTestReportViewController: UIViewController {
    
    @IBOutlet weak var minuteView: HIChartView!
    @IBOutlet weak var secondView: HIChartView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var shadowView: UIView!
    
    @IBOutlet weak var headerView: UIView!
    
    var viewModel: AdaptiveTestReportViewModel?
    
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var minuteLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = AdaptiveTestReportViewModel()
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        headerView.addBtnGradient("header", gradientColor: AppColors.yellowDark, lightColor: AppColors.yellowLight, cornerRadius: 0, width: headerView.frame.width)
        shadowView.applyshadowWithCorner(containerView: mainView, cornerRadious: 20)
         setup()
        
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
                
        let pane = viewModel?.getPane(frameWidth: Int(minuteView.frame.width))
        
        
        
        guard let yaxisMinute = viewModel?.yAxix(max: 60, meterType: .minute) else {return }
        guard let yaxisSecond = viewModel?.yAxix(max: 120, meterType: .second) else {return }
        
        if let plotband1 = viewModel?.getPlotBands() {
            yaxisMinute.plotBands = [plotband1]
        }
       
        guard let seriesMinute = viewModel?.getSeries(value: viewModel?.minuteValue ?? 0) else {return }
        guard let seriesSecond = viewModel?.getSeries(value: viewModel?.secondValue ?? 0) else {return }
        
        let title = HITitle()
        title.text = ""
        
        let legend = HILegend()
        legend.enabled = NSNumber(booleanLiteral: false)
        
        
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
        optionsMinute.legend = legend
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
}

enum MeterType {
    case minute
    case second
}
