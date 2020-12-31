//
//  HighlightsTableViewCell.swift
//  EatList
//
//  Created by Christian Alvarez on 12/29/20.
//

import UIKit

class HighlightsTableViewCell: UITableViewCell, NibReusable {

    struct Parameters: Equatable {
        let highlightsList: [String]
    }
    
    @IBOutlet weak var simpleCarouselView: SimpleCarouselItemView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    func render(with parameters: Parameters) {
        simpleCarouselView.updateDataSource(with: parameters.highlightsList)
    }
}
