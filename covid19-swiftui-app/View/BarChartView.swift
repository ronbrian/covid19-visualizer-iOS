//
//  BarChartView.swift
//  covid19-swiftui-app
//
//  Created by Ron Machoka on 28.08.20.
//  Copyright © 2020 Ron Machoka. All rights reserved.
//

import SwiftUI

struct BarChartView: View {
    
    var chartTitle: String
    var barColor: Color
    var barChartData: BarChartData
    var barHeight: CGFloat = 15
    
    var body: some View {
        ScrollView {
            VStack {
                Text(self.chartTitle).font(.custom("Product Sans Bold", size: 20))
                 
                VStack(alignment: .center, spacing: 20) {
                    
                    BarsView(barColor: barColor, barChartData: self.barChartData.barChartDataPoints, barHeight: barHeight)
                    //LegendView(barChartData: self.barChartData.barChartDataPoints, barHeight: self.barHeight)
                }.frame(height: (barHeight+15) * CGFloat(barChartData.barChartDataPoints.count), alignment: .center)
                    .padding()
            }
        }
    }
    
    struct BarChartView_Previews: PreviewProvider {
        static var previews: some View {
            BarChartView(chartTitle: "Covid World Leading", barColor: .blue, barChartData: BarChartData(barChartDataPoints: [BarChartDataPoint(valueName: "DE", valueNumber: 10, actualFigures: 23),
                                                                                                                             BarChartDataPoint(valueName: "USA", valueNumber: 50, actualFigures: 23)]))
        }
    }
}

struct BarsView: View {
    
    
    var barColor = Color.blue
    var barChartData: [BarChartDataPoint]
    
    var barHeight: CGFloat
    var maxWidth: CGFloat {
        barChartData.map { $0.valueNumber }.max() ?? 0
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading, spacing: 15){
                ForEach(self.barChartData, id: \.self) { dataPoint in
                    VStack(alignment: .leading) {
                        BarView(barColor: self.barColor, valueNumber: dataPoint.valueNumber, height: self.barHeight, maxWidth: self.maxWidth, containerWidth: geometry.size.width)
                        VStack(){
                            CountryDetail(countryName: dataPoint.valueName, totalConfirmedCases: dataPoint.actualFigures)
                            
                            
                        }
                    }

                }
                
            }
        }
    }
}

struct BarView: View {
    
    
    
    var barColor: Color
    var valueNumber: CGFloat = 0
    var height: CGFloat
    var maxWidth: CGFloat = 0
    var containerWidth: CGFloat = 0
    
    var body: some View {
        VStack{
            Capsule()
                .fill(self.barColor)
                .frame(width: CGFloat(self.valueNumber) / CGFloat(self.maxWidth) * (containerWidth), height: height)
        }
        
        
    }
    
}


struct BarChartData {
    let barChartDataPoints: [BarChartDataPoint]
}

struct BarChartDataPoint: Hashable {
    let valueName: String
    let valueNumber: CGFloat
    let actualFigures: Int
}



struct LegendView: View {
    
    var barChartData: [BarChartDataPoint]
    var barHeight: CGFloat
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            
            Text(" ")
            
            ForEach(self.barChartData, id: \.self) { dataPoint in
                VStack{
                    Text(dataPoint.valueName)
                        .font(.system(size: self.barHeight))
                        .fontWeight(.medium)
                        .frame(height: self.barHeight)
                        .lineLimit(1)
                    //                                VStack{
                    //                                    Text(String(dataPoint.actualFigures))                        .font(.system(size: self.barHeight))
                    //                                    .fontWeight(.medium)
                    //                                    .frame(height: self.barHeight)
                    //                                    .lineLimit(1)
                    //                                }
                }
                
            }
        }
    }
    
}
