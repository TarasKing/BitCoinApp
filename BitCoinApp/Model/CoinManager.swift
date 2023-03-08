//
//  CoinManager.swift
//  BitCoinApp
//
//  Created by Taras on 06/03/2023.
//

import Foundation

protocol CoinManagerDelegate {
    func didUpdateCoin(_ coinManager: CoinManager, coin: CoinModel)
    func didFailWithError(error: Error)
}



struct CoinManager {
    
    let viewController = ViewController()
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "API_KEY"
    
    func getCoinPrice(for currency: String) -> String{
        return currency
    }
    
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]

    var delegate: CoinManagerDelegate?

    
    func fetchCoin(currencyName: String){
        let urlString = "\(baseURL)/\(viewController.currencyChoosen)?apikey=\(apiKey)"
        performRequest(with: urlString)
    }
    
    
   
    func performRequest(with urlString: String){
        
        if let url = URL(string: urlString) {
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url)
            { (data, response,error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let currency = self.parseJSON(coinData: safeData){
                        self.delegate?.didUpdateCoin(self, coin: currency )
                    }
                }
                 
            }
            
            task.resume()
        }
    }
    
    func parseJSON(coinData: Data) -> CoinModel? {
        let decoder = JSONDecoder()
        do{
           let decodedData = try decoder.decode(CoinData.self, from: coinData)
            let rate = decodedData.rate
            let currencyID = decodedData.currencyID
            let bitcoinID = decodedData.bitcoinID
            let Time = decodedData.Time

            
            let coinData = CoinModel(rate: rate, currencyID: currencyID, bitcoinID: bitcoinID, Time: Time)
            print(coinData.rate)
            return coinData

            
        }catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
    
}
