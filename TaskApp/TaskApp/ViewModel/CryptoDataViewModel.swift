//
//  CryptoViewModel.swift
//  TaskApp
//
//  Created by Prabhat Kasera on 16/11/23.
//

import Foundation

enum FilterOption : String {
    case byPrice = "Price"
    case byVolume = "Volume"
}

class CoinViewModel : ObservableObject {
    private var webservice : WebService
    private var savedData : CryptoResponse?
    @Published var coinData : CryptoResponse?
    @Published var showAlert = false
    @Published var selectedOption: FilterOption = .byVolume
    @Published var searchText: String?
    
    init() {
        self.webservice = WebService()
    }
    
    func fetchCoinData() {
        self.webservice.getLatestPriceUpdate { result in
            switch result {
            case .success(let data):
                self.savedData = data
                DispatchQueue.main.async {
                    self.updateDataSet()
                }
            case .failure(let error):
                print("error \(error.localizedDescription)")
                DispatchQueue.main.async {
                    self.coinData = nil
                }
            }
        }
    }
    
    func updateDataSet() {
        if (self.selectedOption == .byPrice) {
            self.coinData?.data = self.savedData?.data?.sorted{$0.quote?.usd?.price ?? 0.0 > $1.quote?.usd?.price ?? 0.0}
        } else {
            self.coinData = self.savedData
        }
    }
    func updateDataForSearch(searchString : String?) {
        if let search = searchString, search.count >= 2 {
            if (self.selectedOption == .byPrice) {
                self.coinData?.data = self.savedData?.data?.filter{return ($0.slug?.contains(search))! || ($0.symbol?.contains(search))!}
            } else {
                self.coinData = self.savedData
                self.coinData?.data = self.savedData?.data?.filter{return ($0.slug?.contains(search))! || ($0.symbol?.contains(search))!}
            }
        } else {
            self.selectedOption = .byVolume
            self.coinData = self.savedData
        }
    }
}
