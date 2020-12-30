//
//  AddressDetailsTableViewCell.swift
//  EatList
//
//  Created by Christian Alvarez on 12/29/20.
//

import UIKit

class AddressDetailsTableViewCell: UITableViewCell, NibReusable {

    struct Parameters {
        let fullAddress: String
    }
    
    @IBOutlet weak var addressLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    func render(with parameters: Parameters) {
        addressLabel.text = parameters.fullAddress
    }
}
