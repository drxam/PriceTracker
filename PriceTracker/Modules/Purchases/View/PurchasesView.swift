//
//  PurchasesView.swift
//  PriceTracker
//
//  Created by dread on 25.12.2024.
//

import UIKit

final class PurchasesView: UIView {
    private let screenTitle = UILabel()
    
    private let historyWrap = UIView()
    private let analyticsWrap = UIView()
    
    var allExpenses = UILabel()
    var allEconomy = UILabel()
    var monthExpenses = UILabel()
    var monthEconomy = UILabel()
    
    var table = UITableView(frame: .zero)
    var button = UIButton()

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
        configureHistory()
        configureAnalytics()
    }
    
    private func configureScreenName() {
        addSubview(screenTitle)
        screenTitle.font = UIFont.boldSystemFont(ofSize: 22)
        screenTitle.text = "Покупки"
        screenTitle.pinTop(to: self.safeAreaLayoutGuide.topAnchor)
        screenTitle.pinLeft(to: self.leadingAnchor, 30)
        screenTitle.setHeight(25)
        screenTitle.setWidth(150)
    }
    
    private func configureHistory() {
        addSubview(historyWrap)
        historyWrap.backgroundColor = UIColor(named: "wrap_color")
        historyWrap.layer.cornerRadius = 30
        historyWrap.pinTop(to: screenTitle.bottomAnchor, 13)
        historyWrap.pinHorizontal(to: self, 15)
        historyWrap.setHeight(324)
        
        let historyTitle = UILabel()
        historyWrap.addSubview(historyTitle)
        historyTitle.text = "История покупок"
        historyTitle.font = .systemFont(ofSize: 16, weight: .bold)
        historyTitle.pinTop(to: historyWrap.topAnchor, 10)
        historyTitle.pinLeft(to: historyWrap.leadingAnchor, 20)
        historyTitle.setHeight(20)
        historyTitle.setWidth(200)
        
        let line1 = getLine()
        historyWrap.addSubview(line1)
        line1.pinTop(to: historyTitle.bottomAnchor, 10)
        line1.pinHorizontal(to: historyWrap, 15)
        
        historyWrap.addSubview(button)
        button.pinBottom(to: historyWrap.bottomAnchor)
        button.pinCenterX(to: historyWrap)
        button.setHeight(40)
        button.setWidth(300)
        button.setImage(UIImage(named: "arrow_down"), for: .normal)
        
        historyWrap.addSubview(table)
        table.separatorStyle = .singleLine
        table.separatorColor = .systemGray4
        table.isScrollEnabled = false
        table.isUserInteractionEnabled = false
        table.pinTop(to: line1.bottomAnchor, 10)
        table.pinBottom(to: button.topAnchor, 20)
        table.pinHorizontal(to: historyWrap, 15)
        table.backgroundColor = .systemBlue
    }
    
    private func configureAnalytics() {
        addSubview(analyticsWrap)
        analyticsWrap.backgroundColor = UIColor(named: "wrap_color")
        analyticsWrap.layer.cornerRadius = 30
        analyticsWrap.pinTop(to: historyWrap.bottomAnchor, 13)
        analyticsWrap.pinHorizontal(to: self, 15)
        analyticsWrap.setHeight(324)
        
        let analyticsTitle = UILabel()
        analyticsWrap.addSubview(analyticsTitle)
        analyticsTitle.text = "Аналитика расходов"
        analyticsTitle.font = .systemFont(ofSize: 16, weight: .bold)
        analyticsTitle.pinTop(to: analyticsWrap.topAnchor, 13)
        analyticsTitle.pinLeft(to: analyticsWrap.leadingAnchor, 20)
        analyticsTitle.setHeight(20)
        analyticsTitle.setWidth(200)
        
        let line1 = getLine()
        analyticsWrap.addSubview(line1)
        line1.pinHorizontal(to: analyticsWrap, 15)
        line1.pinTop(to: analyticsTitle.bottomAnchor, 10)
        
        let label1 = UILabel()
        analyticsWrap.addSubview(label1)
        label1.text = "Всего"
        label1.font = .boldSystemFont(ofSize: 14)
        label1.textColor = .systemGray
        label1.pinTop(to: line1.bottomAnchor, 7)
        label1.pinLeft(to: analyticsWrap.leadingAnchor, 20)
        
        let line2 = getLine()
        analyticsWrap.addSubview(line2)
        line2.pinTop(to: label1.bottomAnchor, 7)
        line2.pinHorizontal(to: analyticsWrap, 15)
        
        let expenses = UILabel()
        analyticsWrap.addSubview(expenses)
        expenses.text = "Расходы"
        expenses.font = .systemFont(ofSize: 14)
        expenses.pinTop(to: line2.bottomAnchor, 20)
        expenses.pinLeft(to: analyticsWrap.leadingAnchor, 20)
        expenses.setHeight(20)
        expenses.setWidth(100)
        
        analyticsWrap.addSubview(allExpenses)
        allExpenses.text = "0 ₽"
        allExpenses.font = .boldSystemFont(ofSize: 14)
        allExpenses.pinCenterY(to: expenses.centerYAnchor)
        allExpenses.pinRight(to: analyticsWrap, 20)
        
        let economy = UILabel()
        analyticsWrap.addSubview(economy)
        economy.text = "Экономия"
        economy.font = .systemFont(ofSize: 14)
        economy.pinTop(to: expenses.bottomAnchor, 20)
        economy.pinLeft(to: analyticsWrap.leadingAnchor, 20)
        economy.setHeight(20)
        economy.setWidth(100)
        
        analyticsWrap.addSubview(allEconomy)
        allEconomy.text = "0 ₽"
        allEconomy.font = .boldSystemFont(ofSize: 14)
        allEconomy.pinCenterY(to: economy.centerYAnchor)
        allEconomy.pinRight(to: analyticsWrap, 20)
        
        let line3 = getLine()
        analyticsWrap.addSubview(line3)
        line3.pinTop(to: economy.bottomAnchor, 20)
        line3.pinHorizontal(to: analyticsWrap, 15)
        
        let label2 = UILabel()
        analyticsWrap.addSubview(label2)
        label2.text = "В этом месяце"
        label2.font = .boldSystemFont(ofSize: 14)
        label2.textColor = .systemGray
        label2.pinTop(to: line3.bottomAnchor, 7)
        label2.pinLeft(to: analyticsWrap.leadingAnchor, 20)
        
        let line4 = getLine()
        analyticsWrap.addSubview(line4)
        line4.pinTop(to: label2.bottomAnchor, 7)
        line4.pinHorizontal(to: analyticsWrap, 15)
        
        let expenses1 = UILabel()
        analyticsWrap.addSubview(expenses1)
        expenses1.text = "Расходы"
        expenses1.font = .systemFont(ofSize: 14)
        expenses1.pinTop(to: line4.bottomAnchor, 20)
        expenses1.pinLeft(to: analyticsWrap.leadingAnchor, 20)
        expenses1.setHeight(20)
        expenses1.setWidth(100)
        
        analyticsWrap.addSubview(monthExpenses)
        monthExpenses.text = "0 ₽"
        monthExpenses.font = .boldSystemFont(ofSize: 14)
        monthExpenses.pinCenterY(to: expenses1.centerYAnchor)
        monthExpenses.pinRight(to: analyticsWrap, 20)
        
        let economy1 = UILabel()
        analyticsWrap.addSubview(economy1)
        economy1.text = "Экономия"
        economy1.font = .systemFont(ofSize: 14)
        economy1.pinTop(to: expenses1.bottomAnchor, 20)
        economy1.pinLeft(to: analyticsWrap.leadingAnchor, 20)
        economy1.setHeight(20)
        economy1.setWidth(100)
        
        analyticsWrap.addSubview(monthEconomy)
        monthEconomy.text = "0 ₽"
        monthEconomy.font = .boldSystemFont(ofSize: 14)
        monthEconomy.pinCenterY(to: economy1.centerYAnchor)
        monthEconomy.pinRight(to: analyticsWrap, 20)
    }
    
    private func getLine() -> UIView {
        let line = UIView()
        line.backgroundColor = .systemGray4
        line.setHeight(1)
        return line
    }
}
