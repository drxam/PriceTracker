//
//  PurchasesRouter.swift
//  PriceTracker
//
//  Created by dread on 15.01.2025.
//

import Foundation
import UIKit

final class PurchasesRouter: PurchasesRouterProtocol {
    weak var view: UIViewController?
        
    func presentHistoryScreen() {
        let vc = HistoryAssembly.configureModule()
        vc.modalPresentationStyle = .fullScreen
        view?.present(vc, animated: true)
    }
}
