//
//  ContentView.swift
//  TaskApp
//
//  Created by Prabhat Kasera on 16/11/23.
//

import SwiftUI

struct ContentView: View {
    @State private var searchText : String = ""
    @ObservedObject var coinVM : CoinViewModel
    @State var data : [CryptoData]?
    init() {
        self.coinVM = CoinViewModel()
        self.coinVM.fetchCoinData()
        UITabBar.appearance().barTintColor = UIColor.black
    }
    
    var body: some View {
            VStack {
                HStack(spacing: 16) {
                    CustomText(text:"Exchanges".uppercased(), isBold : true, size: 20)
                    Spacer()
                   
                    CustomBtn(imageName: "bell", action: {
                        print("bell")
                    })
                    .badge(1)
                    CustomBtn(imageName: "settings", action: {
                        print("settings")
                    })
                }
                HStack(spacing: 16) {
                    SearchBar(searchText: searchText, coinVM: self.coinVM)
                    FilterBtn(imageName: "bell") {
                        self.coinVM.showAlert = true
                    }.actionSheet(isPresented: $coinVM.showAlert) {
                        ActionSheet(
                            title: Text("Filter by:"),
                            buttons: [
                                .default(Text(FilterOption.byPrice.rawValue)) {
                                    self.coinVM.selectedOption = .byPrice
                                    self.coinVM.updateDataSet()
                                },
                                .default(Text(FilterOption.byVolume.rawValue)) {
                                    self.coinVM.selectedOption = .byVolume
                                    self.coinVM.updateDataSet()
                                },
                                .cancel()
                            ]
                        )
                    }
                }.padding(.top, 16)
                
                
                HStack(spacing: 20) {
                    CustomText(text:"Cryptocurrency", isBold : true, size: 20)
                    Text("")
                        .font(
                            Font.custom("Inter", size: 20)
                            .weight(.semibold)
                        )
                    
                    CustomText(color: .gray, text:"NFT", isBold : true, size: 20)
                    Spacer()
                }.padding(.top, 20)
                
                BitCoinCard(data: coinVM.coinData?.data?.first)
                    .frame(height: 131)
                    .padding(.top, 16)
                
                HStack {
                    CustomText(text:"Top Cryptocurrencies")
                    Spacer()
                    Button("View All") {
                        print("View All")
                    }
                    .foregroundColor(.gray)
                }.padding(.top, 16)
                
                if let coinData = self.coinVM.coinData?.data, coinData.count > 1 {
                    List(coinData[1...coinData.count - 1], id: \.id) { data in
                        CardContent(data: data)
                            .padding(.leading, -20)
                            .padding(.trailing, -20)
                    }
                    .listStyle(PlainListStyle())
                } else {
                    Spacer()
                    ProgressView()
                    Spacer()
                }
                CustomTabBar()
                    .frame(height: 71)

            }
            .padding(26)
        

    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
