//
//  ProductRouter.swift
//  PriceTracker
//
//  Created by dread on 18.01.2025.
//

import Foundation
import UIKit

final class ProductRouter: ProductRouterProtocol {
    weak var view: UIViewController?
    
    func dismissProductScreen() {
        view?.dismiss(animated: true)
    }
}
