//
//  LatestPriceModel.swift
//  TaskApp
//
//  Created by Prabhat Kasera on 16/11/23.
//

import Foundation
// MARK: - CryptoResponse
struct CryptoResponse: Codable {
    let status: Status?
    var data: [CryptoData]?
}

// MARK: - CryptoData
struct CryptoData: Codable {
    let id: Int?
    let infiniteSupply: Bool?
    let maxSupply: Int?
    let symbol, lastUpdated: String?
    let tags: [String]?
    let circulatingSupply: Double?
    let cmcRank: Int?
    let slug: String?
    let quote: Quote?
    let totalSupply: Double?
    let numMarketPairs: Int?
    let name, dateAdded: String?

    enum CodingKeys: String, CodingKey {
        case id
        case infiniteSupply = "infinite_supply"
        case maxSupply = "max_supply"
        case symbol
        case lastUpdated = "last_updated"
        case tags
        case circulatingSupply = "circulating_supply"
        case cmcRank = "cmc_rank"
        case slug, quote
        case totalSupply = "total_supply"
        case numMarketPairs = "num_market_pairs"
        case name
        case dateAdded = "date_added"
    }
}

// MARK: - Quote
struct Quote: Codable {
    let usd: Usd?

    enum CodingKeys: String, CodingKey {
        case usd = "USD"
    }
}

// MARK: - Usd
struct Usd: Codable {
    let percentChange24H, percentChange90D, fullyDilutedMarketCap: Double?
    let lastUpdated: String?
    let volumeChange24H: Double?
    let percentChange7D, price, percentChange30D, volume24H: Double?
    let percentChange60D, marketCapDominance, percentChange1H, marketCap: Double?

    enum CodingKeys: String, CodingKey {
        case percentChange24H = "percent_change_24h"
        case percentChange90D = "percent_change_90d"
        case fullyDilutedMarketCap = "fully_diluted_market_cap"
        case lastUpdated = "last_updated"
        case volumeChange24H = "volume_change_24h"
        case percentChange7D = "percent_change_7d"
        case price
        case percentChange30D = "percent_change_30d"
        case volume24H = "volume_24h"
        case percentChange60D = "percent_change_60d"
        case marketCapDominance = "market_cap_dominance"
        case percentChange1H = "percent_change_1h"
        case marketCap = "market_cap"
    }
}

// MARK: - Status
struct Status: Codable {
    let elapsed: Int?

    let errorCode, creditCount: Int?
    let timestamp: String?
    let totalCount: Int?

    enum CodingKeys: String, CodingKey {
        case elapsed
        case errorCode = "error_code"
        case creditCount = "credit_count"
        case timestamp
        case totalCount = "total_count"
    }
}

