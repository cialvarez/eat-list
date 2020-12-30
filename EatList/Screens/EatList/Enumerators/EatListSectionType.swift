//
//  EatListSectionType.swift
//  EatList
//
//  Created by Christian Alvarez on 12/30/20.
//

import Foundation
import UIKit

enum EatListSectionType {
    case imageHeader(parameters: ImageHeaderTableViewCell.Parameters)
    case baseDetails(parameters: BaseDetailsTableViewCell.Parameters)
    case addressDetails(parameters: AddressDetailsTableViewCell.Parameters)
    case highlights(parameters: HighlightsTableViewCell.Parameters)
}

extension EatListSectionType: TableViewCellTypeProtocol {

    typealias TableViewCellModelType = RestaurantDetails
    
    var reuseIdentifier: String {
        switch self {
        case .imageHeader: return R.nib.imageHeaderTableViewCell.name
        case .baseDetails: return R.nib.baseDetailsTableViewCell.name
        case .addressDetails: return R.nib.addressDetailsTableViewCell.name
        case .highlights: return R.nib.highlightsTableViewCell.name
        }
    }
    
    var height: CGFloat {
        switch self {
        case .imageHeader:
            return 250
        case .baseDetails,
             .addressDetails,
             .highlights:
            return UITableView.automaticDimension
        }
    }
    
    var cellSelectBlock: RowSelectedBlock? {
        return nil
    }
    
    var cellSetupBlock: ViewSetupBlock? {
        switch self {
        case let .imageHeader(parameters):
            return { cell in
                guard let cell = cell as? ImageHeaderTableViewCell else {
                    return
                }
                cell.render(with: parameters)
            }
        case let .baseDetails(parameters):
            return { cell in
                guard let cell = cell as? BaseDetailsTableViewCell else {
                    return
                }
                cell.render(with: parameters)
            }
        case let .addressDetails(parameters):
            return { cell in
                guard let cell = cell as? AddressDetailsTableViewCell else {
                    return
                }
                cell.render(with: parameters)
            }
        case let .highlights(parameters):
            return { cell in
                guard let cell = cell as? HighlightsTableViewCell else {
                    return
                }
                cell.render(with: parameters)
            }
        }
    }
}
