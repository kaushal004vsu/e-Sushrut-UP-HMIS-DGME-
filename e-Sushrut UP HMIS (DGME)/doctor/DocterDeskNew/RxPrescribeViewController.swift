//
//  RxPrescribeViewController.swift
//  SAIL Bokaro
//
//  Created by HICDAC on 24/07/23.
//

import UIKit

class RxPrescribeViewController: UIViewController,UITextViewDelegate {
    @IBOutlet weak var close_iv: UIImageView!
    @IBOutlet weak var headingLbl: UILabel!
    @IBOutlet weak var treatment_advice_tv: UITextView!
    var callBack: ((_ param1: String, _ param2: String, _ param3: String)-> Void)?

    var rxStr:String!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.isModalInPresentation = true
        
//        treatment_advice_tv.delegate = self
//        treatment_advice_tv.text = "Treatment Advice:"
//        treatment_advice_tv.textColor = UIColor.lightGray
        
        if(rxStr == ""){
            treatment_advice_tv.delegate = self
            treatment_advice_tv.text = "Treatment Advice:"
            treatment_advice_tv.textColor = UIColor.lightGray
        }else{
            treatment_advice_tv.delegate = self
            treatment_advice_tv.text = rxStr
            treatment_advice_tv.textColor = UIColor.black
        }

        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(closeTapped(tapGestureRecognizer:)))
        close_iv.isUserInteractionEnabled = true
        close_iv.addGestureRecognizer(tapGestureRecognizer)
        

    }
    func textViewDidBeginEditing(_ textView: UITextView) {

        if treatment_advice_tv.textColor == UIColor.lightGray {
            treatment_advice_tv.text = ""
            treatment_advice_tv.textColor = UIColor.black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {

        if treatment_advice_tv.text == "" {
            treatment_advice_tv.text = "Treatment Advice:"
            treatment_advice_tv.textColor = UIColor.lightGray
        }
    }
    @objc func closeTapped(tapGestureRecognizer: UITapGestureRecognizer){
        self.isModalInPresentation = false
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func doneBtn(_ sender: Any) {
        var treatment_advice_str = treatment_advice_tv.text!
        if(treatment_advice_str == "Treatment Advice:"){
            callBack?("","","")
        }else{
            callBack?(treatment_advice_tv.text!,"","")
        }
        

        self.isModalInPresentation = false
        self.dismiss(animated: true, completion: nil)
        
    }
  
}
