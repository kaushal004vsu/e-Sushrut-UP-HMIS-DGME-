//
//  DoctorListViewController.swift
//  AIIMS Bhubaneswar Swasthya
//
//  Created by sudeep rai on 06/08/20.
//  Copyright © 2020 sudeep rai. All rights reserved.


import UIKit
import Foundation
import SystemConfiguration
class DoctorListViewController: UIViewController,URLSessionDelegate, UISearchBarDelegate,UISearchControllerDelegate, PopUpProtocol
{
    var refreshControl = UIRefreshControl()
    var arrData = [PatientRequestDetails]()
          var arTodaysData=[PatientRequestDetails]()
          var arUpComingData=[PatientRequestDetails]()
          var arPastData=[PatientRequestDetails]()
       
        let searchController=UISearchController(searchResultsController: nil)
    @IBOutlet weak var lblDoctorName: UILabel!
    @IBOutlet weak var lblLastUpdated: UILabel!
    
    @IBOutlet weak var lblTotalRecords: UILabel!
    var isUpcoming = false
    @IBOutlet weak var segRef: UISegmentedControl!
    

    @IBAction func segBtn(_ sender: Any) {
        if segRef.selectedSegmentIndex == 0
               {
                   searchController.isActive = false

                doctorTableView.rowHeight = UITableView.automaticDimension
                           doctorTableView.estimatedRowHeight = 44
                arrData=arTodaysData
              DispatchQueue.main.async {
                  self.doctorTableView.reloadData()
                let totalrecords=self.doctorTableView.numberOfRows(inSection: 0)
                self.lblTotalRecords.text = "\(totalrecords) records found."
              }
 isUpcoming = false
                
                
               }
        
        
               if segRef.selectedSegmentIndex == 1
               {
                   searchController.isActive = false

                doctorTableView.rowHeight = UITableView.automaticDimension
                           doctorTableView.estimatedRowHeight = 44
                arrData=arUpComingData
                               DispatchQueue.main.async {
                                   self.doctorTableView.reloadData()
                                let totalrecords=self.doctorTableView.numberOfRows(inSection: 0)
                                self.lblTotalRecords.text = "\(totalrecords) records found."
                               }
                 isUpcoming = true
                
               
               }
        
        
               if segRef.selectedSegmentIndex == 2
               {
         searchController.isActive = false

                doctorTableView.rowHeight = UITableView.automaticDimension
                           doctorTableView.estimatedRowHeight = 44
                arrData=arPastData
                      DispatchQueue.main.async {
                                   self.doctorTableView.reloadData()
                        let totalrecords=self.doctorTableView.numberOfRows(inSection: 0)
                        self.lblTotalRecords.text = "\(totalrecords) records found."
                               }
                 isUpcoming = false
                
                
               }
               
    }
    
    @IBOutlet weak var doctorTableView: UITableView!
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
                      refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
                    doctorTableView.addSubview(refreshControl)
        lblDoctorName.text=UserDefaults.standard.string(forKey: "udUserdisplayname")
        
        
        self.navigationItem.title = "Patient List"
//                    searchController.loadViewIfNeeded()
//                        showAlert()
//        
//                        doctorTableView.rowHeight = UITableView.automaticDimension
//                        doctorTableView.estimatedRowHeight = 44
//                     doctorTableView.delegate = self
//                    doctorTableView.dataSource = self
//                        jsonParsing()
//                        searchBarSetup()
        
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        refreshViewController()
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.systemBlue]
             segRef.setTitleTextAttributes(titleTextAttributes, for:.normal)
    }
    
    
    
    
    
    @objc func refresh(_ sender: AnyObject) {
       // Code to refresh table view
        refreshViewController()
    }
    
    
    func jsonParsing(){
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.black.withAlphaComponent(0.5))
        }
    
        
        let url = URL(string: ServiceUrl.viewRequestListByEmployeeCode+UserDefaults.standard.string(forKey:"udEmpcode")! + "&hospCode=" + UserDefaults.standard.string(forKey:"udHospCode")!)
//            let urlSession = URLSession(configuration: .default, delegate: self, delegateQueue: nil)

            URLSession.shared.dataTask(with: url!) { (data, response, error) in
                guard let data = data else { return }
                do{
                    let json = try JSON(data:data)
//                    print(data)
                  //  print(json["Data"])
                   if json["Data"].count != 0
                   {
                    for arr in json["Data"].arrayValue{
                    
                        //self.arrData.append(PatientRequestDetails(json: arr))
                           print(json["deptUnitName"].stringValue);
                        
                     /**
                         Today's Data
                         */
                        if arr["requestStatus"].stringValue=="0" || arr["requestStatus"].stringValue=="1"
                        {
                       
                            
                            let today = Date()
                                   let formatter = DateFormatter()
                               formatter.dateFormat = "yyyy-MM-dd"
                            let todaysDateString = formatter.string(from: today)
                                   
                                   //Ref date
                                   let dateFormatter = DateFormatter()
                                   dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
                            let someDate = dateFormatter.date(from: arr["apptDate"].stringValue)
                                   dateFormatter.dateFormat = "yyyy-MM-dd"
                                   let somedateString = dateFormatter.string(from: someDate!)
                                   if todaysDateString == somedateString  {
                                        //print("todays date \(todaysDateString)")
                                        self.arTodaysData.append(PatientRequestDetails(json: arr))
                                   }
                        }
                        
                        
                        /**
                         Past Data
                         */
                        if arr["requestStatus"].stringValue=="2" || arr["requestStatus"].stringValue=="4"
                        {
                  
                            
                            let today = Date()
                                   let formatter = DateFormatter()
                               formatter.dateFormat = "yyyy-MM-dd"
                            let todaysDateString = formatter.string(from: today)
                                   
                                   //Ref date
                                   let dateFormatter = DateFormatter()
                                   dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
                            let someDate = dateFormatter.date(from: arr["apptDate"].stringValue)
                                   dateFormatter.dateFormat = "yyyy-MM-dd"
                                   let somedateString = dateFormatter.string(from: someDate!)
                                   if todaysDateString >= somedateString  {
                                       // print("past date \(todaysDateString)")
                                             self.arPastData.append(PatientRequestDetails(json: arr))
                                   }
                        }
                        
                        
                        /**
                         Upcoming Data
                         */
                        if arr["requestStatus"].stringValue=="0" || arr["requestStatus"].stringValue=="4"
                              {
                        
                                  
                                  let today = Date()
                                         let formatter = DateFormatter()
                                     formatter.dateFormat = "yyyy-MM-dd"
                                  let todaysDateString = formatter.string(from: today)
                                         
                                         //Ref date
                                         let dateFormatter = DateFormatter()
                                         dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
                                  let someDate = dateFormatter.date(from: arr["apptDate"].stringValue)
                                         dateFormatter.dateFormat = "yyyy-MM-dd"
                                         let somedateString = dateFormatter.string(from: someDate!)
                                         if todaysDateString < somedateString  {
                                           //   print("upcoming date \(todaysDateString)")
                                                   self.arUpComingData.append(PatientRequestDetails(json: arr))
                                         }
                              }

  
                    }
                    
                    
                        
                    
                     
//                    print("kmksmwkmskwmsk \(self.arTodaysData)")
                    DispatchQueue.main.async {
                        if self.segRef.selectedSegmentIndex==0{
                            self.arrData=self.arTodaysData
                        }
                        else if self.segRef.selectedSegmentIndex==1
                        {
                            self.arrData=self.arUpComingData
                        }
                        else if self.segRef.selectedSegmentIndex==2
                        {
                            self.arrData=self.arPastData
                        }
                        
                        self.doctorTableView.reloadData()
                        let totalrecords=self.doctorTableView.numberOfRows(inSection: 0)
                        self.lblTotalRecords.text = "\(totalrecords) records found."
                                  
                        
                        self.refreshControl.endRefreshing()
                        self.view.activityStopAnimating()
                    }
                    }
                }catch{
                    
                    DispatchQueue.main.async {
                        self.refreshControl.endRefreshing()
                        self.view.activityStopAnimating()
                    }
                    
                    
                    print("aa"+error.localizedDescription)
                }
                }.resume()
        }
    
    
    
    
    
     private func searchBarSetup(){
            searchController.searchResultsUpdater=self
            searchController.searchBar.delegate=self
            
         //  self.searchController.dimsBackgroundDuringPresentation = false
            if #available(iOS 11.0, *) {
                navigationItem.searchController=searchController
            } else {
                
                searchController.hidesNavigationBarDuringPresentation = false
                doctorTableView.tableHeaderView = searchController.searchBar
            }
           
            
        }
        func showAlert() {
            if !self.isInternetAvailable() {
                let alert = UIAlertController(title: "Warning", message: "The Internet is not available", preferredStyle: .alert)
                let action = UIAlertAction(title: "Dismiss", style: .default, handler:{ (action: UIAlertAction!) in
    //                print("Handle Ok logic here")
                    self.navigationController?.popToRootViewController(animated: true)
                })
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
            }
        }
        func isInternetAvailable() -> Bool
        {
            var zeroAddress = sockaddr_in()
            zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
            zeroAddress.sin_family = sa_family_t(AF_INET)
            
            let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
                $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                    SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
                }
            }
            
            var flags = SCNetworkReachabilityFlags()
            if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
                return false
            }
            let isReachable = flags.contains(.reachable)
            let needsConnection = flags.contains(.connectionRequired)
            return (isReachable && !needsConnection)
        }
}




extension DoctorListViewController:UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText=searchController.searchBar.text else{return}
        if searchText==""
        {
            if segRef.selectedSegmentIndex==0{
                arrData=arTodaysData
            }
            else if segRef.selectedSegmentIndex==1
            {
                arrData=arUpComingData
            }
            else if segRef.selectedSegmentIndex==2
            {
                arrData=arPastData
            }
        }
        else{
            if segRef.selectedSegmentIndex==0{
                arrData=arTodaysData
            }
            else if segRef.selectedSegmentIndex==1
            {
                arrData=arUpComingData
            }
            else if segRef.selectedSegmentIndex==2
            {
                arrData=arPastData
            }
            arrData=arrData.filter{
                $0.patName.lowercased().contains(searchText.lowercased())
            }
        }
         DispatchQueue.main.async {
            self.doctorTableView.reloadData()
        }
    }
}

extension DoctorListViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.row > arrData.count-1){
            jsonParsing()
            return UITableViewCell()
          }
        else{
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DoctorListTableViewCell
        
            cell.lblApprove.layer.cornerRadius = 5.0
            cell.lblApprove.layer.borderColor = UIColor(red: 166/255.0, green: 225/255.0, blue: 241/255.0, alpha: 1).cgColor
          cell.lblApprove.layer.borderWidth = 1.0
            
            
            cell.lblPatientName.text = arrData[indexPath.row].patName+" ("+arrData[indexPath.row].patGender+"/"+arrData[indexPath.row].patAge+"/"+arrData[indexPath.row].patMobileNo+")"

        
        cell.lblCrno.text = "CR No: "+arrData[indexPath.row].CRNo
        
        
            cell.lblDeptUnitName.text = "Unit :  "+arrData[indexPath.row].deptUnitName

            cell.lblRaisedOn.text = "Raised On :  "+arrData[indexPath.row].date

//          cell.lblSlotDate.text = "Appointment Slot :  "+arrData[indexPath.row].apptDate
            
        var raisedBy = "Raised By: ";
                if (arrData[indexPath.row].requestID.prefix(1)=="P") {
        
                    raisedBy = raisedBy + "Self ("+arrData[indexPath.row].requestID+")";
                } else if (arrData[indexPath.row].requestID.prefix(1)=="N") {
                    raisedBy = raisedBy + "New Patient ("+arrData[indexPath.row].requestID+")";
                } else if (arrData[indexPath.row].requestID.prefix(1)=="H") {
                    raisedBy = raisedBy + "Health Worker ("+arrData[indexPath.row].requestID+")";
                }
        
        cell.lblRaisedBy.text=raisedBy
        
        
        
        
        let displayDate = changeDateFormat(dateString: arrData[indexPath.row].apptDate, fromFormat: "yyyy-MM-dd hh:mm:ss", toFormat: "EEE, dd MMM")
       
//        print("display date \(displayDate)")
        
        /**
         show approve button and hide status label for pending requests. vice versa for other request status
         */
        
        if arrData[indexPath.row].requestStatus=="0"
        {
//            print("if \(arrData[indexPath.row].requestStatus)")
            cell.lblApprove.isHidden=false
            cell.lblRequestStatus.isHidden=true
        }
            else
        {
//            print("else \(arrData[indexPath.row].requestStatus)")
             cell.lblApprove.isHidden=true
            cell.lblRequestStatus.isHidden=false
        }
        
//        print(isUpcoming)
        if isUpcoming
        {
         cell.lblApprove.setTitle("View/Message", for: .normal)
        }else
        {
            cell.lblApprove.setTitle("Click to approve", for: .normal)
        }
        
        
       
        if arrData[indexPath.row].requestStatus=="1"
        {
            cell.lblRequestStatus.setTitle("Click to attend", for: .normal)
            cell.lblRequestStatus.setTitleColor(.green,for: .normal)
            cell.lblRequestStatus.setTitleColor(UIColor(red: 52.0/255.0, green: 181.0/255.0, blue: 59.0/255.0, alpha: 1), for: .normal)
            
        }
        if arrData[indexPath.row].requestStatus=="2"
               {
                   cell.lblRequestStatus.setTitle("Completed", for: .normal)
                   cell.lblRequestStatus.setTitleColor(.systemBlue, for: .normal)
                   
               }
        
        if arrData[indexPath.row].requestStatus=="4"
        {
            cell.lblRequestStatus.setTitle("Rejected", for: .normal)
            cell.lblRequestStatus.setTitleColor(.systemRed, for: .normal)
            
        }
        
        /**
         display slot date in EEE, dd MMM format
         */
        cell.lblSlotDate.text = "Appointment Slot :  "+displayDate
        
        /**
         hide consultant name if it is bank i.e. in case of pending requests.
         */
        if arrData[indexPath.row].consName != ""
        {
        cell.lblConsName.text="Consultant Name: "+arrData[indexPath.row].consName
            cell.lblConsName.isHidden=false
        }else{
            cell.lblConsName.isHidden=true
        }
        
        
        /**
         show hide document view button on the basis of document uploaded by patient or not
         */
       if arrData[indexPath.row].isDocUploaded != "0"
        {
            cell.imgDocuments.isHidden=false
        }else{
            cell.imgDocuments.isHidden=true
        }
    
        
        
            cell.lblViewMessages.tag = indexPath.row
            cell.lblViewMessages.addTarget(self,action:#selector(viewMessagesClicked(sender:)), for: .touchUpInside)
        
        
   /**
         On click of document view button.
         */
        cell.imgDocuments.tag = indexPath.row
         cell.imgDocuments.addTarget(self,action:#selector(viewDocumentClicked(sender:)), for: .touchUpInside)
        
        /** approve request button clicked.*/
        cell.lblApprove.tag = indexPath.row
        cell.lblApprove.addTarget(self,action:#selector(approveRequestClicked(sender:)), for: .touchUpInside)
        
        
        /** attend request button clicked.*/
        cell.lblRequestStatus.tag = indexPath.row
        cell.lblRequestStatus.addTarget(self,action:#selector(attendRequestClicked(sender:)), for: .touchUpInside)
        
        return cell
        }
    }
    
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if arrData[indexPath.row].requestStatus == "0"
        {
//            print("show dialog"+arrData[indexPath.row].docMessage)
//             let popUpActionViewController = PopUpActionViewController()
            showPopup(parentVC: self,arrData: arrData[indexPath.row])
            }
        
             if arrData[indexPath.row].requestStatus == "1"
                    {
        let viewController:DeskViewController = self.storyboard!.instantiateViewController(withIdentifier: "DeskViewController") as! DeskViewController
                   viewController.patientData=arrData[indexPath.row]
                   self.navigationController!.show(viewController, sender: self)
                        }
                
   else if arrData[indexPath.row].requestStatus == "2"
    {
        print("go to view prescription")
        
//            let viewController:ViewPrescriptionViewController = self.storyboard!.instantiateViewController(withIdentifier: "ViewPrescriptionViewController") as! ViewPrescriptionViewController
//            viewController.arrData=arrData[indexPath.row]
//            self.navigationController!.show(viewController, sender: self)
       
       let viewController:ViewPrescriptionViewController = self.storyboard!.instantiateViewController(withIdentifier: "ViewPrescriptionViewController") as! ViewPrescriptionViewController
       viewController.arrData=arrData[indexPath.row]
       self.navigationController!.show(viewController, sender: self)
        }
       }
    
     func changeDateFormat(dateString: String, fromFormat: String, toFormat: String) ->String {
        let inputDateFormatter = DateFormatter()
        inputDateFormatter.dateFormat = fromFormat
        let date = inputDateFormatter.date(from: dateString)

        let outputDateFormatter = DateFormatter()
        outputDateFormatter.dateFormat = toFormat
        return outputDateFormatter.string(from: date!)
    }
    
    
    
    @objc func viewDocumentClicked(sender:UIButton) {

        let buttonRow = sender.tag
      //  let a = self.arrData[buttonRow].CRNo
        let viewController:DocumentViewViewController = self.storyboard!.instantiateViewController(withIdentifier: "DocumentViewViewController") as! DocumentViewViewController
                   viewController.arrData=arrData[buttonRow]
                   self.navigationController!.show(viewController, sender: self)
        print("view document clicked ")
    }
    
    @objc func approveRequestClicked(sender:UIButton) {
  let buttonRow = sender.tag
       if arrData[buttonRow].requestStatus == "0"
                {
                    showPopup(parentVC: self,arrData: arrData[buttonRow])
                    }
    }
    
    
    @objc func attendRequestClicked(sender:UIButton) {
    let buttonRow = sender.tag
          if arrData[buttonRow].requestStatus == "1"
                            {
                let viewController:DeskViewController = self.storyboard!.instantiateViewController(withIdentifier: "DeskViewController") as! DeskViewController
                           viewController.patientData=arrData[buttonRow]
                           self.navigationController!.show(viewController, sender: self)
                                }
        
        
        if arrData[buttonRow].requestStatus == "2"
                    {
//        let viewController:ViewPrescriptionViewController = self.storyboard!.instantiateViewController(withIdentifier: "ViewPrescriptionViewController") as! ViewPrescriptionViewController
//                   viewController.arrData=arrData[buttonRow]
//                   self.navigationController!.show(viewController, sender: self)
            
            let viewController:ViewPrescriptionViewController = self.storyboard!.instantiateViewController(withIdentifier: "ViewPrescriptionViewController") as! ViewPrescriptionViewController
            viewController.arrData=arrData[buttonRow]
            self.navigationController!.show(viewController, sender: self)
                        }
      }
    
    
    
    @objc func viewMessagesClicked(sender:UIButton) {
        let buttonRow = sender.tag
        var arMessages:[DoctorMessageModel]=[]
        let doctorMessage = arrData[buttonRow].docMessage
//        print("doctorMessage:::: "+doctorMessage)
                                    let arAllMessages = doctorMessage.components(separatedBy: "#")

/*                                    for arr in arAllMessages.reversed()
                                    {
                                        let  arrseperateMessage = arr.components(separatedBy: "::")
                                        if  arrseperateMessage.count>2
                                        {
//                                           print(arrseperateMessage[2])
        
                                         arMessages.append(DoctorMessageModel(isMe: true, message: arrseperateMessage[2], name: arrseperateMessage[1], dateTime: arrseperateMessage[0]))
                                        }
                                    }*/
        
        
        
        if arMessages.count != 0
        {

        
                  let viewController:DoctorMessageViewController = self.storyboard!.instantiateViewController(withIdentifier: "DoctorMessageViewController") as! DoctorMessageViewController
                             
                             
                             viewController.arrData=arrData[buttonRow]
                             self.navigationController!.show(viewController, sender: self)
                  print("view messages clicked ")
        }
        else
        {
            noMessagesFoundAlert()
        }
    }
    
    func noMessagesFoundAlert()  {
        let alertController = UIAlertController(title: "No messages found!", message:
            "No messages found for this request.", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
        
        present(alertController, animated: true, completion: nil)
    }
    
    
    
    
    //MARK:- functions for the viewController
    func showPopup(parentVC: UIViewController,arrData: PatientRequestDetails){
           //creating a reference for the dialogView controller
          
          
           if let popupViewController = UIStoryboard(name: "CustomView", bundle: nil).instantiateViewController(withIdentifier: "PopUpActionViewController") as? PopUpActionViewController {
               popupViewController.modalPresentationStyle = .custom
               popupViewController.modalTransitionStyle = .crossDissolve
               
               //setting the delegate of the dialog box to the parent viewController
               popupViewController.delegate = parentVC as? PopUpProtocol
            popupViewController.arrData=arrData
            popupViewController.isUpcoming=isUpcoming
               //presenting the pop up viewController from the parent viewController
               parentVC.present(popupViewController, animated: true)
               
               
               
                 
           }
       }
    

   func handleAction(action: Bool) {
       if (action) {

          refreshViewController()
        print("handle action running")
                  }
       else{
        //do nothing
              }
   }
    
    
    
    func refreshViewController()
    {
        
        // get the current date and time
        let currentDateTime = Date()

        let formatter=DateFormatter()
                  formatter.dateFormat="dd/MM/yyyy hh:mm:ss"
                  let dateString = "Last updated on: "+formatter.string(from: currentDateTime)
    
        lblLastUpdated.text = dateString
        arrData.removeAll()
        arTodaysData.removeAll()
        arUpComingData.removeAll()
        arPastData.removeAll()
  
        searchController.loadViewIfNeeded()
                   showAlert()
               
                   doctorTableView.rowHeight = UITableView.automaticDimension
                   doctorTableView.estimatedRowHeight = 44
                doctorTableView.delegate = self
               doctorTableView.dataSource = self
                   jsonParsing()
                   searchBarSetup()
        
    }
   
}


extension Calendar {
       static let gregorian = Calendar(identifier: .gregorian)
   }
   extension Date {
       var startOfWeek: Date {
           return Calendar.gregorian.date(from: Calendar.gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self))!
       }
       var addingOneWeek: Date {
           return Calendar.gregorian.date(byAdding: DateComponents(weekOfYear: 1), to: self)!
       }
       var nextSunday: Date {
           return startOfWeek.addingOneWeek
       }
       func nextFollowingSundays(_ limit: Int) -> [Date] {
           precondition(limit > 0)
           var sundays = [nextSunday]
           sundays.reserveCapacity(limit)
           return [nextSunday] + (0..<limit-1).compactMap { _ in
               guard let next = sundays.last?.addingOneWeek else { return nil }
            
           
               sundays.append(next)
               return next
           }
       }
   }
