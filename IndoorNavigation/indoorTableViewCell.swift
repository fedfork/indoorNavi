//
//  indoorTableViewCell.swift
//  indoor navigation a


import UIKit

class indoorTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLab: UILabel!
    
    @IBOutlet weak var commentLab: UILabel!
    
    @IBOutlet weak var proxLab: UILabel!

    @IBOutlet weak var floorLab: UILabel!
    
    @IBOutlet weak var locPic: UIImageView!
    
    @IBOutlet weak var mainImg: UIImageView!
    
    @IBOutlet weak var floorImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
