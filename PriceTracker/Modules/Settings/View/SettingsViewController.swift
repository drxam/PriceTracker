//
//  SettingsViewController.swift
//  PriceTracker
//
//  Created by dread on 25.12.2024.
//

import UIKit

final class SettingsViewController: UIViewController {
    var settingsView = SettingsView()
    var router: SettingsRouterProtocol?
    var interactor: SettingsBusinessLogic?
    
    override func loadView() {
        view = settingsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        settingsView.button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        settingsView.switch1.addTarget(self, action: #selector(toggleTheme), for: .touchUpInside)
        settingsView.switch2.addTarget(self, action: #selector(toggleNotifications), for: .touchUpInside)
    }
    
    private func confirmClear() {
        print(24234)
    }
    
    @objc private func buttonTapped() {
        router?.showAlert(title: "Вы уверены, что хотите очистить историю покупок?", confirmTitle: "Очистить", cancelTitle: "Отмена", onConfirm: confirmClear)
    }
    
    @objc func toggleTheme() {
        let currentStyle = view.window?.overrideUserInterfaceStyle
        let newStyle: UIUserInterfaceStyle = (currentStyle == .dark) ? .light : .dark
        view.window?.overrideUserInterfaceStyle = newStyle
        
        UserDefaults.standard.set(newStyle == .dark, forKey: "isDarkMode")
    }
    
    @objc func toggleNotifications() {
        interactor?.toggleNotifications()
    }
}
