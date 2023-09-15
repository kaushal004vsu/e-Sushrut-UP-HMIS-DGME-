//
//  DoctorMessageViewController.swift
//  AIIMS Mangalagiri e-Paramarsh
//
//  Created by sudeep rai on 09/09/20.
//  Copyright © 2020 CDAC NOIDA. All rights reserved.
//

import UIKit

class DoctorMessageViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var messageTableView: UITableView!
    var arrData = PatientRequestDetails()
    var arMessages:[DoctorMessageModel] = []
   
//    var arMessages:[DoctorMessageModel]=[DoctorMessageModel(isMe: false, message: "hello sudeep", name: "rajeev", dateTime: "78:8977:88:00"),DoctorMessageModel(isMe: true, message: "hello sudeep", name: "rajeev", dateTime: "78:8977:88:00"),DoctorMessageModel(isMe: false, message: "hello sudeep", name: "rajeev", dateTime: "78:8977:88:00"),DoctorMessageModel(isMe: false, message: "hello sudeep", name: ".", dateTime: "78:8977:88:00")]
    override func viewDidLoad() {
        super.viewDidLoad()
                       
                  
                     
//                        var arDocMessage = [DoctorMessageModel]()
                         let doctorMessage = arrData.docMessage
                            let arAllMessages = doctorMessage.components(separatedBy: "#")

                            for arr in arAllMessages.reversed()
                            {
                                let  arrseperateMessage = arr.components(separatedBy: "::")
                                if  arrseperateMessage.count>2
                                {
                                   print(arrseperateMessage[2])

                                 arMessages.append(DoctorMessageModel(isMe: true, message: arrseperateMessage[2], name: arrseperateMessage[1], dateTime: arrseperateMessage[0]))
                                }
                            }
        
        
        messageTableView.delegate=self
        messageTableView.dataSource=self
        messageTableView.scrollToRow(at: IndexPath(row: arMessages.count-1, section: 0), at: .bottom, animated: true)
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 49
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arMessages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DoctorMessageTableViewCell
        
        cell.updateMessageCell(by:  arMessages[indexPath.row])
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}
