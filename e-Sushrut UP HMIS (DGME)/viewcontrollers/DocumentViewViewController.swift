//
//  DocumentViewViewController.swift
//  AIIMS Mangalagiri e-Paramarsh
//
//  Created by sudeep rai on 08/09/20.
//  Copyright © 2020 CDAC NOIDA. All rights reserved.
//

import UIKit

class DocumentViewViewController: UIViewController {
var arrData=PatientRequestDetails()
    var image1:UIImage?
    var image2:UIImage?
    var image3:UIImage?
 
    @IBOutlet weak var segRef: UISegmentedControl!
    
    
    @IBOutlet weak var imgView: UIImageView!
    
    @IBAction func segBtn(_ sender: Any) {
        
        if segRef.selectedSegmentIndex == 0
        {
          jsonParsing(slNo: "1")
        }
        if segRef.selectedSegmentIndex == 1
        {
                 jsonParsing(slNo: "2")
         
        }
        if segRef.selectedSegmentIndex == 2
        {
             jsonParsing(slNo: "3")
        }
        
    }
    

    

    override func viewDidLoad() {
        super.viewDidLoad()

        jsonParsing(slNo: "1")
      DispatchQueue.main.async {
          self.imgView.image=self.image1
          
      }
    }
    
    func jsonParsing(slNo:String){
  
            let url = URL(string: ServiceUrl.viewDocument)
           
            var request = URLRequest(url: url!)
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            request.httpMethod = "POST"
            let parameters: [String: Any] = [
                "hospCode": arrData.hospCode,
                "requestID" : arrData.requestID,
                "slno" : slNo
            ]
            request.httpBody = parameters.percentEncoded()
            
//            let urlSession = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
            
            
        URLSession.shared.dataTask(with: request) { (data, response, error) in
                guard let data = data else { return }
                do{
//                    print("url \(url)")
                    let json = try JSON(data:data)
                    
                   // print(data)
                    let status = json["status"].stringValue
                    print("status :::: \(status)")
                    let results = json["ImageData"]
                    if status=="1"
                    {
                    for arr in results.arrayValue{
                      //  print("aa \(arr["GBYTE_DOC_DATA"].stringValue)")
                        self.image1 = self.resizeImage(image: self.convertBase64ToImage(imageString: arr["GBYTE_DOC_DATA"].stringValue), targetSize: CGSize(width:500.0 , height:500.0))
                    }
                        DispatchQueue.main.async {
                        self.imgView.image=self.image1
                        }
                    }
                    else{
                        DispatchQueue.main.async {
                        self.imgView.image = #imageLiteral(resourceName: "view_error_image")
                        }
                    }
                   
                    
                    
                }catch{
                    print("sudeep"+error.localizedDescription)
                }
                }.resume()
        }

    func convertBase64ToImage(imageString: String) -> UIImage {
           let imageData = Data(base64Encoded: imageString, options: Data.Base64DecodingOptions.ignoreUnknownCharacters)!
           return UIImage(data: imageData)!
       }
    
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / image.size.width
        let heightRatio = targetSize.height / image.size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }

}
