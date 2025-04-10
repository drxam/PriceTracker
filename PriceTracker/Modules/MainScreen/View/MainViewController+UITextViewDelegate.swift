//
//  MainViewController+UITextViewDelegate.swift
//  PriceTracker
//
//  Created by dread on 31.12.2024.
//

import Foundation
import UIKit

extension MainViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "Поиск продуктов" {
            textView.text = ""
            textView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Поиск продуктов"
            textView.textColor = .systemGray3
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" && !textView.text.trimmingCharacters(in: .newlines).isEmpty {
            searchTapped(textView.text)
            textView.text = "Поиск продуктов"
            textView.textColor = .systemGray3
            return false
        }
        return true
    }
    
    func searchTapped(_ query: String) {
        router?.showSearchScreen(query)
    }
}
