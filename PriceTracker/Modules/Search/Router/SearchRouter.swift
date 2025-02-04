//
//  SearchRouter.swift
//  PriceTracker
//
//  Created by dread on 19.01.2025.
//

import Foundation
import UIKit

final class SearchRouter: SearchRouterProtocol {
    var view: UIViewController?
    
    func dismissSearchScreen() {
        view?.dismiss(animated: true)
    }
}
