//
//  CoinDetailModel.swift
//  CoinVision
//
//  Created by Emre Tatlıcı on 4.12.2024.
//

import Foundation


// JSON DATA URL
/*
 
 URL:
    https://api.coingecko.com/api/v3/coins/bitcoin?localization=false&market_data=false&community_data=false&developer_data=false&sparkline=false

*/

struct CoinDetailModel: Codable {
    let id, symbol, name: String?
    let blockTimeInMinutes: Int?
    let hashingAlgorithm: String?
    let description: Description?
    let links: Links?
    
    enum CodingKeys: String, CodingKey {
        case id, symbol, name, description, links
        case blockTimeInMinutes = "block_time_in_minutes"
        case hashingAlgorithm = "hashing_algorithm"
    }
    
    var readableDescription: String? {
        return description?.en?.removingHTMLOccurances
    }
}

// MARK - Links
struct Links: Codable {
    let homepage: [String]?
    let subredditURL: String?
    
    enum CodingKeys: String, CodingKey {
        case homepage
        case subredditURL = "subreddit_url"
    }
}


// MARK - Description
struct Description: Codable {
    let en: String?
}
