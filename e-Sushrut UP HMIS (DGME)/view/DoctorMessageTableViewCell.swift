//
//  DoctorMessageTableViewCell.swift
//  AIIMS Mangalagiri e-Paramarsh
//
//  Created by sudeep rai on 09/09/20.
//  Copyright © 2020 CDAC NOIDA. All rights reserved.
//

import UIKit

class DoctorMessageTableViewCell: UITableViewCell {

    @IBOutlet weak var messageBackgroundView: UIView!
    
    @IBOutlet weak var lblSentBy: UILabel!
    @IBOutlet weak var lblMessage: UILabel!
    
    
    @IBOutlet weak var lblDateTime: UILabel!
    
    
    var trailingConstraints: NSLayoutConstraint!
    var leadingConstraints: NSLayoutConstraint!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        lblMessage.text=nil
        lblDateTime.text=nil
        lblSentBy.text=nil
        leadingConstraints.isActive=false
        trailingConstraints.isActive=false
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    func updateMessageCell(by message:DoctorMessageModel)
    {
        messageBackgroundView.layer.cornerRadius=16
        messageBackgroundView.clipsToBounds=true
        trailingConstraints=messageBackgroundView.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -20)
        
        leadingConstraints=messageBackgroundView.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 20)
        
        lblMessage.text=message.message
        lblDateTime.text=message.dateTime
        lblSentBy.text=message.name
        
        
        if message.isMe {
            messageBackgroundView.backgroundColor = UIColor(red: 53/255.0, green: 150/255.0, blue: 255/255.0, alpha: 1.0)
            trailingConstraints.isActive=true
            lblMessage.textAlignment = .right
            lblDateTime.textAlignment = .right
            lblSentBy.textAlignment = .right
        }
        else
        {
            messageBackgroundView.backgroundColor = UIColor(red: 83/255.0, green: 167/255.0, blue: 93/255.0, alpha: 1.0)
            leadingConstraints.isActive=true
            lblMessage.textAlignment = .left
            lblDateTime.textAlignment = .left
             lblSentBy.textAlignment = .left
        }
    }
}
