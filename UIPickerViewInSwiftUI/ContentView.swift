//
//  ContentView.swift
//  UIPickerViewInSwiftUI
//
//  Created by Tuan Nguyen on 30/06/2021.
//

import SwiftUI

final class SwapDateViewModel: ObservableObject {
    @Published var years: [String] = Array(1900...2099).map { "\($0)" }
    @Published var solarMonths: [String] = Array(1...12).map { "\($0)" }
    @Published var solarDays: [String] = Array(1...30).map { "\($0)" }
    
    @Published var solarSelectedDay: String = "1"
    @Published var solarSelectedMonth: String = "1"
    @Published var solarSelectedYear: String = "1900"
    
    func changeLunarToSolar() {
        solarMonths = Array(1...13).map { "\($0)" }
    }
}

struct ContentView: View {
    @ObservedObject var viewModel = SwapDateViewModel()
        
    var body: some View {
        GeometryReader { geometry in
            VStack {
                HStack(spacing: 0) {
                    ThreeColumnPickerView(firstElements: $viewModel.solarDays,
                                secondElements: $viewModel.solarMonths,
                                thirdElements: $viewModel.years,
                                firstSelected: $viewModel.solarSelectedDay,
                                secondSelected: $viewModel.solarSelectedMonth,
                                thirdSelected: $viewModel.solarSelectedYear, didSelectRow: {
                                    print("===>")
                                    viewModel.changeLunarToSolar()
                                })
                        .frame(width: geometry.size.width)
                        .clipped()
                }
//                Text("\(viewModel.solarSelectedDay)-\(viewModel.solarSelectedMonth)-\(viewModel.solarSelectedYear)")
//                Button("tap") {
//                    viewModel.solarSelectedMonth = "5"
//                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
