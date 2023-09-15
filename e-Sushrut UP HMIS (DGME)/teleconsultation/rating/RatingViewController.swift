//
//  RatingViewController.swift
//  e-Sushrut HMIS SAIL Rourkela
//
//  Created by HICDAC on 18/10/22.
//

import UIKit

class RatingViewController: UIViewController, URLSessionDelegate,UITextFieldDelegate {
    /// Сreate a variable in which we will store the current rating Int
   var requestId = ""
    var hopCode = ""
    @IBOutlet weak var review_tf: UITextView!
    var placeholderLabel : UILabel!
   
    private var selectedRate: Int = 0
    
    @IBOutlet weak var star_iv1: UIImageView!
    @IBOutlet weak var star_iv2: UIImageView!
    @IBOutlet weak var star_iv3: UIImageView!
    @IBOutlet weak var star_iv4: UIImageView!
    @IBOutlet weak var star_iv5: UIImageView!
    @IBOutlet weak var sendButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
      cutomTF(testview: review_tf,placeHolderText: "Enter your remarks(maximum 300 characters)")
    
        let tapGesture1 = UITapGestureRecognizer(target: self, action: #selector(imageTapped1(tapGestureRecognizer:)))
        star_iv1.isUserInteractionEnabled = true
        star_iv1.addGestureRecognizer(tapGesture1)
        
        let tapGesture2 = UITapGestureRecognizer(target: self, action: #selector(imageTapped2(tapGestureRecognizer:)))
        star_iv2.isUserInteractionEnabled = true
        star_iv2.addGestureRecognizer(tapGesture2)
        
        let tapGesture3 = UITapGestureRecognizer(target: self, action: #selector(imageTapped3(tapGestureRecognizer:)))
        star_iv3.isUserInteractionEnabled = true
        star_iv3.addGestureRecognizer(tapGesture3)
        
        let tapGesture4 = UITapGestureRecognizer(target: self, action: #selector(imageTapped4(tapGestureRecognizer:)))
        star_iv4.isUserInteractionEnabled = true
        star_iv4.addGestureRecognizer(tapGesture4)
        
        let tapGesture5 = UITapGestureRecognizer(target: self, action: #selector(imageTapped5(tapGestureRecognizer:)))
        star_iv5.isUserInteractionEnabled = true
        star_iv5.addGestureRecognizer(tapGesture5)
        
       
    }
   
    @objc func imageTapped1(tapGestureRecognizer: UITapGestureRecognizer){
       // let tappedImage1 = tapGestureRecognizer.view as! UIImageView
            selectedRate = 1
            self.star_iv1.isHighlighted = true
            self.star_iv2.isHighlighted = false
            self.star_iv3.isHighlighted = false
            self.star_iv4.isHighlighted = false
            self.star_iv5.isHighlighted = false
         
    }
    @objc func imageTapped2(tapGestureRecognizer: UITapGestureRecognizer){
            selectedRate = 2
            self.star_iv1.isHighlighted = true
            self.star_iv2.isHighlighted = true
            self.star_iv3.isHighlighted = false
            self.star_iv4.isHighlighted = false
            self.star_iv5.isHighlighted = false
        
    }
    @objc func imageTapped3(tapGestureRecognizer: UITapGestureRecognizer){
            selectedRate = 3
            self.star_iv1.isHighlighted = true
            self.star_iv2.isHighlighted = true
            self.star_iv3.isHighlighted = true
            self.star_iv4.isHighlighted = false
            self.star_iv5.isHighlighted = false
    }
    @objc func imageTapped4(tapGestureRecognizer: UITapGestureRecognizer){
            selectedRate = 4
            self.star_iv1.isHighlighted = true
            self.star_iv2.isHighlighted = true
            self.star_iv3.isHighlighted = true
            self.star_iv4.isHighlighted = true
            self.star_iv5.isHighlighted = false
        
    }
    @objc func imageTapped5(tapGestureRecognizer: UITapGestureRecognizer){
            selectedRate = 5
            self.star_iv1.isHighlighted = true
            self.star_iv2.isHighlighted = true
            self.star_iv3.isHighlighted = true
            self.star_iv4.isHighlighted = true
            self.star_iv5.isHighlighted = true
    }
    
    @IBAction func submit_btn(_ sender: Any) {
        if selectedRate != 0 {
            callFeedbackService(requestId: self.requestId, hospCode: self.hopCode)
        }else{
            self.alertEmptyRate(title: "", message: "Please give ratings")
        }
      
    }
    private func callFeedbackService(requestId:String, hospCode:String)
    {
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.black.withAlphaComponent(0.5))
        }
        
        let json: [String: String] = [
            "requestId": requestId,
            "hospCode": hospCode,
            "remarks": self.review_tf.text!,
            "feedback": String(selectedRate),
        ]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json)

        print("jsonData \(json)")
        // create post request
        let url = URL(string: ServiceUrl.feedbackUrl)! //PUT Your URL
    
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        // insert json data to the request
        request.httpBody = jsonData

        let task = URLSession.shared.dataTask(with: request) {
            data, response, error in guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
               print(responseJSON)
                DispatchQueue.main.async {
                    self.view.activityStopAnimating()
                    self.alert(title: "", message: "Feedback has been submitted successfully")
                    }
              
         }
        }

        task.resume()
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        var newText = review_tf.text!
        newText.removeAll { (character) -> Bool in
            return character == " " || character == "\n"
        }

        return (newText.count + text.count) <= 300
    }

    
    func alert(title:String,message:String)  {
        DispatchQueue.main.async {
           
        let alertController = UIAlertController(title: title, message:
           message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Home", style: .default, handler: { (action: UIAlertAction!) in
            self.navigationController?.popToRootViewController(animated: true)
      }))
            let attributedString = NSAttributedString(string: message, attributes: [
                        NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20),
                        NSAttributedString.Key.foregroundColor : UIColor.systemGreen
                    ])
            alertController.setValue(attributedString, forKey: "attributedMessage")
            
            self.present(alertController, animated: true, completion: nil)
            
        }
    }
    func alertEmptyRate(title:String,message:String)  {
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
    func cutomTF(testview:UITextView,placeHolderText:String){
        testview.delegate = self
               placeholderLabel = UILabel()
               placeholderLabel.text = placeHolderText
               placeholderLabel.font = .italicSystemFont(ofSize: (testview.font?.pointSize)!)
               placeholderLabel.sizeToFit()
        testview.addSubview(placeholderLabel)
               placeholderLabel.frame.origin = CGPoint(x: 5, y: (testview.font?.pointSize)! / 2)
               placeholderLabel.textColor = .tertiaryLabel
               placeholderLabel.isHidden = !testview.text.isEmpty
    }
}
extension RatingViewController : UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        placeholderLabel.isHidden = !textView.text.isEmpty
    }
}
