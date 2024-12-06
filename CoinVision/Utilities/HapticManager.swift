//
//  HapticManager.swift
//  CoinVision
//
//  Created by Emre Tatlıcı on 4.12.2024.
//

import Foundation
import SwiftUI

class HapticManager {
    
    static private let generator = UINotificationFeedbackGenerator()
    
    static func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        generator.notificationOccurred(type)
            
    }
}
