//
//  ProductAssembly.swift
//  PriceTracker
//
//  Created by dread on 18.01.2025.
//

import Foundation
import UIKit

final class ProductAssembly: NSObject {
    weak var viewController: UIViewController!
    
    class func configureModule(shop: ShopType, category: String, productId: String) -> UIViewController {
        let view = ProductViewController()
        let interactor = ProductInteractor()
        let presenter = ProductPresenter()
        let router = ProductRouter()
        
        view.router = router
        view.interactor = interactor
        interactor.presenter = presenter
        presenter.view = view
        router.view = view
        
        view.configure(shop: shop, category: category, productId: productId)
        
        return view
    }
}
