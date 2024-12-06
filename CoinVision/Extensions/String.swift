//
//  String.swift
//  CoinVision
//
//  Created by Emre Tatlıcı on 6.12.2024.
//

import Foundation

extension String {
    
    
    var removingHTMLOccurances: String {
        return self.replacingOccurrences(of: "<[^>]+>", with:"", options: .regularExpression, range: nil)
    }
    
}
