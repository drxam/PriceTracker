//
//  SearchAssembly.swift
//  PriceTracker
//
//  Created by dread on 19.01.2025.
//

import Foundation
import UIKit

final class SearchAssembly: NSObject {
    weak var viewController: UIViewController!
    
    class func configureModule(with query: String = "", from shopType: ShopType? = nil) -> UIViewController {
        let view = SearchViewController()
        let interactor = SearchInteractor()
        let presenter = SearchPresenter()
        let router = SearchRouter()
        
        view.interactor = interactor
        view.router = router
        interactor.presenter = presenter
        presenter.view = view
        router.view = view
        
        view.configure(query, shopType)
        
        return view
    }
}
