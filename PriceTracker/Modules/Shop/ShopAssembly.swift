//
//  ShopAssembly.swift
//  PriceTracker
//
//  Created by dread on 15.01.2025.
//

import Foundation
import UIKit

final class ShopAssembly: NSObject {
    weak var viewController: UIViewController!
    
    class func configureModule(with shopType: ShopType) -> UIViewController {
        let view = ShopViewController()
        let interactor = ShopInteractor()
        let presenter = ShopPresenter()
        let router = ShopRouter()
        
        view.router = router
        view.interactor = interactor
        interactor.presenter = presenter
        presenter.view = view
        router.view = view
        
        view.configureShopType(shopType)
        return view
    }
}
