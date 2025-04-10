//
//  PurchasesAssembly.swift
//  PriceTracker
//
//  Created by dread on 15.01.2025.
//

import Foundation
import UIKit

class PurchasesAssembly: NSObject {
    weak var viewController: UIViewController?
    
    class func configureModule() -> UIViewController {
        let view = PurchasesViewController()
        let interactor = PurchasesInteractor()
        let presenter = PurchasesPresenter()
        let router = PurchasesRouter()
        
        view.router = router
        view.interactor = interactor
        interactor.presenter = presenter
        presenter.view = view
        router.view = view
        
        view.configureNotificationCenter()
        
        return view
    }
}
