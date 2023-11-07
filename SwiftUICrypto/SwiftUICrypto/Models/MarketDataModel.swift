//
//  MarketDataModel.swift
//  SwiftUICrypto
//
//  Created by Juan Sebastian Bueno on 11/7/23.
//

import Foundation

// JSON data:
/*
 URL: https://api.coingecko/api/v3/global
 
 JSON Response: 
 {
   "data": {
     "active_cryptocurrencies": 10802,
     "upcoming_icos": 0,
     "ongoing_icos": 49,
     "ended_icos": 3376,
     "markets": 922,
     "total_market_cap": {
       "btc": 39469410.52505122,
       "eth": 729528673.1295505,
       "ltc": 18790467605.470528,
       "bch": 5601799784.099796,
       "bnb": 5526173404.34345,
       "eos": 1995656254880.9597,
       "xrp": 1992256896598.4565,
       "xlm": 10775168127642.484,
       "link": 106496710920.3454,
       "dot": 280012137944.9353,
       "yfi": 226237693.79504716,
       "usd": 1370642279258.6501,
       "aed": 5034300559603.06,
       "ars": 479756870769864.06,
       "aud": 2134657474709.3323,
       "bdt": 150992646795211.8,
       "bhd": 516833566809.1764,
       "bmd": 1370642279258.6501,
       "brl": 6681881111385.924,
       "cad": 1884161633036.58,
       "chf": 1234860972506.1707,
       "clp": 1210825389497089.8,
       "cny": 9984032490575.867,
       "czk": 31572662664186.246,
       "dkk": 9569590013954.125,
       "eur": 1283144588077.6152,
       "gbp": 1114628231769.6023,
       "hkd": 10717353522824.826,
       "huf": 485797967021198.25,
       "idr": 21463062210543084,
       "ils": 5292226653071.664,
       "inr": 114139428496961.47,
       "jpy": 206249224489915.5,
       "krw": 1794834338638435.5,
       "kwd": 423169356013.75745,
       "lkr": 448461738495665.7,
       "mmk": 2876026381130328.5,
       "mxn": 24086492775258.207,
       "myr": 6402955407556.787,
       "ngn": 1095266538932795.8,
       "nok": 15305540174659.34,
       "nzd": 2316030455596.79,
       "php": 76831350222559.16,
       "pkr": 387763148070639.3,
       "pln": 5722827631523.555,
       "rub": 126381429665542.62,
       "sar": 5141665710621.94,
       "sek": 14980297726929.484,
       "sgd": 1858134506795.7373,
       "thb": 48800804134603.86,
       "try": 39059057338448.1,
       "twd": 44146333222144.46,
       "uah": 49342327080789.484,
       "vef": 137242411422.16847,
       "vnd": 33369270530324890,
       "zar": 25194186927737.02,
       "xdr": 1041731992789.5112,
       "xag": 60820126646.56968,
       "xau": 699233158.7637987,
       "bits": 39469410525051.22,
       "sats": 3946941052505122
     },
     "total_volume": {
       "btc": 1716123.3750601192,
       "eth": 31719784.817652527,
       "ltc": 817006391.9650108,
       "bch": 243565318.66111302,
       "bnb": 240277096.30500093,
       "eos": 86770800526.96594,
       "xrp": 86622996996.80922,
       "xlm": 468502509869.34515,
       "link": 4630459197.2922,
       "dot": 12174880973.27591,
       "yfi": 9836777.126300147,
       "usd": 59595297294.55965,
       "aed": 218890547198.05286,
       "ars": 20859748583052.65,
       "aud": 92814550340.70937,
       "bdt": 6565135054727.882,
       "bhd": 22471837132.04879,
       "bmd": 59595297294.55965,
       "brl": 290527074310.97845,
       "cad": 81923032997.75024,
       "chf": 53691548763.37136,
       "clp": 52646485630013.92,
       "cny": 434104064553.0317,
       "czk": 1372774097462.3438,
       "dkk": 416084174914.7774,
       "eur": 55790912301.16682,
       "gbp": 48463849284.69261,
       "hkd": 465988740511.5669,
       "huf": 21122414438711.24,
       "idr": 933210358855104.9,
       "ils": 230105130647.64542,
       "inr": 4962763280574.342,
       "jpy": 8967681820596.602,
       "krw": 78039097162168.52,
       "kwd": 18399332896.12777,
       "lkr": 19499041460577.06,
       "mmk": 125049146523601.78,
       "mxn": 1047276681484.8104,
       "myr": 278399431311.5355,
       "ngn": 47622006115109.71,
       "nok": 665482329536.781,
       "nzd": 100700617245.80649,
       "php": 3340614270655.95,
       "pkr": 16859876890448.156,
       "pln": 248827589245.70395,
       "rub": 5495043445984.493,
       "sar": 223558766025.72998,
       "sek": 651340842251.1599,
       "sgd": 80791377897.42383,
       "thb": 2121850810109.4958,
       "try": 1698281287068.6338,
       "twd": 1919475192507.1194,
       "uah": 2145396137331.7185,
       "vef": 5967277118.104251,
       "vnd": 1450890307303899.2,
       "zar": 1095439038160.489,
       "xdr": 45294332993.37879,
       "xag": 2644448944.735275,
       "xau": 30402540.91481953,
       "bits": 1716123375060.1191,
       "sats": 171612337506011.9
     },
     "market_cap_percentage": {
       "btc": 49.49573546664639,
       "eth": 16.481953764829598,
       "usdt": 6.270157891868456,
       "bnb": 2.7841364816898464,
       "xrp": 2.687357336351023,
       "usdc": 1.786298552172054,
       "sol": 1.2621118521339854,
       "steth": 1.2259175086100635,
       "ada": 0.8834314156664376,
       "doge": 0.7631397464293886
     },
     "market_cap_change_percentage_24h_usd": -0.7342971593666893,
     "updated_at": 1699360894
   }
 }
 
 
 */

struct GlobalData: Codable {
    let data: MarketDataModel?
}

struct MarketDataModel: Codable {
    let totalMarketCap, totalVolume, marketCapPercentage: [String: Double]
    let marketCapChangePercentage24HUsd: Double
    
    enum CodingKeys: String, CodingKey {
        case totalMarketCap = "total_market_cap"
        case totalVolume = "total_volume"
        case marketCapPercentage = "market_cap_percentage"
        case marketCapChangePercentage24HUsd = "market_cap_change_percentage_24h_usd"
    }
    
    var marketCap: String {
        if let item = totalMarketCap.first(where: { $0.key == "usd"}) {
            return "$" + item.value.formattedWithAbbreviations()
        }
        return ""
    }
    
    var volume: String {
        if let item = totalVolume.first(where: {$0.key == "usd"}) {
            return "$" + item.value.formattedWithAbbreviations()
        }
        return ""
    }
    
    var btcDominance: String {
        if let item = totalVolume.first(where: {$0.key == "btc"}) {
            return item.value.asPercentString()
        }
        return ""
    }
}
