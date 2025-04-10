//
//  SearchViewController+UITextViewDelegate.swift
//  PriceTracker
//
//  Created by dread on 19.01.2025.
//

import Foundation
import UIKit

extension SearchViewController: UITextViewDelegate {
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
        if text == "\n" {
            configure(textView.text, self.shopType)
            return false
        }
        return true
    }
}
