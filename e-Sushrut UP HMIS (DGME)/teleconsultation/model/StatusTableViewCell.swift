//
//  StatusTableViewCell.swift
//  e-Sushrut HMIS SAIL Rourkela
//
//  Created by HICDAC on 29/09/22.
//

import UIKit

class StatusTableViewCell: UITableViewCell {

    @IBOutlet weak var request_status_lbl: UILabel!
    @IBOutlet weak var consultant_name_lbl: UILabel!
    @IBOutlet weak var appointment_date_lbl: UILabel!
    @IBOutlet weak var unitname_lbl: UILabel!
    @IBOutlet weak var dept_name_lbl: UILabel!
    @IBOutlet weak var request_date_lbl: UILabel!
    @IBOutlet weak var consultation_time_lbl: UILabel!
    @IBOutlet weak var btnDoc_message: UIButton!
    @IBOutlet weak var btnRateUs: UIButton!
    @IBOutlet weak var btnView_prescription_lbl: UIButton!
    @IBOutlet weak var join_call_lbl: UIButton!
    @IBOutlet weak var unatteneded_msg_lbl: UILabel!
    
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        setIconInLabel(titleText: " Consultation time/ Send Message",label:doc_message_lbl, leftIcon: UIImage(named:"notes"))
//        setIconInLabel(titleText: " Rate us",label:rate_us_lbl, leftIcon: UIImage(named:"star"))
//        setIconInLabel(titleText: " View Prescription",label: view_prescription_lbl, leftIcon: UIImage(named:"prescription_rx"))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setIconInLabel(titleText:String,label:UILabel, leftIcon: UIImage? = nil) {

        // Create Attachment
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = leftIcon
        // Set bound to reposition
        //13 is text size & 15 is image size
        let imageOffsetY: CGFloat = (13 - 15).rounded() / 2
//        imageAttachment.bounds = CGRect(x: 0, y: imageOffsetY, width: imageAttachment.image!.size.width, height: imageAttachment.image!.size.height)
        imageAttachment.bounds = CGRect(x: 0, y: imageOffsetY, width: 15, height: 15)
        // Create string with attachment
        let attachmentString = NSAttributedString(attachment: imageAttachment)
        // Initialize mutable string
        let completeText = NSMutableAttributedString(string: "")
        // Add image to mutable string
        completeText.append(attachmentString)
        // Add your text to mutable string
        let textAfterIcon = NSAttributedString(string: titleText)
        completeText.append(textAfterIcon)
        label.textAlignment = .center
        label.attributedText = completeText
       }
}
