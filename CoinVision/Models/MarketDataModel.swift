//
//  MarketDataModel.swift
//  CoinVision
//
//  Created by Emre Tatlıcı on 3.12.2024.
//

import Foundation

/*
URL - https://api.coingecko.com/api/v3/global
 
 JSON DATA- {"data":{"active_cryptocurrencies":15825,"upcoming_icos":0,"ongoing_icos":49,"ended_icos":3376,"markets":1178,"total_market_cap":{"btc":38105716.094085656,"eth":1000122817.0121834,"ltc":27795712910.949604,"bch":6722578025.008514,"bnb":5553695837.268786,"eos":3204933632788.355,"xrp":1354426310979.9253,"xlm":6731536993522.737,"link":147094435777.04895,"dot":357495454617.4287,"yfi":400167512.24590534,"usd":3659152382947.8193,"aed":13439993519519.703,"ars":3.701215071420282e+15,"aud":5656204319836.854,"bdt":438711740414310.3,"bhd":1379258944314.0525,"bmd":3659152382947.8193,"brl":22170804288280.855,"cad":5139286840154.97,"chf":3250318946353.445,"clp":3581431986334009.5,"cny":26670098058353.49,"czk":88123425384970.52,"dkk":26029563433718.477,"eur":3489598238979.1694,"gbp":2893079558358.6304,"gel":10410288529486.547,"hkd":28479614776464.06,"huf":1446754406762338.5,"idr":5.835144862585901e+16,"ils":13370176892053.033,"inr":310039066619073.06,"jpy":549052155908938.6,"krw":5.134880529106106e+15,"kwd":1125127152165.9453,"lkr":1.067246800524505e+15,"mmk":7.676901699424537e+15,"mxn":74631065735698.61,"myr":16349092847010.875,"ngn":6.106722820377801e+15,"nok":40700678772481.09,"nzd":6226728381928.947,"php":214574532630556.44,"pkr":1020223556510034.2,"pln":14958442961328.69,"rub":389716626749649.06,"sar":13747801417973.258,"sek":40295350803869.31,"sgd":4926759610600.985,"thb":125763848904172.97,"try":127156090521142.0,"twd":119288364024946.36,"uah":153129690878315.38,"vef":366390928104.5654,"vnd":9.29544751483479e+16,"zar":66324332432359.016,"xdr":2794121441314.1914,"xag":118520238415.87053,"xau":1382610727.8968353,"bits":38105716094085.66,"sats":3810571609408565.5},"total_volume":{"btc":3908020.081494359,"eth":102569914.79162766,"ltc":2850653796.0666437,"bch":689449579.0678396,"bnb":569572155.656896,"eos":328689400977.75885,"xrp":138906331248.17227,"xlm":690368386859.7367,"link":15085610974.307634,"dot":36663775383.15593,"yfi":41040107.2100929,"usd":375272858237.3369,"aed":1378369702848.576,"ars":379586694797346.8,"aud":580085150804.6686,"bdt":44993099914282.14,"bhd":141453099546.83224,"bmd":375272858237.3369,"brl":2273778248060.026,"cad":527071479940.0553,"chf":333343997059.3377,"clp":367302062728376.06,"cny":2735213754548.655,"czk":9037702249295.521,"dkk":2669522240714.21,"eur":357883839805.1938,"gbp":296706483182.48456,"gel":1067651281685.2236,"hkd":2920792937858.4644,"huf":148375253220742.38,"idr":5.984368131308704e+15,"ils":1371209496713.4048,"inr":31796775460235.008,"jpy":56309317105654.3,"krw":526619580492167.94,"kwd":115390024269.39116,"lkr":109453970581797.27,"mmk":787322456581934.0,"mxn":7653962016572.728,"myr":1676719130604.4233,"ngn":626289120383710.8,"nok":4174152496716.7495,"nzd":638596569042.4613,"php":22006188794012.28,"pkr":104631392744608.06,"pln":1534097806649.8965,"rub":39968292412335.914,"sar":1409937655683.499,"sek":4132583146936.9146,"sgd":505275257060.7734,"thb":12898003171755.47,"try":13040787739403.357,"twd":12233894803264.309,"uah":15704570557023.654,"vef":37576071295.30457,"vnd":9.533161761022366e+15,"zar":6802045719266.677,"xdr":286557604004.3143,"xag":12155117900.136003,"xau":141796849.48497793,"bits":3908020081494.359,"sats":390802008149435.9},"market_cap_percentage":{"btc":51.93595614667289,"eth":12.041259792863515,"xrp":4.216531334944903,"usdt":3.676435887704492,"sol":2.9846249637452464,"bnb":2.6268772569582604,"doge":1.7064696550509735,"ada":1.2693231713044804,"usdc":1.0897342183891177,"steth":0.9830676494277756},"market_cap_change_percentage_24h_usd":0.026107389547124178,"updated_at":1733208713}}
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
        
        if let item = totalMarketCap.first(where: {$0.key == "usd"}) {
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
        if let item = marketCapPercentage.first(where: { $0.key == "btc"}) {
            return item.value.asPercentString()
        }
        return ""
    }
    
}