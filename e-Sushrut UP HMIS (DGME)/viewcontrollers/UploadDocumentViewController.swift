//
//  UploadDocumentViewController.swift
//  e-Sushrut HMIS SAIL Rourkela
//
//  Created by HICDAC on 07/07/22.
//

import UIKit
import UniformTypeIdentifiers
import MobileCoreServices
struct ImageResponse: Decodable
{
    let status: String?
    let msg: String?
}
class CellClass: UITableViewCell{
    
}
class UploadDocumentViewController: UIViewController,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIDocumentPickerDelegate {
  

    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var imageView3: UIImageView!
    
    @IBOutlet weak var selectImg1: UIButton!
    @IBOutlet weak var selectImg2: UIButton!
    @IBOutlet weak var selectImg3: UIButton!
    
    @IBOutlet weak var uploadBtn1: UIButton!
    @IBOutlet weak var uploadBtn2: UIButton!
    @IBOutlet weak var uploadBtn3: UIButton!
    
    @IBOutlet weak var stackImg1: UIStackView!
    @IBOutlet weak var stackImg2: UIStackView!
    @IBOutlet weak var stackImg3: UIStackView!
    var image_number: Int=1;
    
    let transparentView = UIView()
    
    let tableView = UITableView()
    
    var selectedButton = UIButton()
    
    var dataSource = [String]()
    
    var strUrl : String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CellClass.self, forCellReuseIdentifier: "cell")
        stackImg1.isHidden = true
        stackImg2.isHidden = true
        stackImg3.isHidden = true
    }
    
    func addTransparentView(frame: CGRect) {
        let window = UIApplication.shared.keyWindow
        transparentView.frame = window?.frame ?? self.view.frame
        self.view.addSubview(transparentView)
        
//        tableView.frame = CGRect(x: frame.origin.x, y: frame.origin.y+frame.height, width: frame.width, height: CGFloat(dataSource.count*50))
        
        self.view.addSubview(tableView)
        
        tableView.layer.cornerRadius = 5
        
        transparentView.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        
        tableView.reloadData()
        
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(removeTransparentView))
        
        transparentView.addGestureRecognizer(tapgesture)
        
        transparentView.alpha = 0
        
        var sizeRect = UIScreen.main.applicationFrame
        var width    = sizeRect.size.width
        var height   = sizeRect.size.height
        
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.transparentView.alpha = 0.5
            self.tableView.frame = CGRect(x: 0, y: frame.size.height+60 , width: width, height: CGFloat(self.dataSource.count*50))
        
        }, completion: nil)
    
    }
    
    @objc func removeTransparentView(){
        let frame = selectedButton.frame
        
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.transparentView.alpha = 0
            self.tableView.frame = CGRect(x: frame.origin.x, y: frame.origin.y+frame.height, width: frame.width, height: 0)
        }, completion: nil)
    }
    
    @IBAction func actionImg1(_ sender: Any) {
       dropdownList()
        selectedButton = selectImg1
        addTransparentView(frame: selectImg1.frame)
    }
    
    @IBAction func actionImg2(_ sender: Any) {
        dropdownList()
        selectedButton = selectImg2
        addTransparentView(frame: selectImg2.frame)
    }
    @IBAction func actionImg3(_ sender: Any) {
        dropdownList()
        selectedButton = selectImg3
        addTransparentView(frame: selectImg1.frame)
    }
    
    
    @IBAction func selectImage(_ sender: Any) {
//        if (image_number==4){
//            alertDialogAction(title: "Alert", message: "Maximum of 3 documents can be uploaded.")
//        }else{
//            let imagecontroller = UIImagePickerController()
//            imagecontroller.delegate=self
//            imagecontroller.sourceType=UIImagePickerController.SourceType.photoLibrary
//            self.present(imagecontroller, animated: true, completion: nil)
//        }
        
        let types = [String(kUTTypeItem)]
        let documentPickerViewController = UIDocumentPickerViewController(documentTypes: types, in: .import)
        documentPickerViewController.delegate = self
        present(documentPickerViewController, animated: true, completion: nil)
        
    }
    
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        print("Cancelled")
    }
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        print("didPickDocuments at \(urls.last!.pathExtension)")
        stackImg1.isHidden = false
        
         strUrl = "\(urls[0])"
        
        if(urls.last!.pathExtension=="pdf"){
            imageView1.image = UIImage(named: "pdf_icon")
        }else{
            imageView1.image = UIImage(named: "gallery_pic")
            
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if (image_number==1){
            imageView1.image=info[UIImagePickerController.InfoKey.originalImage] as? UIImage
            self.dismiss(animated: true, completion: nil)
            image_number=2
            stackImg1.isHidden = false
        }else  if (image_number==2){
            imageView2.image=info[UIImagePickerController.InfoKey.originalImage] as? UIImage
            self.dismiss(animated: true, completion: nil)
            image_number=3
            stackImg1.isHidden = false
            stackImg2.isHidden = false
        }else  if (image_number==3){
            imageView3.image=info[UIImagePickerController.InfoKey.originalImage] as? UIImage
            self.dismiss(animated: true, completion: nil)
            image_number=4
            stackImg1.isHidden = false
            stackImg2.isHidden = false
            stackImg3.isHidden = false
        }
    }
    func dropdownList(){
        dataSource = ["Select","Patient Documents","External Investigation Reports","MLC Documents","Verification Documents","Medical Certificate"
        ,"Fitness Certificate","Case Sheet","Death Report","Death Certificate (MCCD)","Birth Report","OPD File","Estimate Certificate","Certificate B"]
    }
   
    @IBAction func uploadActionBtn1(_ sender: Any) {
        if selectImg1.currentTitle == "Select" {
            alertDialogAction(title: "Alert", message: "Select document type")
        }else{
            UploadImage()
            
        }
    }
    
    @IBAction func uploadActionBtn2(_ sender: Any) {
        if selectImg2.currentTitle == "Select" {
            alertDialogAction(title: "Alert", message: "Select document type")
        }
    }
    
    @IBAction func uploadActionBtn3(_ sender: Any) {
        if selectImg3.currentTitle == "Select" {
            alertDialogAction(title: "Alert", message: "Select document type")
        }
    }
    func alertDialogAction(title:String,message:String){
        let dialogMessage=UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancel=UIAlertAction(title: "Cancel", style: .default)
        dialogMessage.addAction(cancel)
        self.present(dialogMessage, animated: true, completion: nil)
    }
    
    
   
    
    
    
    
    
    
    
    func UploadImage(){
           // your image from Image picker, as of now I am picking image from the bundle
           let image = UIImage(named: "pdf_icon",in: Bundle(for: type(of:self)),compatibleWith: nil)
           let imageData = image?.jpegData(compressionQuality: 0.7)

           let url = ServiceUrl.uploadDocs
           var urlRequest = URLRequest(url: URL(string: url)!)

           urlRequest.httpMethod = "post"
           let bodyBoundary = "--------------------------\(UUID().uuidString)"
           urlRequest.addValue("multipart/form-data; boundary=\(bodyBoundary)", forHTTPHeaderField: "Content-Type")
         
           //attachmentKey is the api parameter name for your image do ask the API developer for this
          // file name is the name which you want to give to the file
           let requestData = createRequestBody(imageData: imageData!, boundary: bodyBoundary, attachmentKey: "file", fileName: "pdf_icon")
           
           urlRequest.addValue("\(requestData.count)", forHTTPHeaderField: "content-length")
           urlRequest.httpBody = requestData

           URLSession.shared.dataTask(with: urlRequest) { (data, httpUrlResponse, error) in

               if(error == nil && data != nil && data?.count != 0){
                   do {
                      // let response = try JSONDecoder().decode(ImageResponse.self, from: data!)
                       print("responsee::  \(data!)")
                       
                   }

                   catch let decodingError {
                       debugPrint(decodingError)
                   }
               }
           }.resume()
       }

       func createRequestBody(imageData: Data, boundary: String, attachmentKey: String, fileName: String) -> Data{
           let obj = UserDefaults.standard.retrieve(object: PatientDetails.self, fromKey: "patientDetails")
           
           let lineBreak = "\r\n"
           var requestBody = Data()
           
           requestBody.append("\(lineBreak)--\(boundary + lineBreak)" .data(using: .utf8)!)
           
           requestBody.append("Content-Disposition: form-data; file=\"\(attachmentKey)\"; crno=\"\(obj!.crno)\"\(lineBreak); hospCode=\"\("\(ServiceUrl.hospId)")\"\(lineBreak); docType=\"\("1#text5ByKaushal")\"\(lineBreak); uploadFileBase64=\"\("\("")")\"\(lineBreak) seatId=\"\("11")\"\(lineBreak)" .data(using: .utf8)!)
           
           requestBody.append("Content-Type: image/png \(lineBreak + lineBreak)" .data(using: .utf8)!)
           //requestBody.append("Content-Type: image/jpeg \(lineBreak + lineBreak)" .data(using: .utf8)!) // you can change the type accordingly if you want to
           requestBody.append(imageData)
           requestBody.append("\(lineBreak)--\(boundary)--\(lineBreak)" .data(using: .utf8)!)
           

           return requestBody
       }
    
    
   


}



extension UploadDocumentViewController: UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = dataSource[indexPath.row]
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedButton.setTitle(dataSource[indexPath.row], for: .normal)
        removeTransparentView()
    }
}
extension ViewController: UIDocumentPickerDelegate, UINavigationControllerDelegate {
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
//        viewModel.attachDocuments(at: urls)
        print(urls)
    }

     func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    
    
    
   

   
}

extension NSMutableData {
   
    func appendString(string: String) {
        let data = string.data(using: String.Encoding.utf8, allowLossyConversion: true)
        append(data!)
    }
}
