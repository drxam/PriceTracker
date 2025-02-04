//
//  SettingsAssembly.swift
//  PriceTracker
//
//  Created by dread on 18.01.2025.
//

import Foundation
import UIKit

final class SettingsAssembly: NSObject {
    weak var viewController: UIViewController!
    
    class func configureModule() -> UIViewController {
        let view = SettingsViewController()
        let router = SettingsRouter()
        let interactor = SettingsInteractor()
        
        view.router = router
        view.interactor = interactor
        router.view = view
        
        return view
    }
}
