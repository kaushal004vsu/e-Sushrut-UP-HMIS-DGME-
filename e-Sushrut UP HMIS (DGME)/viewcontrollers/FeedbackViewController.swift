//
//  FeedbackViewController.swift
//  e-Sushrut HMIS SAIL Rourkela
//
//  Created by HICDAC on 14/05/23.
//

import UIKit
import UIKit

class FeedbackViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var poorEmoji: UIImageView!
    @IBOutlet weak var averageEmoji: UIImageView!
    @IBOutlet weak var goodEmoji: UIImageView!
    
    @IBOutlet weak var feedback_parent: UIStackView!
    
    @IBOutlet weak var feedback_tf: UITextView!
    @IBOutlet weak var reached_limit_lbl: UILabel!
    @IBOutlet weak var remain_text_lbl: UILabel!
    @IBOutlet weak var allows_days_lbl: UILabel!
    
    @IBOutlet weak var submitBtn: UIButton!
    var rating:Int = 0
    let maxLength = 1000
    private let placeholder = "Any comments (Optional)"
    var userType:String!
    override func viewDidLoad() {
           super.viewDidLoad()
        self.showInternetAlert()
        submitBtn.layer.cornerRadius = 20;//half of the width
        submitBtn.layer.borderColor=UIColor.systemBlue.cgColor;
        submitBtn.layer.borderWidth=0.0;
        
        hideKeyboardWhenTappedAround()
        feedback_tf.delegate = self
        feedback_tf!.layer.borderWidth = 1
        feedback_tf!.layer.borderColor = UIColor.gray.cgColor

        feedback_tf.text = "Any comments (Optional)"
        feedback_tf.textColor = UIColor.systemGray
        feedback_tf.font = UIFont(name: "verdana", size: 18.0)
        feedback_tf.returnKeyType = .done

        let poorTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onPoorTapped(tapGestureRecognizer:)))
        poorEmoji.isUserInteractionEnabled = true
        poorEmoji.addGestureRecognizer(poorTapGestureRecognizer)
        
        let avarageTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onAverageTapped(tapGestureRecognizer:)))
        averageEmoji.isUserInteractionEnabled = true
        averageEmoji.addGestureRecognizer(avarageTapGestureRecognizer)
        
        let goodTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onGoodTapped(tapGestureRecognizer:)))
        goodEmoji.isUserInteractionEnabled = true
        goodEmoji.addGestureRecognizer(goodTapGestureRecognizer)
         
       }
   
    @IBAction func submitBtn(_ sender: Any) {
      
       // submitJson()
        if (rating == 0) {
            showToast(message: "Feedback required!!",font: .systemFont(ofSize: 12.0))
        } else {
        //Hide the soft keyboard
        submitJson()

     }
    }
    
    @objc func onPoorTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        // Your action
        //let poorTappedImage = tapGestureRecognizer.view as! UIImageView
        visibleData()
        self.animateImage(image: poorEmoji)
        rating = 1
        poorEmoji.image = UIImage(named:"poor_emoji")
        averageEmoji.image = UIImage(named:"emogi_icon21")
        goodEmoji.image = UIImage(named:"emogi_icon31")
        
    }
    
    @objc func onAverageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        // Your action
       // let averageTappedImage = tapGestureRecognizer.view as! UIImageView
        visibleData()
        self.animateImage(image: averageEmoji)
        rating = 2
        poorEmoji.image = UIImage(named:"emogi_icon11")
        averageEmoji.image = UIImage(named:"average_emoji")
        goodEmoji.image = UIImage(named:"emogi_icon31")
    }
    @objc func onGoodTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        // Your action
        //let goodTappedImage = tapGestureRecognizer.view as! UIImageView
        visibleData()
        self.animateImage(image: goodEmoji)
        rating = 3
        poorEmoji.image = UIImage(named:"emogi_icon11")
        averageEmoji.image = UIImage(named:"emogi_icon21")
        goodEmoji.image = UIImage(named:"good_emoji")
    }
    func visibleData(){
        feedback_parent.isHidden = false
        allows_days_lbl.isHidden = false
    }
    func animateImage(image:UIImageView) {
                addRippleEffect(to: image)
        
            }
    
    func submitJson(){
        self.submitBtn.isEnabled = false
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.black.withAlphaComponent(0.5))
        }
        
        let obj = UserDefaults.standard.retrieve(object: PatientDetails.self, fromKey: "patientDetails")
        var crno = ""
        var hospCode = ""
        var mobileNo = ""
        var umidNo = ""
        var userId = ""
        var employeeCode = ""
        if(self.userType == "2"){
            userId =  UserDefaults.standard.string(forKey:"udUserId")!;
            mobileNo =  UserDefaults.standard.string(forKey:"udMobileNo")!;
            hospCode =  UserDefaults.standard.string(forKey:"udHospCode")!;
            // hospName =  UserDefaults.standard.string(forKey:"udHospName");
            employeeCode =  UserDefaults.standard.string(forKey:"udEmpcode")!;
            self.userType = "2"
        }else{
             crno = obj!.crno
             hospCode = obj!.hospCode
             mobileNo = obj!.mobileNo
            // umidNo=UserDefaults.standard.string(forKey: "udUmidNo")!
             self.userType = "1"
        }
       
        let url = URL(string: ServiceUrl.FeedbackUrl)
            var request = URLRequest(url: url!)
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            request.httpMethod = "POST"
        var optionalComment = ""
        if(feedback_tf.text.count == 0||feedback_tf.text == "Any comments (Optional)"){
            optionalComment = ""
        }else{
            optionalComment = feedback_tf.text
        }
            let parameters: [String: Any] = [
                "userId": userId,
                "empNo" : employeeCode,
                "crno" : crno,
                "mobileNo" : mobileNo,
                "umidNo" : umidNo,
                "raiting" : String(rating),
                "hospcode" : hospCode,
                "entrySource" : "2",
                "remarks" : optionalComment,
                "userType" : self.userType!,
                "modeval" : "1",
            ]
        
  print("feed_data \(parameters)")
            request.httpBody = parameters.percentEncoded()
            
//            let urlSession = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
            
            
        URLSession.shared.dataTask(with: request) { (data, response, error) in
                guard let data = data else { return }
                do{
//                    print("url \(url)")
                    let json = try JSON(data:data)
                    
                   // print(data)
                    let status = json["status"].stringValue
                    let msg = json["msg"].stringValue
                    if status=="1"{
                        DispatchQueue.main.async {
                            self.submitBtn.isEnabled = true
                            self.feedbackShowAlert(message: msg)
                            
                        }
                    }else{
                        DispatchQueue.main.async {
                            self.submitBtn.isEnabled = true
                            self.showAlert(message: " Could not save data.Please try again.")
                        }
                    }
                    DispatchQueue.main.async {
                        self.view.activityStopAnimating()
                    }
                    
                }catch{
                    print("sudeep"+error.localizedDescription)
                }
                }.resume()
        }
    
    func addRippleEffect(to referenceView: UIView) {
                /*! Creates a circular path around the view*/
                let path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: referenceView.bounds.size.width, height: referenceView.bounds.size.height))
                /*! Position where the shape layer should be */
                let shapePosition = CGPoint(x: referenceView.bounds.size.width / 2.0, y: referenceView.bounds.size.height / 2.0)
                let rippleShape = CAShapeLayer()
                rippleShape.bounds = CGRect(x: 0, y: 0, width: referenceView.bounds.size.width, height: referenceView.bounds.size.height)
                rippleShape.path = path.cgPath
                rippleShape.fillColor = UIColor.clear.cgColor
                rippleShape.strokeColor = UIColor.black.cgColor
                rippleShape.lineWidth = 5
                rippleShape.position = shapePosition
                rippleShape.opacity = 0

                /*! Add the ripple layer as the sublayer of the reference view */
                referenceView.layer.addSublayer(rippleShape)
                /*! Create scale animation of the ripples */
                let scaleAnim = CABasicAnimation(keyPath: "transform.scale")
                scaleAnim.fromValue = NSValue(caTransform3D: CATransform3DIdentity)
                scaleAnim.toValue = NSValue(caTransform3D: CATransform3DMakeScale(2, 2, 1))
                /*! Create animation for opacity of the ripples */
                let opacityAnim = CABasicAnimation(keyPath: "opacity")
                opacityAnim.fromValue = 1
                opacityAnim.toValue = 0
                /*! Group the opacity and scale animations */
                let animation = CAAnimationGroup()
                animation.animations = [scaleAnim, opacityAnim]
                animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
                animation.duration = CFTimeInterval(1.0)
        animation.repeatCount = .signalingNaN
                animation.isRemovedOnCompletion = true
                rippleShape.add(animation, forKey: "rippleEffect")
            }
    
    private func showAlert(message:String)  {
        let refreshAlert = UIAlertController(title: "Info!", message: message, preferredStyle: UIAlertController.Style.alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: { [self] (action: UIAlertAction!) in
            //showMobileLayout()
        }))

        present(refreshAlert, animated: true, completion: nil)

    }
    
    private func feedbackShowAlert(message:String)  {
        let refreshAlert = UIAlertController(title: "Info!", message: message, preferredStyle: UIAlertController.Style.alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: { [self] (action: UIAlertAction!) in
            //showMobileLayout()
            self.isModalInPresentation = false
            self.dismiss(animated: true, completion: nil)
        }))

        present(refreshAlert, animated: true, completion: nil)

    }
    func showInternetAlert() {
           if !AppUtilityFunctions.isInternetAvailable() {
               self.inernetAlert(title: "Warning",message: "The Internet is not available")
           }
       }

   func inernetAlert(title:String,message:String)
       {
           DispatchQueue.main.async {
              
           let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
           let action = UIAlertAction(title: "Dismiss", style: .default, handler:{ (action: UIAlertAction!) in
               self.navigationController?.popToRootViewController(animated: true)
           })
           alert.addAction(action)
           self.present(alert, animated: true, completion: nil)
               
           }
       }
}

extension FeedbackViewController: UITextViewDelegate {

    func textViewDidBeginEditing(_ textView: UITextView) {
           if textView.text == placeholder {
               textView.text = ""
               textView.textColor = UIColor.black
               textView.font = UIFont(name: "verdana", size: 18.0)

           }
       }
    func textViewDidEndEditing(_ textView: UITextView) {
           if textView.text == "" {
               textView.text = placeholder
               textView.textColor = UIColor.lightGray
               textView.font = UIFont(name: "verdana", size: 18.0)

           }
       }
    func textViewDidChangeSelection(_ textView: UITextView) {
        // Move cursor to beginning on first tap
        if textView.text == placeholder {
            textView.selectedRange = NSRange(location: 0, length: 0)
        }
    }

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if textView.text == placeholder {
            textView.text = nil
            textView.textColor = UIColor.black
            textView.selectedRange = NSRange(location: 0, length: 0)
            
        }else{
            let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
            return newText.count <= 1000
        }
        return true
    }

    func textViewDidChange(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.textColor = UIColor.lightGray
            textView.text = placeholder
            remain_text_lbl.text = "0 / 1000"
        }else{
            remain_text_lbl.text = "\(feedback_tf.text!.count) / 1000"
            if (feedback_tf.text!.count == 1000) {
                       reached_limit_lbl.isHidden = false
                       } else {
                       reached_limit_lbl.isHidden = true
                       }
        }
        
      
    }
}
