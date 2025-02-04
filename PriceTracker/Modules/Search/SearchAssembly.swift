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
    
    class func configureModule() -> UIViewController {
        let view = SearchViewController()
        let router = SearchRouter()
        
        view.router = router
        router.view = view
        
        return view
    }
}
