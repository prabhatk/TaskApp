//
//  ComponentViews.swift
//  TaskApp
//
//  Created by Prabhat Kasera on 17/11/23.
//

import SwiftUI

struct CustomTabBar : View {
    @State var selectedIndex = 1
    var body: some View {
        RoundedRectangle(cornerRadius: 25)
            .padding(.leading, -10)
            .padding(.trailing, -10)
            .overlay {
                HStack {
                    CustomTabItem(tag: 0, image: Image("shop"), text: "€-$hop")
                    CustomTabItem(tag: 1, image: Image("exchange"), text: "Exchange")
                    CustomTabItem(tag: 2, image: Image("earth"), text: "")
                    CustomTabItem(tag: 3, image: Image("launchpad"), text: "Launchpads")
                    CustomTabItem(tag: 4, image: Image("wallet"), text: "Wallet")
                }
                .background(.black)
            }
        
    }
}
struct CustomTabItem : View {
    var isSelected = false
    var tag = 0
    var image : Image? = nil
    var text : String = ""
    var body: some View {
        VStack{
            image
            Text(text)
                .font(.system(size: 12))
        }.foregroundColor(isSelected ? .white : .gray)
            .frame(width: 54, height: 54)
    }
}
struct CustomBtn: View {
    var imageName : String
    var action: () -> Void
    init(imageName: String, action: @escaping () -> Void) {
        self.imageName = imageName
        self.action = action
    }
    var body: some View {
        Button(action: action) {
            Image(imageName)
        }
    }
}

struct FilterBtn: View {
    var imageName : String
    var action: () -> Void
    init(imageName: String, action: @escaping () -> Void) {
        self.imageName = imageName
        self.action = action
    }
    var body: some View {
        HStack{
            Button(action: action) {
                Image("filteroption")
                Text("Filter")
            }.foregroundColor(.gray)

        }
        .frame(height: 40)
        .padding(.leading,13)
        .padding(.trailing,13)
        .overlay {
            RoundedRectangle(cornerRadius: 20)
            .stroke(.gray, lineWidth: 1)
        }
        
    }
}

struct SearchBar: View {
    @State var searchText : String
    @ObservedObject var coinVM : CoinViewModel
    var body: some View {
        VStack {
                    HStack {
                        Image("search")
                            .foregroundColor(.gray)
                        TextField("Search Cryptocurrency", text: $searchText)
                            .onChange(of: searchText) { newValue in
                                print(newValue)
                                coinVM.updateDataForSearch(searchString: newValue)
                            }
                        Spacer()
                    }
                    .padding()

        }.frame(height: 40)
        .background(Color(.systemGray6))
        .cornerRadius(20)
    }
}
struct CustomText : View {
    var color : Color = .black
    var text: String = ""
    var isBold : Bool = false
    var size : CGFloat = 20.0
    var body : some View {
        Text(text)
            .font(.system(size: size))
            .fontWeight(isBold ? .bold : .regular)
            .foregroundColor(color)
    }
}

struct BitCoinCard : View {
    var data : CryptoData?
    var body: some View {
        if let isNegative = data?.quote?.usd?.percentChange24H {
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(isNegative < 0 ? Color(red: 0.81, green: 0, blue: 0.03).opacity(0.1) : Color(red: 0, green: 0.81, blue: 0.03).opacity(0.1))
                .overlay(content: {
                    VStack {
                        Spacer()
                        Image("possitivemask")
                            .resizable(resizingMode: .stretch)
                            .frame(height: 52)
                            .foregroundColor(isNegative < 0 ? .red : .green)
                    }
                })
                .overlay(
                    CardContent(data: data, showNegativePossitiveIndicator: false)
                        .padding(EdgeInsets(top: -30, leading: 26, bottom: 0, trailing: 26))
                )
        } else {
            VStack {
                ProgressView()
            }
        }
    }
}

struct CardContent: View {
    var data : CryptoData?
    var showNegativePossitiveIndicator = true
    var body: some View {
        HStack {
            // AsyncImage with URL
            if let imageurl = WebService.getImageURLForCryptoData(data: data!) {
                AsyncImage(url: imageurl) { image in
                    image.resizable()
                        .scaledToFit()
                } placeholder: {
                    // Placeholder while loading
                    ProgressView()
                }
                .frame(width: 46.0, height: 46.0)
            }
            VStack(alignment: .leading) {
                HStack{
                    CustomText(text: data?.symbol ?? "--", isBold: true, size: 18.0)
                    if (showNegativePossitiveIndicator) {
                        Image((data?.quote?.usd?.percentChange24H ?? 0) > 0 ? "positive" : "negative")
                    }
                }
                CustomText(text: data?.slug ?? "--", size: 13.0)
            }
            Spacer()
            VStack(alignment: .trailing) {
                CustomText(text: String(format: "$ %.02f USD", data?.quote?.usd?.price ?? 0.0), isBold: true, size: 18.0)
                let isNegative = data?.quote?.usd?.percentChange24H ?? 0.0 < 0.0
                let percentage = (isNegative ? "" :
                "+") + String(format: "%.01f", data?.quote?.usd?.percentChange24H ?? 0) + "%"
                CustomText(color: isNegative ? .red :.green, text: percentage,isBold: true, size: 13.0)
            }
        }
    }
}
