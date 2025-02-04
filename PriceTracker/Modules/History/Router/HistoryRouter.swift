//
//  HistoryRouter.swift
//  PriceTracker
//
//  Created by dread on 15.01.2025.
//

import Foundation
import UIKit

final class HistoryRouter: HistoryRouterProtocol {
    var view: UIViewController?
    
    func dismissHistoryScreen() {
        view?.dismiss(animated: true)
    }
}
