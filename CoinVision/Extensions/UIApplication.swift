//
//  UIApplication.swift
//  CoinVision
//
//  Created by Emre Tatlıcı on 2.12.2024.
//


import Foundation
import SwiftUI

// Dismising the keyboard
extension UIApplication {
    
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil,for: nil)
    }
}


