//
//  ImageHeaderTableViewCell.swift
//  EatList
//
//  Created by Christian Alvarez on 12/29/20.
//

import UIKit

class ImageHeaderTableViewCell: UITableViewCell, NibReusable {

    @IBOutlet weak var headerImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
