//
//  MainAssembly.swift
//  PriceTracker
//
//  Created by dread on 24.12.2024.
//

import Foundation
import UIKit

final class MainAssembly: NSObject {
    weak var viewController: UIViewController?
    
    class func configureModule() -> UIViewController {
        let view = MainViewController()
        let interactor = MainInteractor()
        let presenter = MainPresenter()
        let router = MainRouter()
        
        view.router = router
        view.interactor = interactor
        interactor.presenter = presenter
        presenter.view = view
        router.view = view
        
        return view
    }
}
