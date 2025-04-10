//
//  HistoryAssembly.swift
//  PriceTracker
//
//  Created by dread on 15.01.2025.
//

import Foundation
import UIKit

final class HistoryAssembly: NSObject {
    weak var viewController: UIViewController?
    
    class func configureModule() -> UIViewController {
        let view = HistoryViewController()
        let router = HistoryRouter()
        
        view.router = router
        router.view = view
        
        return view
    }
}
