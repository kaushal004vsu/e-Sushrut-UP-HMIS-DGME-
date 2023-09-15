
//  StatsViewController.swift
//  e-Sushrut HMIS SAIL Rourkela
//
//  Created by HICDAC on 28/09/22.
//

import UIKit
import Charts
class StatsViewController: UIViewController, ChartViewDelegate, URLSessionDelegate {

    var name = ""
    var vital_id = ""
    var statsDetails=[StatsDetails]()
    var arrVitalValue = [Double]()
    var arrVitalDate = [String]()
    @IBOutlet weak var lineCharts: LineChartView!
    {
        didSet{
            lineCharts.xAxis.labelPosition = .bottom
            lineCharts.xAxis.granularityEnabled = true
            lineCharts.xAxis.granularity = 1.0

        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        showAlert()
        lineCharts.delegate = self
        self.title = name
        self.lineCharts.chartDescription.textColor = UIColor.white
        lineCharts.xAxis.labelPosition = .bottom
        lineCharts.xAxis.granularityEnabled = true
        
        lineCharts.xAxis.drawAxisLineEnabled = true
        lineCharts.leftAxis.drawAxisLineEnabled = true
        lineCharts.setVisibleXRange(minXRange: 10.0, maxXRange: 12.0)
        lineCharts.xAxis.labelRotationAngle = 0
        
        lineCharts.extraLeftOffset = 20
        lineCharts.extraBottomOffset = 20
        lineCharts.extraRightOffset = 20
        lineCharts.extraTopOffset = 20


//        lineCharts.xAxis.granularity = 1.0
//        lineCharts.xAxis.setLabelCount(6, force: true)
        
        
//        let months = ["26-Sep-2022" , "27-Sep-2022", "28-Sep-2022"]
//           let dollars1 = [1453.0,2352,5431]
//           setChart(months, values: dollars1)

        let obj = UserDefaults.standard.retrieve(object: PatientDetails.self, fromKey: "patientDetails")
        let crno = obj!.crno
        getLineChartStats(crno: crno)
    }
    func getLineChartStats(crno:String){
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.black.withAlphaComponent(0.5))
        }
    let url = URL(string: ServiceUrl.graphUrl+crno)
        let urlSession = URLSession(configuration: .default, delegate: self, delegateQueue: nil)

        urlSession.dataTask(with: url!) { [self] (data, response, error) in
            guard let data = data else { return }
            do{
                let json = try JSON(data:data)
                
                if json["status"].stringValue=="1"
                {
                    DispatchQueue.main.async {
                        self.view.activityStopAnimating()
                    }
                    let listData=json["data"].array
                    let jsonn =   JSON(listData ?? "")
                    if jsonn.count>0 {
                        for arr in jsonn.arrayValue{
                            self.statsDetails.append(StatsDetails(json: arr))
                            
                            let vital_value = arr["VITAL_VALUE"].stringValue
                            let id = arr["VITAL_ID"].stringValue
                            let record_date = arr["RECORD_DATE"].stringValue
                            let formatter = DateFormatter()
                            let dateFormatter = DateFormatter()
                        
                                //dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
                            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.S"
                                let date = dateFormatter.date(from: record_date)
                                dateFormatter.dateFormat = "dd-MMM-yyyy"
                                dateFormatter.string(from: date!)
                            dateFormatter.dateStyle = .short
                            dateFormatter.timeStyle = .none

                            formatter.dateFormat = "dd-MMM-yyyy"
                           let rDate = formatter.string(from: date ?? Date())
                            
                            print("VITAL_ID \(rDate) ---- \(self.vital_id)")
                            if(id == self.vital_id){
                                self.arrVitalValue.append(Double(vital_value)!)
                                self.arrVitalDate.append(rDate)
                            }
                        }
                    }
                
                }else{
                    //no slots available
                    //self.noSlotsAvailable()
                }
                DispatchQueue.main.async {
                    self.view.activityStopAnimating()
                }
                DispatchQueue.main.async { [self] in
                    self.view.activityStopAnimating()
                    print("\(self.arrVitalValue) --- stats_count")
                    if self.arrVitalValue.count < 2{
                        //Data not found
                        alert(title: "", message: "Data not found!")
                    }else{
                        //data available
                        setChart(self.arrVitalDate, values: self.arrVitalValue)
                    }
                    }
            
            }catch{
                
                DispatchQueue.main.async {
                    self.view.activityStopAnimating()
                }
                
                
                print(error.localizedDescription)
            }
            }.resume()
    }
    func setChart(_ dataPoints: [String], values: [Double]) {

        var dataEntries: [ChartDataEntry] = []

        for i in 0 ..< dataPoints.count {
            dataEntries.append(ChartDataEntry(x: Double(i), y: values[i]))
        }
        let lineChartDataSet = LineChartDataSet(entries: dataEntries, label: "")
        lineChartDataSet.axisDependency = .left
        lineChartDataSet.setColor(UIColor.black)
        lineChartDataSet.setCircleColor(UIColor.black) // our circle will be dark red
        lineChartDataSet.lineWidth = 1.0
        lineChartDataSet.circleRadius = 3.0 // the radius of the node circle
        lineChartDataSet.fillAlpha = 1
        lineChartDataSet.fillColor = UIColor.black
        lineChartDataSet.highlightColor = UIColor.white
        lineChartDataSet.drawCircleHoleEnabled = true

        var dataSets = [LineChartDataSet]()
        dataSets.append(lineChartDataSet)

        let lineChartData = LineChartData(dataSets: dataSets)
        lineCharts.data = lineChartData
        lineCharts.rightAxis.enabled = false
        lineCharts.xAxis.drawGridLinesEnabled = false
        lineCharts.xAxis.labelPosition = .bottom
        lineCharts.xAxis.valueFormatter = IndexAxisValueFormatter(values: dataPoints)
    }


    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        print(entry)
    }
    func showAlert() {
        if !AppUtilityFunctions.isInternetAvailable() {
            alert(title: "Warning",message: "The Internet is not available")
        }
    }
   
    func alert(title:String,message:String)  {
        DispatchQueue.main.async {
           
        let alertController = UIAlertController(title: title, message:
           message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
        
            let attributedString = NSAttributedString(string: message, attributes: [
                        NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20),
                        NSAttributedString.Key.foregroundColor : UIColor.red
                    ])
            alertController.setValue(attributedString, forKey: "attributedMessage")
            
            self.present(alertController, animated: true, completion: nil)
            
        }
    }
}

