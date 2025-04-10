//
//  BasketAssembly.swift
//  PriceTracker
//
//  Created by dread on 18.01.2025.
//

import Foundation
import UIKit

final class BasketAssembly: NSObject {
    weak var viewController: UIViewController?
    
    class func configureModule() -> UIViewController {
        let view = BasketViewController()
        let interactor = BasketInteractor()
        let presenter = BasketPresenter()
        let router = BasketRouter()
        
        view.router = router
        view.interactor = interactor
        interactor.presenter = presenter
        presenter.view = view
        router.view = view
        
        view.configureNotificationCenter()
        
        return view
    }
}
