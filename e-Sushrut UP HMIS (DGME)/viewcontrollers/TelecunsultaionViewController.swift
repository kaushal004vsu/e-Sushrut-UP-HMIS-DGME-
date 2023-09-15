//
//  TelecunsultaionViewController.swift
//  e-Sushrut HMIS SAIL Rourkela
//
//  Created by HICDAC on 15/08/22.
//

import UIKit
import iOSDropDown

class TelecunsultaionViewController: UIViewController {
    var hospList=[HospListModel]()
    var arHospName = [String]();
    var arHospCode = [Int]();
    var hospCode:Int=0
    
    @IBOutlet weak var dropDown: DropDown!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        dropDown.selectedRowColor = .blue
        dropDown.listHeight = 300
        getHospital()
        dropDown.didSelect { [self] selectedText, index, id in
            print("inside view did load  \(id)")
            self.hospCode=id
        }
    }
    
    func getHospital(){
        let url2 = ServiceUrl.teleconsultancyHospitalList

        let url = URL(string: url2)

       // print("url "+url2)
        URLSession.shared.dataTask(with: url!) { [self] (data, response, error) in
            guard let data = data else { return }
            do{
                var json = try JSON(data:data)
                if json.count == 0{
                    DispatchQueue.main.async {
                        self.view.activityStopAnimating()
                   
                    }
                }
                else{
                for arr in json.arrayValue{
                    self.hospList.append(HospListModel(json: arr))
                }
                    for i in 0 ..< self.hospList.count {
                        self.arHospName.append(self.hospList[i].hospName)
                        self.arHospCode.append(Int(self.hospList[i].hospCode)!)
                    }
                    dropDown.optionArray = self.arHospName
                    dropDown.optionIds = self.arHospCode
                
                   // getBrandId()

                }
                DispatchQueue.main.async {
                    self.view.activityStopAnimating()
                }
                
            }catch{
                print("error"+error.localizedDescription)
            }
            }.resume()
    }
}
