//
//  PurchasesAssembly.swift
//  PriceTracker
//
//  Created by dread on 15.01.2025.
//

import Foundation
import UIKit

class PurchasesAssembly: NSObject {
    weak var viewController: UIViewController!
    
    class func configureModule() -> UIViewController {
        let view = PurchasesViewController()
        let router = PurchasesRouter()
        
        view.router = router
        router.view = view
        
        return view
    }
}
