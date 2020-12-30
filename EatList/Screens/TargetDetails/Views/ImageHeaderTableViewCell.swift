//
//  ImageHeaderTableViewCell.swift
//  EatList
//
//  Created by Christian Alvarez on 12/29/20.
//

import UIKit

class ImageHeaderTableViewCell: UITableViewCell, NibReusable {
    
    struct Parameters {
        let imageUrl: URL?
        let heroId: String
    }
    
    @IBOutlet weak var headerImageView: UIImageView! {
        didSet {
            headerImageView.kf.indicatorType = .activity
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    func render(with parameters: Parameters) {
        headerImageView.kf.setImage(with: parameters.imageUrl, placeholder: nil, options: [.transition(.fade(1.0))], progressBlock: nil)
        headerImageView.hero.id = parameters.heroId
    }
}
