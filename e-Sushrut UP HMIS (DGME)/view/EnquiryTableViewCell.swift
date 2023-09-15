
import UIKit

class EnquiryTableViewCell: UITableViewCell {

    
    
    @IBOutlet weak var lblDeptName: UILabel!
    
    
    
    @IBOutlet weak var lblLocation: UILabel!
    
    @IBOutlet weak var lblUnitDays: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
