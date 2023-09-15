

import UIKit
class EnterCrViewController: UIViewController,UITextFieldDelegate, URLSessionDelegate{
    
    
    @IBOutlet weak var txtEnterCr: UITextField!
    
    @IBOutlet weak var proceed_btn: UIButton!
    
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // prepareBackgroundView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        proceed_btn.layer.cornerRadius = 10
       
        self.title = "Lab Reports"
        self.hideKeyboardWhenTappedAround()
        if UserDefaults.standard.object(forKey: "udCrno") != nil  {
           // txtEnterCr.text=(UserDefaults.standard.object(forKey: "udCrno") as! String)
            
        }
//        UIView.animate(withDuration: 0.3) { [weak self] in
//              let frame = self?.view.frame
//              let yComponent = UIScreen.main.bounds.height - 200
//            self?.view.frame = CGRect(x: 0, y: yComponent, width: frame!.width, height: frame!.height)
//          }
    }
    @IBAction func btnProceed(_ sender: Any) {
        
        if txtEnterCr.text?.isEmpty == true
        {
            DispatchQueue.main.async {
                self.showAlert(message: "Please Enter CR Number.")
            }
            return
        }
       else if txtEnterCr.text?.count != 15
        {
            DispatchQueue.main.async {
            self.showAlert(message: "CR number should be of 15 digits.")
            }
            return
        }
        
        else{
                   UserDefaults.standard.set(txtEnterCr.text!, forKey: "udCrno")
             self.navigationController?.popViewController(animated: true)
    
        }

        
    }
 
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return txtEnterCr.resignFirstResponder()
    }
    func showAlert(message:String)
    {
        let alertController = UIAlertController(title: "Alert", message:message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 15
        let currentString: NSString = (textField.text ?? "") as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }
    
    
    func prepareBackgroundView(){
        let blurEffect = UIBlurEffect.init(style: .regular)
        let visualEffect = UIVisualEffectView.init(effect: blurEffect)
        let bluredView = UIVisualEffectView.init(effect: blurEffect)
        bluredView.contentView.addSubview(visualEffect)

        visualEffect.frame = UIScreen.main.bounds
        bluredView.frame = UIScreen.main.bounds

        view.insertSubview(bluredView, at: 0)
    }

    
}
