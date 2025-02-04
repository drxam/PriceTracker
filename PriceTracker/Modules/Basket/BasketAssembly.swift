//
//  BasketAssembly.swift
//  PriceTracker
//
//  Created by dread on 18.01.2025.
//

import Foundation
import UIKit

final class BasketAssembly: NSObject {
    weak var viewController: UIViewController!
    
    class func configureModule() -> UIViewController {
        let view = BasketViewController()
        let router = BasketRouter()
        
        view.router = router
        router.view = view
        
        return view
    }
}
