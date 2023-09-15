//
//  ProfileViewController.swift
//  e-Sushrut HMIS SAIL Rourkela
//
//  Created by HICDAC on 20/07/22.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
  
    
    @IBOutlet weak var profileImg: UIImageView!
    
    var headerView:UIView!
    let headerHieght:CGFloat = 250
  
    
    var profileTitleArr:[String] = []
    var profileDescArr:[String] = []
    
    var profileList = [Response]()
    var list = [Product]()
    @IBOutlet weak var profileTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileTable.delegate = self
        profileTable.dataSource = self
        
        profileTable.estimatedRowHeight = 44.0
        profileTable.rowHeight = UITableView.automaticDimension
        
        fetchDocsList()
        
        loadProfile()
        
        
//        headerView = profileTable.tableHeaderView
//       profileTable.tableHeaderView = nil
//        profileTable.addSubview(self.headerView)
//
//
//        updateHeader()
      //  profileTable.contentInset = UIEdgeInsets(top: self.headerHieght, left: 0, bottom: 0, right: 0)
       // profileTable.contentOffset = CGPoint(x: 0, y: -self.headerHieght)

    }
    override func viewWillLayoutSubviews() {
    
    }
    

    func setDefaultAvatar(){
        let obj = UserDefaults.standard.retrieve(object: PatientDetails.self, fromKey: "patientDetails")
        if obj!.gender.elementsEqual("F"){
            DispatchQueue.main.async {
                self.profileImg.image = UIImage(named: "female_user")
            }
           
        }else{
            DispatchQueue.main.async {
                self.profileImg.image = UIImage(named: "male_user")
            }
        }
    }
    
    func updateHeader(){
        if profileTable.contentOffset.y < -headerHieght{
            headerView.frame.origin.y = profileTable.contentOffset.y
            headerView.frame.size.height = -profileTable.contentOffset.y
        }
    }
    
    func loadProfile() -> (){
        let obj = UserDefaults.standard.retrieve(object: PatientDetails.self, fromKey: "patientDetails")
       
        if obj!.crno != ""{
            profileTitleArr.append("CR NO")
            profileDescArr.append(obj!.crno)
        }
       
        if (obj!.umidNo != ""){
            profileTitleArr.append("Employee ID")
            profileDescArr.append(obj!.umidNo)
        }
        
        if obj!.firstName != ""{
            profileTitleArr.append("Name")
            profileDescArr.append(obj!.firstName)
        }
       
        if obj!.age != ""{
            profileTitleArr.append("Age")
            profileDescArr.append(obj!.age)
        }
        
        if obj!.gender != ""{
            profileTitleArr.append("Gender")
            profileDescArr.append(obj!.gender)
        }
       
        if obj!.fatherName != ""{
            profileTitleArr.append("Father Name")
            profileDescArr.append(obj!.fatherName)
        }
        
        if obj!.spouseName != ""{
            profileTitleArr.append("Spouce Name")
            profileDescArr.append(obj!.spouseName)
        }
        
        if obj!.sublocality != ""{
            profileTitleArr.append("Address")
            profileDescArr.append("\(obj!.sublocality), \(obj!.city), \(obj!.districtName), \(obj!.state), \(obj!.pincode)")
        }

    
        if obj!.mobileNo != ""{
            profileTitleArr.append("Mobile No")
            profileDescArr.append(obj!.mobileNo)
        }
        if obj!.email != ""{
            profileTitleArr.append("Email Id")
            profileDescArr.append(obj!.email)
        }
       
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return profileTitleArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:ProfileTableViewCell = profileTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ProfileTableViewCell
        cell.title.text = self.profileTitleArr[indexPath.row]
        cell.desc.text = self.profileDescArr[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        updateHeader()
    }
    
  
    
    fileprivate func fetchDocsList() {
        let obj = UserDefaults.standard.retrieve(object: PatientDetails.self, fromKey: "patientDetails")

        let endUrl = "&episodeCode=&hospCode=&seatid=&umid="
        let urlString = ServiceUrl.profileImage+obj!.crno+endUrl
        
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.black.withAlphaComponent(0.5))
        }
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, err in
            guard let data = data, err == nil else { return }
            
            do {
              //  let jsonDecoder = JSONDecoder()
               //  let decodedResponse = try jsonDecoder.decode(Response.self,from: data)
                

                if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any] {
                       if let status = json["status"] as? String, status == "1" {
                           if let profilePicBase64 = json["profilePicBase64"] as? [[String:String]] {
                               if profilePicBase64.count > 0{
                                   for category in profilePicBase64 {
                                       let IMAGEDATA = category["IMAGEDATA"]
                                      
                                       let dataDecoded : Data = Data(base64Encoded: IMAGEDATA!, options: .ignoreUnknownCharacters)!
                                       let decodedimage = UIImage(data: dataDecoded)
                                       DispatchQueue.main.async {
                                          
                                       self.profileImg.image = decodedimage
                                           
                                       }
                                   }
                             }else{
                                 self.setDefaultAvatar()
                              }
                  
                           }
                       }
                   }
                 
            } catch let jsonErr {
                print("failed to decode json:", jsonErr)
            }
            DispatchQueue.main.async {
                self.view.activityStopAnimating()
                
            }
        }.resume() // don't forget
    
    }
}
