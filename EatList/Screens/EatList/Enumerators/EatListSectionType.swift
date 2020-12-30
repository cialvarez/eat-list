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
}

extension EatListSectionType: TableViewCellTypeProtocol {

    typealias TableViewCellModelType = RestaurantDetails
    
    var reuseIdentifier: String {
        switch self {
        case .restaurantDetails,
             .skeletonLoader:
            return R.nib.eatListTableViewCell.name
        }
    }
    
    var height: CGFloat {
        switch self {
        case .restaurantDetails,
             .skeletonLoader:
            return UITableView.automaticDimension
        }
    }
    
    var cellSelectBlock: RowSelectedBlock? {
        switch self {
        case let .restaurantDetails(_, restaurantDetails, wantsToViewRestaurant):
            return { _, _ in
                wantsToViewRestaurant(restaurantDetails)
            }
        case .skeletonLoader: return nil
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
                cell.toggleSkeleton(isShown: true)
            }
        }
    }
}
