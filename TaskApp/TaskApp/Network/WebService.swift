//
//  WebService.swift
//  TaskApp
//
//  Created by Prabhat Kasera on 16/11/23.
//

import Foundation

enum NetworkError : Error {
    case blankResponse
    case networkError
    case badURL
    case badResponse
}
struct WebURLs{
    static let latestURL = "https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest?limit=20"
    static let imageURL = "https://s2.coinmarketcap.com/static/img/coins/64x64/"
}
class WebService {
    
    func getLatestPriceUpdate(completion: @escaping (Result<CryptoResponse?, Error>) -> ()) {
        guard let url = URL(string: WebURLs.latestURL) else {
            DispatchQueue.main.async {
                completion(.failure(NetworkError.badURL))
            }
            return
        }
        var request = URLRequest(url: url)
        request.setValue("15a26c94-3e20-43ec-b0c5-d932841a576a", forHTTPHeaderField: "X-CMC_PRO_API_KEY")
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                DispatchQueue.main.async {
                    completion(.failure(NetworkError.networkError))
                }
                return
            }
            do {
                let response = try JSONDecoder().decode(CryptoResponse.self, from: data)
                    completion(.success(response))
            } catch {
                DispatchQueue.main.async {
                    print(error)
                    completion(.failure(NetworkError.badResponse))
                }
            }
        }.resume()
    }
    static func getImageURLForCryptoData(data : CryptoData) -> URL? {
        return URL(string: "\(WebURLs.imageURL)\(data.id ?? 1).png")
    }
}

let jsonString = """
   {
       "status": {
           "elapsed": 24,
           "notice": null,
           "error_message": null,
           "error_code": 0,
           "credit_count": 1,
           "timestamp": "2023-11-16T17:17:30.172Z",
           "total_count": 8841
       },
       "data": [
           {
               "id": 1,
               "infinite_supply": false,
               "max_supply": 21000000,
               "self_reported_circulating_supply": null,
               "tvl_ratio": null,
               "symbol": "BTC",
               "last_updated": "2023-11-16T17:17:00.000Z",
               "tags": [
                   "mineable",
                   "pow",
                   "sha-256",
                   "store-of-value",
                   "state-channel",
                   "coinbase-ventures-portfolio",
                   "three-arrows-capital-portfolio",
                   "polychain-capital-portfolio",
                   "binance-labs-portfolio",
                   "blockchain-capital-portfolio",
                   "boostvc-portfolio",
                   "cms-holdings-portfolio",
                   "dcg-portfolio",
                   "dragonfly-capital-portfolio",
                   "electric-capital-portfolio",
                   "fabric-ventures-portfolio",
                   "framework-ventures-portfolio",
                   "galaxy-digital-portfolio",
                   "huobi-capital-portfolio",
                   "alameda-research-portfolio",
                   "a16z-portfolio",
                   "1confirmation-portfolio",
                   "winklevoss-capital-portfolio",
                   "usv-portfolio",
                   "placeholder-ventures-portfolio",
                   "pantera-capital-portfolio",
                   "multicoin-capital-portfolio",
                   "paradigm-portfolio",
                   "bitcoin-ecosystem",
                   "ftx-bankruptcy-estate"
               ],
               "circulating_supply": 19544018,
               "platform": null,
               "cmc_rank": 1,
               "slug": "bitcoin",
               "quote": {
                   "USD": {
                       "percent_change_24h": 0.31582198,
                       "percent_change_90d": 41.75426625,
                       "fully_diluted_market_cap": 766807931352.61,
                       "last_updated": "2023-11-16T17:17:00.000Z",
                       "volume_change_24h": 28.373,
                       "tvl": null,
                       "percent_change_7d": 0.72123841,
                       "price": 36514.66339774353,
                       "percent_change_30d": 28.31539812,
                       "volume_24h": 30163359039.924732,
                       "percent_change_60d": 37.77258729,
                       "market_cap_dominance": 50.9529,
                       "percent_change_1h": -0.08636029,
                       "market_cap": 713643238709.4407
                   }
               },
               "self_reported_market_cap": null,
               "total_supply": 19544018,
               "num_market_pairs": 10552,
               "name": "Bitcoin",
               "date_added": "2010-07-13T00:00:00.000Z"
           },
           {
               "id": 1027,
               "infinite_supply": true,
               "max_supply": null,
               "self_reported_circulating_supply": null,
               "tvl_ratio": null,
               "symbol": "ETH",
               "last_updated": "2023-11-16T17:17:00.000Z",
               "tags": [
                   "pos",
                   "smart-contracts",
                   "ethereum-ecosystem",
                   "coinbase-ventures-portfolio",
                   "three-arrows-capital-portfolio",
                   "polychain-capital-portfolio",
                   "binance-labs-portfolio",
                   "blockchain-capital-portfolio",
                   "boostvc-portfolio",
                   "cms-holdings-portfolio",
                   "dcg-portfolio",
                   "dragonfly-capital-portfolio",
                   "electric-capital-portfolio",
                   "fabric-ventures-portfolio",
                   "framework-ventures-portfolio",
                   "hashkey-capital-portfolio",
                   "kenetic-capital-portfolio",
                   "huobi-capital-portfolio",
                   "alameda-research-portfolio",
                   "a16z-portfolio",
                   "1confirmation-portfolio",
                   "winklevoss-capital-portfolio",
                   "usv-portfolio",
                   "placeholder-ventures-portfolio",
                   "pantera-capital-portfolio",
                   "multicoin-capital-portfolio",
                   "paradigm-portfolio",
                   "injective-ecosystem",
                   "layer-1",
                   "ftx-bankruptcy-estate"
               ],
               "circulating_supply": 120254695.99930026,
               "platform": null,
               "cmc_rank": 2,
               "slug": "ethereum",
               "quote": {
                   "USD": {
                       "percent_change_24h": -0.02981789,
                       "percent_change_90d": 21.22404516,
                       "fully_diluted_market_cap": 241551997533.14,
                       "last_updated": "2023-11-16T17:17:00.000Z",
                       "volume_change_24h": 15.1581,
                       "tvl": null,
                       "percent_change_7d": -0.60203948,
                       "price": 2008.6699777158772,
                       "percent_change_30d": 27.83652818,
                       "volume_24h": 15083403971.385612,
                       "percent_change_60d": 23.72845442,
                       "market_cap_dominance": 17.2424,
                       "percent_change_1h": 0.16628974,
                       "market_cap": 241551997533.14404
                   }
               },
               "self_reported_market_cap": null,
               "total_supply": 120254695.99930026,
               "num_market_pairs": 7788,
               "name": "Ethereum",
               "date_added": "2015-08-07T00:00:00.000Z"
           },
           {
               "id": 825,
               "infinite_supply": true,
               "max_supply": null,
               "self_reported_circulating_supply": null,
               "tvl_ratio": null,
               "symbol": "USDT",
               "last_updated": "2023-11-16T17:16:00.000Z",
               "tags": [
                   "payments",
                   "stablecoin",
                   "asset-backed-stablecoin",
                   "avalanche-ecosystem",
                   "solana-ecosystem",
                   "arbitrum-ecosytem",
                   "moonriver-ecosystem",
                   "injective-ecosystem",
                   "bnb-chain",
                   "usd-stablecoin",
                   "optimism-ecosystem"
               ],
               "circulating_supply": 87434791408.83418,
               "platform": {
                   "id": 1027,
                   "symbol": "ETH",
                   "slug": "ethereum",
                   "name": "Ethereum",
                   "token_address": "0xdac17f958d2ee523a2206206994597c13d831ec7"
               },
               "cmc_rank": 3,
               "slug": "tether",
               "quote": {
                   "USD": {
                       "percent_change_24h": -0.01292213,
                       "percent_change_90d": 0.10747629,
                       "fully_diluted_market_cap": 90652300520.6,
                       "last_updated": "2023-11-16T17:16:00.000Z",
                       "volume_change_24h": 16.769,
                       "tvl": null,
                       "percent_change_7d": 0.03195884,
                       "price": 1.0003202428912428,
                       "percent_change_30d": -0.03112179,
                       "volume_24h": 55803627802.35311,
                       "percent_change_60d": -0.00375958,
                       "market_cap_dominance": 6.2447,
                       "percent_change_1h": -0.00077978,
                       "market_cap": 87462791779.23016
                   }
               },
               "self_reported_market_cap": null,
               "total_supply": 90623279059.69582,
               "num_market_pairs": 65845,
               "name": "Tether USDt",
               "date_added": "2015-02-25T00:00:00.000Z"
           },
           {
               "id": 1839,
               "infinite_supply": false,
               "max_supply": null,
               "self_reported_circulating_supply": null,
               "tvl_ratio": null,
               "symbol": "BNB",
               "last_updated": "2023-11-16T17:16:00.000Z",
               "tags": [
                   "marketplace",
                   "centralized-exchange",
                   "payments",
                   "smart-contracts",
                   "alameda-research-portfolio",
                   "multicoin-capital-portfolio",
                   "bnb-chain",
                   "layer-1",
                   "sec-security-token",
                   "alleged-sec-securities",
                   "celsius-bankruptcy-estate"
               ],
               "circulating_supply": 151701048.0539397,
               "platform": null,
               "cmc_rank": 4,
               "slug": "bnb",
               "quote": {
                   "USD": {
                       "percent_change_24h": -2.00185796,
                       "percent_change_90d": 14.59547081,
                       "fully_diluted_market_cap": 37515469475.42,
                       "last_updated": "2023-11-16T17:16:00.000Z",
                       "volume_change_24h": 1.8291,
                       "tvl": null,
                       "percent_change_7d": 0.14324539,
                       "price": 247.29868354028554,
                       "percent_change_30d": 16.62131443,
                       "volume_24h": 941075577.3045902,
                       "percent_change_60d": 14.64597356,
                       "market_cap_dominance": 2.6782,
                       "percent_change_1h": 0.23055435,
                       "market_cap": 37515469475.42088
                   }
               },
               "self_reported_market_cap": null,
               "total_supply": 151701048.0539397,
               "num_market_pairs": 1762,
               "name": "BNB",
               "date_added": "2017-07-25T00:00:00.000Z"
           },
           {
               "id": 52,
               "infinite_supply": false,
               "max_supply": 100000000000,
               "self_reported_circulating_supply": null,
               "tvl_ratio": null,
               "symbol": "XRP",
               "last_updated": "2023-11-16T17:17:00.000Z",
               "tags": [
                   "medium-of-exchange",
                   "enterprise-solutions",
                   "arrington-xrp-capital-portfolio",
                   "galaxy-digital-portfolio",
                   "a16z-portfolio",
                   "pantera-capital-portfolio",
                   "ftx-bankruptcy-estate"
               ],
               "circulating_supply": 53718306475,
               "platform": null,
               "cmc_rank": 5,
               "slug": "xrp",
               "quote": {
                   "USD": {
                       "percent_change_24h": -1.70947199,
                       "percent_change_90d": 26.03657645,
                       "fully_diluted_market_cap": 62487250079.17,
                       "last_updated": "2023-11-16T17:17:00.000Z",
                       "volume_change_24h": -5.8401,
                       "tvl": null,
                       "percent_change_7d": -4.91233777,
                       "price": 0.6248725007917405,
                       "percent_change_30d": 27.47330776,
                       "volume_24h": 1742423768.4670422,
                       "percent_change_60d": 25.38786306,
                       "market_cap_dominance": 2.3961,
                       "percent_change_1h": 0.13741679,
                       "market_cap": 33567092505.330395
                   }
               },
               "self_reported_market_cap": null,
               "total_supply": 99988221902,
               "num_market_pairs": 1142,
               "name": "XRP",
               "date_added": "2013-08-04T00:00:00.000Z"
           },
           {
               "id": 5426,
               "infinite_supply": true,
               "max_supply": null,
               "self_reported_circulating_supply": null,
               "tvl_ratio": null,
               "symbol": "SOL",
               "last_updated": "2023-11-16T17:17:00.000Z",
               "tags": [
                   "pos",
                   "platform",
                   "solana-ecosystem",
                   "cms-holdings-portfolio",
                   "kenetic-capital-portfolio",
                   "alameda-research-portfolio",
                   "multicoin-capital-portfolio",
                   "okex-blockdream-ventures-portfolio",
                   "layer-1",
                   "ftx-bankruptcy-estate",
                   "sec-security-token",
                   "alleged-sec-securities"
               ],
               "circulating_supply": 422640141.2287612,
               "platform": null,
               "cmc_rank": 6,
               "slug": "solana",
               "quote": {
                   "USD": {
                       "percent_change_24h": 1.48073364,
                       "percent_change_90d": 194.00539051,
                       "fully_diluted_market_cap": 34974104148.8,
                       "last_updated": "2023-11-16T17:17:00.000Z",
                       "volume_change_24h": 19.9197,
                       "tvl": null,
                       "percent_change_7d": 37.95153546,
                       "price": 62.160894966967476,
                       "percent_change_30d": 156.86051916,
                       "volume_24h": 4011015283.6368337,
                       "percent_change_60d": 228.54195838,
                       "market_cap_dominance": 1.8753,
                       "percent_change_1h": 1.21174903,
                       "market_cap": 26271689427.745323
                   }
               },
               "self_reported_market_cap": null,
               "total_supply": 562638362.3882593,
               "num_market_pairs": 546,
               "name": "Solana",
               "date_added": "2020-04-10T00:00:00.000Z"
           },
           {
               "id": 3408,
               "infinite_supply": false,
               "max_supply": null,
               "self_reported_circulating_supply": null,
               "tvl_ratio": null,
               "symbol": "USDC",
               "last_updated": "2023-11-16T17:17:00.000Z",
               "tags": [
                   "medium-of-exchange",
                   "stablecoin",
                   "asset-backed-stablecoin",
                   "coinbase-ventures-portfolio",
                   "hedera-hashgraph-ecosystem",
                   "fantom-ecosystem",
                   "arbitrum-ecosytem",
                   "moonriver-ecosystem",
                   "bnb-chain",
                   "usd-stablecoin",
                   "optimism-ecosystem"
               ],
               "circulating_supply": 24109450562.410492,
               "platform": {
                   "id": 1027,
                   "symbol": "ETH",
                   "slug": "ethereum",
                   "name": "Ethereum",
                   "token_address": "0xa0b86991c6218b36c1d19d4a2e9eb0ce3606eb48"
               },
               "cmc_rank": 7,
               "slug": "usd-coin",
               "quote": {
                   "USD": {
                       "percent_change_24h": -0.01300945,
                       "percent_change_90d": -0.07104565,
                       "fully_diluted_market_cap": 24109358152.47,
                       "last_updated": "2023-11-16T17:17:00.000Z",
                       "volume_change_24h": 16.5302,
                       "tvl": null,
                       "percent_change_7d": 0.01631208,
                       "price": 0.9999961670655647,
                       "percent_change_30d": 0.01802953,
                       "volume_24h": 7007012566.835433,
                       "percent_change_60d": -0.01012968,
                       "market_cap_dominance": 1.721,
                       "percent_change_1h": 0.00091757,
                       "market_cap": 24109358152.467216
                   }
               },
               "self_reported_market_cap": null,
               "total_supply": 24109450562.410492,
               "num_market_pairs": 14966,
               "name": "USDC",
               "date_added": "2018-10-08T00:00:00.000Z"
           },
           {
               "id": 2010,
               "infinite_supply": false,
               "max_supply": 45000000000,
               "self_reported_circulating_supply": null,
               "tvl_ratio": null,
               "symbol": "ADA",
               "last_updated": "2023-11-16T17:16:00.000Z",
               "tags": [
                   "dpos",
                   "pos",
                   "platform",
                   "research",
                   "smart-contracts",
                   "staking",
                   "cardano-ecosystem",
                   "cardano",
                   "layer-1",
                   "sec-security-token",
                   "alleged-sec-securities"
               ],
               "circulating_supply": 35278546657.354,
               "platform": null,
               "cmc_rank": 8,
               "slug": "cardano",
               "quote": {
                   "USD": {
                       "percent_change_24h": 3.56610387,
                       "percent_change_90d": 46.70951828,
                       "fully_diluted_market_cap": 17194725086.94,
                       "last_updated": "2023-11-16T17:16:00.000Z",
                       "volume_change_24h": 74.7872,
                       "tvl": null,
                       "percent_change_7d": 5.18660821,
                       "price": 0.38210500193209496,
                       "percent_change_30d": 54.24135712,
                       "volume_24h": 713358939.1673623,
                       "percent_change_60d": 53.81653083,
                       "market_cap_dominance": 0.9625,
                       "percent_change_1h": -0.01989719,
                       "market_cap": 13480109138.66975
                   }
               },
               "self_reported_market_cap": null,
               "total_supply": 36350273102.308,
               "num_market_pairs": 973,
               "name": "Cardano",
               "date_added": "2017-10-01T00:00:00.000Z"
           },
           {
               "id": 74,
               "infinite_supply": true,
               "max_supply": null,
               "self_reported_circulating_supply": null,
               "tvl_ratio": null,
               "symbol": "DOGE",
               "last_updated": "2023-11-16T17:17:00.000Z",
               "tags": [
                   "mineable",
                   "pow",
                   "scrypt",
                   "medium-of-exchange",
                   "memes",
                   "payments",
                   "doggone-doggerel",
                   "bnb-chain",
                   "ftx-bankruptcy-estate"
               ],
               "circulating_supply": 141855136383.7052,
               "platform": null,
               "cmc_rank": 9,
               "slug": "dogecoin",
               "quote": {
                   "USD": {
                       "percent_change_24h": 5.42418866,
                       "percent_change_90d": 24.94583675,
                       "fully_diluted_market_cap": 11063726502.48,
                       "last_updated": "2023-11-16T17:17:00.000Z",
                       "volume_change_24h": 128.9264,
                       "tvl": null,
                       "percent_change_7d": 8.76182783,
                       "price": 0.07799313288560787,
                       "percent_change_30d": 32.05010865,
                       "volume_24h": 1244032134.8725758,
                       "percent_change_60d": 26.32252329,
                       "market_cap_dominance": 0.7899,
                       "percent_change_1h": 1.05302212,
                       "market_cap": 11063726502.480349
                   }
               },
               "self_reported_market_cap": null,
               "total_supply": 141855136383.7052,
               "num_market_pairs": 825,
               "name": "Dogecoin",
               "date_added": "2013-12-15T00:00:00.000Z"
           },
           {
               "id": 1958,
               "infinite_supply": true,
               "max_supply": null,
               "self_reported_circulating_supply": 71659659264,
               "tvl_ratio": null,
               "symbol": "TRX",
               "last_updated": "2023-11-16T17:16:00.000Z",
               "tags": [
                   "media",
                   "payments",
                   "tron-ecosystem",
                   "dwf-labs-portfolio",
                   "sec-security-token",
                   "alleged-sec-securities"
               ],
               "circulating_supply": 88651313022.04135,
               "platform": null,
               "cmc_rank": 10,
               "slug": "tron",
               "quote": {
                   "USD": {
                       "percent_change_24h": -0.06757928,
                       "percent_change_90d": 41.82093114,
                       "fully_diluted_market_cap": 9148454921.63,
                       "last_updated": "2023-11-16T17:16:00.000Z",
                       "volume_change_24h": -2.3599,
                       "tvl": null,
                       "percent_change_7d": 4.80377746,
                       "price": 0.10319577655853543,
                       "percent_change_30d": 17.16294946,
                       "volume_24h": 294841015.76099575,
                       "percent_change_60d": 23.40366327,
                       "market_cap_dominance": 0.6532,
                       "percent_change_1h": 0.1541612,
                       "market_cap": 9148441090.243362
                   }
               },
               "self_reported_market_cap": 7394974185.668528,
               "total_supply": 88651447052.5727,
               "num_market_pairs": 869,
               "name": "TRON",
               "date_added": "2017-09-13T00:00:00.000Z"
           },
           {
               "id": 3890,
               "infinite_supply": false,
               "max_supply": 10000000000,
               "self_reported_circulating_supply": null,
               "tvl_ratio": null,
               "symbol": "MATIC",
               "last_updated": "2023-11-16T17:16:00.000Z",
               "tags": [
                   "pos",
                   "platform",
                   "enterprise-solutions",
                   "zero-knowledge-proofs",
                   "scaling",
                   "state-channel",
                   "coinbase-ventures-portfolio",
                   "layer-2",
                   "binance-launchpad",
                   "binance-labs-portfolio",
                   "polygon-ecosystem",
                   "moonriver-ecosystem",
                   "injective-ecosystem",
                   "ftx-bankruptcy-estate",
                   "sec-security-token",
                   "alleged-sec-securities",
                   "modular-blockchain"
               ],
               "circulating_supply": 9260359478.633806,
               "platform": null,
               "cmc_rank": 11,
               "slug": "polygon",
               "quote": {
                   "USD": {
                       "percent_change_24h": -2.31556457,
                       "percent_change_90d": 54.75218186,
                       "fully_diluted_market_cap": 8781012992.74,
                       "last_updated": "2023-11-16T17:16:00.000Z",
                       "volume_change_24h": 2.6919,
                       "tvl": null,
                       "percent_change_7d": 8.28652765,
                       "price": 0.8781012992743595,
                       "percent_change_30d": 68.02262945,
                       "volume_24h": 1070368145.4768314,
                       "percent_change_60d": 68.66291532,
                       "market_cap_dominance": 0.5805,
                       "percent_change_1h": -0.53351448,
                       "market_cap": 8131533689.935976
                   }
               },
               "self_reported_market_cap": null,
               "total_supply": 10000000000,
               "num_market_pairs": 1074,
               "name": "Polygon",
               "date_added": "2019-04-28T00:00:00.000Z"
           },
           {
               "id": 5805,
               "infinite_supply": false,
               "max_supply": 720000000,
               "self_reported_circulating_supply": null,
               "tvl_ratio": null,
               "symbol": "AVAX",
               "last_updated": "2023-11-16T17:16:00.000Z",
               "tags": [
                   "defi",
                   "smart-contracts",
                   "three-arrows-capital-portfolio",
                   "polychain-capital-portfolio",
                   "avalanche-ecosystem",
                   "cms-holdings-portfolio",
                   "dragonfly-capital-portfolio",
                   "moonriver-ecosystem",
                   "injective-ecosystem",
                   "real-world-assets",
                   "layer-1"
               ],
               "circulating_supply": 355492817.4893515,
               "platform": null,
               "cmc_rank": 12,
               "slug": "avalanche",
               "quote": {
                   "USD": {
                       "percent_change_24h": 12.72857603,
                       "percent_change_90d": 111.8595687,
                       "fully_diluted_market_cap": 16263384812.61,
                       "last_updated": "2023-11-16T17:16:00.000Z",
                       "volume_change_24h": 45.5595,
                       "tvl": null,
                       "percent_change_7d": 73.33364729,
                       "price": 22.588034461952148,
                       "percent_change_30d": 147.28783693,
                       "volume_24h": 1881907473.6049693,
                       "percent_change_60d": 146.15340438,
                       "market_cap_dominance": 0.5732,
                       "percent_change_1h": -0.65452907,
                       "market_cap": 8029884012.425938
                   }
               },
               "self_reported_market_cap": null,
               "total_supply": 432868997.4893515,
               "num_market_pairs": 557,
               "name": "Avalanche",
               "date_added": "2020-07-13T00:00:00.000Z"
           },
           {
               "id": 11419,
               "infinite_supply": true,
               "max_supply": null,
               "self_reported_circulating_supply": 3414166606,
               "tvl_ratio": null,
               "symbol": "TON",
               "last_updated": "2023-11-16T17:17:00.000Z",
               "tags": [
                   "pos",
                   "ftx-bankruptcy-estate",
                   "dwf-labs-portfolio",
                   "toncoin-ecosystem"
               ],
               "circulating_supply": 3431892087.62,
               "platform": null,
               "cmc_rank": 13,
               "slug": "toncoin",
               "quote": {
                   "USD": {
                       "percent_change_24h": 0.60026701,
                       "percent_change_90d": 79.89021306,
                       "fully_diluted_market_cap": 11765567823.4,
                       "last_updated": "2023-11-16T17:17:00.000Z",
                       "volume_change_24h": 8.8853,
                       "tvl": null,
                       "percent_change_7d": -5.88429486,
                       "price": 2.330942327490566,
                       "percent_change_30d": 15.36623696,
                       "volume_24h": 74468018.08606704,
                       "percent_change_60d": -0.31080729,
                       "market_cap_dominance": 0.571,
                       "percent_change_1h": 0.80005217,
                       "market_cap": 7999542530.413421
                   }
               },
               "self_reported_market_cap": 7958225455.030207,
               "total_supply": 5047558528,
               "num_market_pairs": 171,
               "name": "Toncoin",
               "date_added": "2021-08-26T13:40:22.000Z"
           },
           {
               "id": 1975,
               "infinite_supply": false,
               "max_supply": 1000000000,
               "self_reported_circulating_supply": null,
               "tvl_ratio": null,
               "symbol": "LINK",
               "last_updated": "2023-11-16T17:16:00.000Z",
               "tags": [
                   "platform",
                   "defi",
                   "oracles",
                   "smart-contracts",
                   "substrate",
                   "polkadot",
                   "polkadot-ecosystem",
                   "avalanche-ecosystem",
                   "solana-ecosystem",
                   "framework-ventures-portfolio",
                   "polygon-ecosystem",
                   "fantom-ecosystem",
                   "cardano-ecosystem",
                   "web3",
                   "near-protocol-ecosystem",
                   "arbitrum-ecosytem",
                   "cardano",
                   "injective-ecosystem",
                   "optimism-ecosystem",
                   "real-world-assets",
                   "celsius-bankruptcy-estate"
               ],
               "circulating_supply": 556849970.4527867,
               "platform": {
                   "id": 1027,
                   "symbol": "ETH",
                   "slug": "ethereum",
                   "name": "Ethereum",
                   "token_address": "0x514910771af9ca656af840dff83e8264ecf986ca"
               },
               "cmc_rank": 14,
               "slug": "chainlink",
               "quote": {
                   "USD": {
                       "percent_change_24h": -5.23741987,
                       "percent_change_90d": 130.29145683,
                       "fully_diluted_market_cap": 14070655511.59,
                       "last_updated": "2023-11-16T17:16:00.000Z",
                       "volume_change_24h": 13.6584,
                       "tvl": null,
                       "percent_change_7d": -4.28232991,
                       "price": 14.070655511585231,
                       "percent_change_30d": 90.56326012,
                       "volume_24h": 906745823.4796846,
                       "percent_change_60d": 129.13406471,
                       "market_cap_dominance": 0.5594,
                       "percent_change_1h": -0.78242715,
                       "market_cap": 7835244105.877576
                   }
               },
               "self_reported_market_cap": null,
               "total_supply": 1000000000,
               "num_market_pairs": 1434,
               "name": "Chainlink",
               "date_added": "2017-09-20T00:00:00.000Z"
           },
           {
               "id": 6636,
               "infinite_supply": true,
               "max_supply": null,
               "self_reported_circulating_supply": null,
               "tvl_ratio": null,
               "symbol": "DOT",
               "last_updated": "2023-11-16T17:16:00.000Z",
               "tags": [
                   "substrate",
                   "polkadot",
                   "binance-chain",
                   "polkadot-ecosystem",
                   "three-arrows-capital-portfolio",
                   "polychain-capital-portfolio",
                   "arrington-xrp-capital-portfolio",
                   "blockchain-capital-portfolio",
                   "boostvc-portfolio",
                   "cms-holdings-portfolio",
                   "coinfund-portfolio",
                   "fabric-ventures-portfolio",
                   "fenbushi-capital-portfolio",
                   "hashkey-capital-portfolio",
                   "kenetic-capital-portfolio",
                   "1confirmation-portfolio",
                   "placeholder-ventures-portfolio",
                   "pantera-capital-portfolio",
                   "exnetwork-capital-portfolio",
                   "web3",
                   "spartan-group",
                   "injective-ecosystem",
                   "bnb-chain",
                   "layer-1"
               ],
               "circulating_supply": 1276012261.607849,
               "platform": null,
               "cmc_rank": 15,
               "slug": "polkadot-new",
               "quote": {
                   "USD": {
                       "percent_change_24h": 1.25374035,
                       "percent_change_90d": 22.64041641,
                       "fully_diluted_market_cap": 7582700468.1,
                       "last_updated": "2023-11-16T17:16:00.000Z",
                       "volume_change_24h": 35.7477,
                       "tvl": null,
                       "percent_change_7d": 12.18979562,
                       "price": 5.501104097649853,
                       "percent_change_30d": 48.75665499,
                       "volume_24h": 377992098.2909667,
                       "percent_change_60d": 34.0616896,
                       "market_cap_dominance": 0.5011,
                       "percent_change_1h": 0.27665766,
                       "market_cap": 7019476280.982394
                   }
               },
               "self_reported_market_cap": null,
               "total_supply": 1378396106.218481,
               "num_market_pairs": 613,
               "name": "Polkadot",
               "date_added": "2020-08-19T00:00:00.000Z"
           },
           {
               "id": 3717,
               "infinite_supply": false,
               "max_supply": null,
               "self_reported_circulating_supply": null,
               "tvl_ratio": null,
               "symbol": "WBTC",
               "last_updated": "2023-11-16T17:17:00.000Z",
               "tags": [
                   "medium-of-exchange",
                   "defi",
                   "wrapped-tokens",
                   "fantom-ecosystem",
                   "arbitrum-ecosytem",
                   "moonriver-ecosystem",
                   "optimism-ecosystem",
                   "bitcoin-ecosystem",
                   "ftx-bankruptcy-estate"
               ],
               "circulating_supply": 163924.87097067,
               "platform": {
                   "id": 1027,
                   "symbol": "ETH",
                   "slug": "ethereum",
                   "name": "Ethereum",
                   "token_address": "0x2260fac5e5542a773aa44fbcfedf7c193bc2c599"
               },
               "cmc_rank": 16,
               "slug": "wrapped-bitcoin",
               "quote": {
                   "USD": {
                       "percent_change_24h": 0.52192388,
                       "percent_change_90d": 41.49756699,
                       "fully_diluted_market_cap": 5979684780.68,
                       "last_updated": "2023-11-16T17:17:00.000Z",
                       "volume_change_24h": 23.1543,
                       "tvl": null,
                       "percent_change_7d": 0.3085043,
                       "price": 36478.2033700596,
                       "percent_change_30d": 27.95309112,
                       "volume_24h": 249030748.14308798,
                       "percent_change_60d": 37.58359017,
                       "market_cap_dominance": 0.4269,
                       "percent_change_1h": 0.1189685,
                       "market_cap": 5979684780.678879
                   }
               },
               "self_reported_market_cap": null,
               "total_supply": 163924.87097067,
               "num_market_pairs": 1509,
               "name": "Wrapped Bitcoin",
               "date_added": "2019-01-30T00:00:00.000Z"
           },
           {
               "id": 4943,
               "infinite_supply": true,
               "max_supply": null,
               "self_reported_circulating_supply": null,
               "tvl_ratio": null,
               "symbol": "DAI",
               "last_updated": "2023-11-16T17:16:00.000Z",
               "tags": [
                   "defi",
                   "stablecoin",
                   "asset-backed-stablecoin",
                   "ethereum-ecosystem",
                   "avalanche-ecosystem",
                   "polygon-ecosystem",
                   "fantom-ecosystem",
                   "arbitrum-ecosytem",
                   "harmony-ecosystem",
                   "moonriver-ecosystem",
                   "bnb-chain",
                   "usd-stablecoin",
                   "optimism-ecosystem"
               ],
               "circulating_supply": 5347888595.7464075,
               "platform": {
                   "id": 1027,
                   "symbol": "ETH",
                   "slug": "ethereum",
                   "name": "Ethereum",
                   "token_address": "0x6b175474e89094c44da98b954eedeac495271d0f"
               },
               "cmc_rank": 17,
               "slug": "multi-collateral-dai",
               "quote": {
                   "USD": {
                       "percent_change_24h": -0.01489237,
                       "percent_change_90d": 0.16301214,
                       "fully_diluted_market_cap": 5345843002.04,
                       "last_updated": "2023-11-16T17:16:00.000Z",
                       "volume_change_24h": 15.0948,
                       "tvl": null,
                       "percent_change_7d": -0.00161701,
                       "price": 0.9996174950788271,
                       "percent_change_30d": -0.0129273,
                       "volume_24h": 218113873.8708777,
                       "percent_change_60d": -0.00620347,
                       "market_cap_dominance": 0.3817,
                       "percent_change_1h": 0.00222206,
                       "market_cap": 5345843002.04065
                   }
               },
               "self_reported_market_cap": null,
               "total_supply": 5347888595.7464075,
               "num_market_pairs": 2785,
               "name": "Dai",
               "date_added": "2019-11-22T00:00:00.000Z"
           },
           {
               "id": 2,
               "infinite_supply": false,
               "max_supply": 84000000,
               "self_reported_circulating_supply": null,
               "tvl_ratio": null,
               "symbol": "LTC",
               "last_updated": "2023-11-16T17:17:00.000Z",
               "tags": [
                   "mineable",
                   "pow",
                   "scrypt",
                   "medium-of-exchange"
               ],
               "circulating_supply": 73880189.22358888,
               "platform": null,
               "cmc_rank": 18,
               "slug": "litecoin",
               "quote": {
                   "USD": {
                       "percent_change_24h": -0.15544194,
                       "percent_change_90d": 12.34591452,
                       "fully_diluted_market_cap": 6037722540.65,
                       "last_updated": "2023-11-16T17:17:00.000Z",
                       "volume_change_24h": 7.8283,
                       "tvl": null,
                       "percent_change_7d": 0.95179133,
                       "price": 71.87764929349207,
                       "percent_change_30d": 15.54006481,
                       "volume_24h": 369726378.15415734,
                       "percent_change_60d": 12.47628147,
                       "market_cap_dominance": 0.3791,
                       "percent_change_1h": 0.08705397,
                       "market_cap": 5310334330.749954
                   }
               },
               "self_reported_market_cap": null,
               "total_supply": 84000000,
               "num_market_pairs": 1035,
               "name": "Litecoin",
               "date_added": "2013-04-28T00:00:00.000Z"
           },
           {
               "id": 5994,
               "infinite_supply": false,
               "max_supply": null,
               "self_reported_circulating_supply": null,
               "tvl_ratio": null,
               "symbol": "SHIB",
               "last_updated": "2023-11-16T17:16:00.000Z",
               "tags": [
                   "memes",
                   "ethereum-ecosystem",
                   "doggone-doggerel"
               ],
               "circulating_supply": 589346914631298.1,
               "platform": {
                   "id": 1027,
                   "symbol": "ETH",
                   "slug": "ethereum",
                   "name": "Ethereum",
                   "token_address": "0x95ad61b0a150d79219dcf64e1e6cc01f0b64c4ce"
               },
               "cmc_rank": 19,
               "slug": "shiba-inu",
               "quote": {
                   "USD": {
                       "percent_change_24h": 1.17505433,
                       "percent_change_90d": 4.5752673,
                       "fully_diluted_market_cap": 5139522738.01,
                       "last_updated": "2023-11-16T17:16:00.000Z",
                       "volume_change_24h": 52.6877,
                       "tvl": null,
                       "percent_change_7d": 6.11982765,
                       "price": 0.000008717127333169477,
                       "percent_change_30d": 25.79743235,
                       "volume_24h": 260471241.20884737,
                       "percent_change_60d": 20.66629232,
                       "market_cap_dominance": 0.3668,
                       "percent_change_1h": 0.15944394,
                       "market_cap": 5137412098.251587
                   }
               },
               "self_reported_market_cap": null,
               "total_supply": 589589040239379.6,
               "num_market_pairs": 688,
               "name": "Shiba Inu",
               "date_added": "2020-08-01T00:00:00.000Z"
           },
           {
               "id": 1831,
               "infinite_supply": false,
               "max_supply": 21000000,
               "self_reported_circulating_supply": null,
               "tvl_ratio": null,
               "symbol": "BCH",
               "last_updated": "2023-11-16T17:16:00.000Z",
               "tags": [
                   "mineable",
                   "pow",
                   "sha-256",
                   "marketplace",
                   "medium-of-exchange",
                   "store-of-value",
                   "enterprise-solutions",
                   "payments",
                   "bitcoin-ecosystem",
                   "layer-1"
               ],
               "circulating_supply": 19560481.25,
               "platform": null,
               "cmc_rank": 20,
               "slug": "bitcoin-cash",
               "quote": {
                   "USD": {
                       "percent_change_24h": 1.33655219,
                       "percent_change_90d": 28.40596506,
                       "fully_diluted_market_cap": 4964742663.71,
                       "last_updated": "2023-11-16T17:16:00.000Z",
                       "volume_change_24h": 40.301,
                       "tvl": null,
                       "percent_change_7d": 1.20230912,
                       "price": 236.41631731940987,
                       "percent_change_30d": 3.84889631,
                       "volume_24h": 211805755.57371986,
                       "percent_change_60d": 12.93612607,
                       "market_cap_dominance": 0.3302,
                       "percent_change_1h": 1.80334164,
                       "market_cap": 4624416942.120367
                   }
               },
               "self_reported_market_cap": null,
               "total_supply": 19560481.25,
               "num_market_pairs": 796,
               "name": "Bitcoin Cash",
               "date_added": "2017-07-23T00:00:00.000Z"
           }
       ]
   }
"""
