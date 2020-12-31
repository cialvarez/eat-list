//
//  TargetDetailsSectionType.swift
//  EatList
//
//  Created by Christian Alvarez on 12/29/20.
//

import Foundation
import UIKit

enum TargetDetailsSectionType {
    case imageHeader(parameters: ImageHeaderTableViewCell.Parameters)
    case baseDetails(parameters: BaseDetailsTableViewCell.Parameters)
    case addressDetails(parameters: AddressDetailsTableViewCell.Parameters)
    case highlights(parameters: HighlightsTableViewCell.Parameters)
}

extension TargetDetailsSectionType: Equatable {
    static func == (lhs: TargetDetailsSectionType, rhs: TargetDetailsSectionType) -> Bool {
        switch (lhs, rhs) {
        case let (.imageHeader(lhsParameters), .imageHeader(rhsParameters)):
            return lhsParameters == rhsParameters
        case let (.baseDetails(lhsParameters), .baseDetails(rhsParameters)):
            return lhsParameters == rhsParameters
        case let (.addressDetails(lhsParameters), .addressDetails(rhsParameters)):
            return lhsParameters == rhsParameters
        case let (.highlights(lhsParameters), .highlights(rhsParameters)):
            return lhsParameters == rhsParameters
        default: return false
        }
    }
}

extension TargetDetailsSectionType: TableViewCellTypeProtocol {

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
    
    var estimatedHeight: CGFloat {
        switch self {
        case .imageHeader:
            return 250
        case .baseDetails,
             .addressDetails,
             .highlights:
            return 200
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
