//
//  SettingsView.swift
//  PriceTracker
//
//  Created by dread on 25.12.2024.
//

import UIKit

final class SettingsView: UIView {
    let screenTitle = UILabel()
    
    let wrap = UIView()
    
    let setting1 = UILabel()
    let switch1 = UISwitch()
    let line1 = UIView()
    let setting2 = UILabel()
    let switch2 = UISwitch()
    let line2 = UIView()
    let button = UIButton()
    
    init() {
        super.init(frame: .zero)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        backgroundColor = .systemGray5
        configureScreenName()
        configureWrap()
        configureSettings()
        configureButton()
    }
    
    private func configureScreenName() {
        addSubview(screenTitle)
        screenTitle.font = UIFont.boldSystemFont(ofSize: 22)
        screenTitle.text = "Настройки"
        screenTitle.pinTop(to: self.safeAreaLayoutGuide.topAnchor)
        screenTitle.pinLeft(to: self.leadingAnchor, 30)
        screenTitle.setHeight(25)
        screenTitle.setWidth(150)
    }
    
    private func configureWrap() {
        addSubview(wrap)
        wrap.backgroundColor = UIColor(named: "wrap_color")
        wrap.layer.cornerRadius = 30
        wrap.pinTop(to: screenTitle.bottomAnchor, 13)
        wrap.pinHorizontal(to: self, 15)
        wrap.setHeight(210)
    }
    
    private func configureSettings() {
        wrap.addSubview(setting1)
        setting1.text = "Темная тема"
        setting1.font = UIFont.systemFont(ofSize: 17)
        setting1.pinTop(to: wrap.topAnchor, 20)
        setting1.pinLeft(to: wrap.leadingAnchor, 20)
        setting1.setHeight(20)
        setting1.setWidth(140)
        
        wrap.addSubview(switch1)
        switch1.isOn = UserDefaults.standard.bool(forKey: "isDarkMode")
        switch1.onTintColor = UIColor(red: 1.0, green: 98 / 255.0, blue: 0, alpha: 1)
        switch1.pinRight(to: wrap.trailingAnchor, 20)
        switch1.pinCenterY(to: setting1)
        
        wrap.addSubview(line1)
        line1.backgroundColor = .systemGray4
        line1.pinTop(to: setting1.bottomAnchor, 18)
        line1.pinHorizontal(to: wrap, 20)
        line1.setHeight(2)
        
        wrap.addSubview(setting2)
        setting2.text = "Уведомления о бездействии"
        setting2.font = UIFont.systemFont(ofSize: 17)
        setting2.lineBreakMode = .byWordWrapping
        setting2.numberOfLines = 2
        setting2.pinTop(to: line1.bottomAnchor, 10)
        setting2.pinLeft(to: wrap.leadingAnchor, 20)
        setting2.setHeight(60)
        setting2.setWidth(140)
        
        wrap.addSubview(switch2)
        switch2.isOn = UserDefaults.standard.bool(forKey: "isNotificationEnabled")
        switch2.onTintColor = UIColor(red: 1.0, green: 98 / 255.0, blue: 0, alpha: 1)
        switch2.pinRight(to: wrap.trailingAnchor, 20)
        switch2.pinCenterY(to: setting2)
        
        addSubview(line2)
        line2.backgroundColor = .systemGray4
        line2.pinTop(to: setting2.bottomAnchor, 10)
        line2.pinHorizontal(to: wrap, 20)
        line2.setHeight(2)
    }
    
    private func configureButton() {
        wrap.addSubview(button)
        button.setTitle("Очистить историю покупок", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        button.titleLabel?.textAlignment = .center
        button.setTitleColor(UIColor(named: "icon_color"), for: .normal)
        button.backgroundColor = .systemGray4
        button.layer.cornerRadius = 20
        button.pinTop(to: line2.bottomAnchor, 15)
        button.pinHorizontal(to: wrap, 50)
        button.pinBottom(to: wrap.bottomAnchor, 15)
    }
}
