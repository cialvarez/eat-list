//
//  EatListSectionType.swift
//  EatList
//
//  Created by Christian Alvarez on 12/30/20.
//

import Foundation
import UIKit

enum EatListSectionType {
    case restaurantDetails(parameters: EatListTableViewCell.Parameters,
                           restaurantDetails: RestaurantDetails,
                           wantsToViewRestaurant: (RestaurantDetails) -> Void)
    case skeletonLoader
    case emptyState
}

extension EatListSectionType: TableViewCellTypeProtocol {
 
    typealias TableViewCellModelType = RestaurantDetails
    
    var reuseIdentifier: String {
        switch self {
        case .restaurantDetails,
             .skeletonLoader:
            return R.nib.eatListTableViewCell.name
        case .emptyState:
            return R.nib.eatListBlankTableViewCell.name
        }
    }
    
    var height: CGFloat {
        switch self {
        case .restaurantDetails,
             .skeletonLoader,
             .emptyState:
            return UITableView.automaticDimension
        }
    }
    
    var estimatedHeight: CGFloat {
        switch self {
        case .restaurantDetails,
             .skeletonLoader:
            return 100
        case .emptyState:
            return 300
        }
    }
    
    var cellSelectBlock: RowSelectedBlock? {
        switch self {
        case let .restaurantDetails(_, restaurantDetails, wantsToViewRestaurant):
            return { _, _ in
                wantsToViewRestaurant(restaurantDetails)
            }
        case .skeletonLoader,
             .emptyState:
            return nil
        }
    }
    
    var cellSetupBlock: ViewSetupBlock? {
        switch self {
        case let .restaurantDetails(parameters, _, _):
            return { cell in
                guard let cell = cell as? EatListTableViewCell else {
                    return
                }
                cell.render(with: parameters)
            }
        case .skeletonLoader:
            return { cell in
                guard let cell = cell as? EatListTableViewCell else {
                    return
                }
                cell.toggleLoadingState(isLoading: true)
            }
        case .emptyState: return nil
        }
    }
}
