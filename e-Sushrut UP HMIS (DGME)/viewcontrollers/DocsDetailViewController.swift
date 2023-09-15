//
//  DocsDetailViewController.swift
//  e-Sushrut HMIS SAIL Rourkela
//
//  Created by HICDAC on 14/07/22.
//

import UIKit
import Zoomy
class DocsDetailViewController: UIViewController {

    var base64Send:String = ""
    var docsTitle:String = ""
    var docsType = ""
    
    @IBOutlet weak var docsImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
                
    base64Toimage(base64: base64Send)
        addZoombehavior(for: docsImage)
        let settings = Settings.defaultSettings
            .with(actionOnTapOverlay: Action.dismissOverlay)
            .with(actionOnDoubleTapImageView: Action.zoomIn)
                
        addZoombehavior(for: docsImage, settings: settings)
       
    }
    
    func base64Toimage(base64:String) -> (){
        let dataDecoded : Data = Data(base64Encoded: base64Send, options: .ignoreUnknownCharacters)!
        let decodedimage = UIImage(data: dataDecoded)
        DispatchQueue.main.async {
           self.docsImage.image = decodedimage
        }
        
    }
    
    
    
}


