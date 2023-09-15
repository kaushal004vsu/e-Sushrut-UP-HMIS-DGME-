//
//  DrugFillViewController.swift
//  SAIL Bokaro
//
//  Created by HICDAC on 28/07/23.
//

import UIKit

class DrugFillViewController: UIViewController {
    
    @IBOutlet weak var close_iv: UIImageView!
    let searchController=UISearchController(searchResultsController: nil)
    
    var callBack: ((_ id: String, _ name: String, _ age: String)-> Void)?
    
    var from:Int = 0
    var zoneId:String = ""
    var divisionId:String = ""
    var hospCode:String = ""
        
    override func viewDidLoad() {
        super.viewDidLoad()
   
        close_iv.layer.cornerRadius = close_iv.frame.height / 2
        close_iv.clipsToBounds = true
        showAlert()
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(closeTapped(tapGestureRecognizer:)))
        close_iv.isUserInteractionEnabled = true
        close_iv.addGestureRecognizer(tapGestureRecognizer)
        
    }
    @objc func closeTapped(tapGestureRecognizer: UITapGestureRecognizer){
        self.isModalInPresentation = false
        self.dismiss(animated: true, completion: nil)
    }
    
    func showAlert() {
        if !AppUtilityFunctions.isInternetAvailable() {
            alert(title: "Warning",message: "The Internet is not available")
        }
    }
    func alert(title:String,message:String)
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
