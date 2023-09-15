//
//  PatientMessageViewController.swift
//  e-Sushrut HMIS SAIL Rourkela
//
//  Created by HICDAC on 19/10/22.
//

import UIKit

class PatientMessageViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{

    @IBOutlet weak var type_msg_tf: UITextField!
    @IBOutlet weak var send_iv: UIImageView!
    @IBOutlet weak var messageTableView: UITableView!
    var arrData = UpcomingModel()
    var arMessages:[DoctorMessageModel] = []
   
//    var arMessages:[DoctorMessageModel]=[DoctorMessageModel(isMe: false, message: "hello sudeep", name: "rajeev", dateTime: "78:8977:88:00"),DoctorMessageModel(isMe: true, message: "hello sudeep", name: "rajeev", dateTime: "78:8977:88:00"),DoctorMessageModel(isMe: false, message: "hello sudeep", name: "rajeev", dateTime: "78:8977:88:00"),DoctorMessageModel(isMe: false, message: "hello sudeep", name: ".", dateTime: "78:8977:88:00")]
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        send_iv.transform = CGAffineTransform(rotationAngle: 0.785398);
        // create tap gesture recognizer
                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped(gesture:)))
                send_iv.addGestureRecognizer(tapGesture)
               send_iv.isUserInteractionEnabled = true
        
        sendMessage(message: "", isView: "1")
        
                    /* let doctorMessage = arrData.docMessage
                            let arAllMessages = doctorMessage.components(separatedBy: "#")
                       print("arAllMessages  \(arAllMessages)")
                            for arr in arAllMessages.reversed()
                            {
                                print("arr  \(arr)")
                                let  arrseperateMessage = arr.components(separatedBy: "::")
                                if  arrseperateMessage.count>2
                                {
                                   print(arrseperateMessage[2])

                                 arMessages.append(DoctorMessageModel(isMe: true, message: arrseperateMessage[2], name: arrseperateMessage[1], dateTime: arrseperateMessage[0]))
                                }
                            }
        */
        
        messageTableView.delegate=self
        messageTableView.dataSource=self
        //messageTableView.scrollToRow(at: IndexPath(row: arMessages.count-1, section: 0), at: .bottom, animated: true)
    }
    @objc func imageTapped(gesture: UIGestureRecognizer) {
           // if the tapped view is a UIImageView then set it to imageview
           if (gesture.view as? UIImageView) != nil {
               print("Image Tapped")
               //Here you can initiate your new ViewController

               if(type_msg_tf.text?.count == 0){
                   alert(title: "", message: "Please enter a message.")
               }else{
                   sendMessage(message: type_msg_tf.text!, isView: "0")
               }
               
           }
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

    func sendMessage(message:String,isView:String){
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.black.withAlphaComponent(0.5))
        }
        let encodeParam =  arrData.patName.addingPercentEncoding(withAllowedCharacters: .alphanumerics)
        let encodeTypedMsg =  message.addingPercentEncoding(withAllowedCharacters: .alphanumerics)

    
        let url2 = "\(ServiceUrl.getUpdateDoctorMessage)requestID=\(arrData.requestID)&sentBy=p&docMessage=\(encodeTypedMsg!)&consltID=&consltName=\(encodeParam!)&hospCode=\(arrData.hospCode)&isView=\(isView)"

        print("urlll2  \(url2)")
        
        let url = URL(string: url2)
        
        URLSession.shared.dataTask(with: url!) { [self] (data, response, error) in
            guard let data = data else { return }
            do{
        
                var json = try JSON(data:data)
              //  print(url)
                json=json["Data"]
                print("doc_json \(json)")
                if json.count == 0
                {
                    DispatchQueue.main.async {
                        self.view.activityStopAnimating()
                    }
                }
                else{
                    let arrDocMsg = json["docMessage"]
                   
                    for arr in arrDocMsg.arrayValue{
                        print("message \(arr["Message"])")
                        var isMe=false;
                        if(arr["SentBy"]=="p")
                        {
                            isMe=true;
                        }
                        self.arMessages.append(DoctorMessageModel(isMe: isMe, message: "\(arr["Message"])", name: "\(arr["UserName"])", dateTime: "\(arr["TimeStamp"])"))
                    //self.arMessages.append(DoctorMessageModel(json: arr))
                        }
                    print("docMessage------ \(self.arMessages)")
                    DispatchQueue.main.async {
                        self.view.activityStopAnimating()
                        self.messageTableView.reloadData()
                        self.messageTableView.scrollToRow(at: IndexPath(row: arMessages.count-1, section: 0), at: .bottom, animated: true)
                    }
              
                    
                }
                
            }catch{
                print("error"+error.localizedDescription)
            }
            }.resume()
    }
    func alert(title:String,message:String)
       {
           DispatchQueue.main.async {
              
           let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
           let action = UIAlertAction(title: "Dismiss", style: .default, handler:{ (action: UIAlertAction!) in
               //                print("Handle Ok logic here")
               self.navigationController?.popToRootViewController(animated: true)
           })
           alert.addAction(action)
           self.present(alert, animated: true, completion: nil)
               
           }
       }
}
