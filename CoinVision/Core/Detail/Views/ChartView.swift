//
//  ChartView.swift
//  CoinVision
//
//  Created by Emre Tatlıcı on 4.12.2024.
//

import SwiftUI

struct ChartView: View {
    
    private let data: [Double]
    private let maxY: Double
    private let minY: Double
    private let lineColor: Color
    private let startingDate: Date
    private let endingDate: Date
    @State var percentage: CGFloat = 0
    
    @State private var selectedPrice: Double? = nil
    @State private var dragLocation: CGFloat = 0
    
    init(coin: CoinModel) {
        let sparkline = coin.sparklineIn7D?.price ?? []
        guard !sparkline.isEmpty else {
            data = []
            maxY = 0
            minY = 0
            lineColor = Color.theme.secondaryText
            startingDate = Date()
            endingDate = Date()
            return
        }
        
        data = sparkline
        maxY = data.max() ?? 0
        minY = data.min() ?? 0

        let priceChange = (data.last ?? 0) - (data.first ?? 0)
        lineColor = priceChange > 0 ? Color.theme.green : Color.theme.red
        
        endingDate = Date(coinGeckoString: coin.lastUpdated ?? "") ?? Date()
        startingDate = endingDate.addingTimeInterval(-7 * 24 * 60 * 60)
    }
    
    var body: some View {
        VStack {
            ZStack {
                chartView
                    .frame(height: 200)
                    .background(chartBackground)
                    .overlay(chartYAxis.padding(.horizontal, 4), alignment: .leading)
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                let width = UIScreen.main.bounds.width - 32 // Account for padding
                                let index = Int((value.location.x / width) * CGFloat(data.count))
                                guard index >= 0 && index < data.count else { return }
                                
                                dragLocation = value.location.x
                                selectedPrice = data[index]
                            }
                            .onEnded { _ in
                                selectedPrice = nil
                            }
                    )
                if let selectedPrice = selectedPrice {
                    Text("\(selectedPrice.formattedWithAbbreviations())")
                        .font(.caption)
                        .padding(6)
                        .background(Color.theme.background)
                        .cornerRadius(5)
                        .foregroundColor(.white)
                        .offset(x: dragLocation - UIScreen.main.bounds.width / 2, y: -120)
                        .transition(.opacity)
                        .animation(.easeInOut, value: selectedPrice)
                }
            }
            chartDateLabels
                .padding(.horizontal, 4)
        }
        .font(.caption)
        .foregroundColor(Color.theme.secondaryText)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                withAnimation(.linear(duration: 2.0)) {
                    percentage = 1.0
                }
            }
        }
    }
}

#Preview {
    ChartView(coin: DeveloperPreview.instance.coin)
}

extension ChartView {
    
    private var chartView: some View {
        GeometryReader { geometry in
            Path { path in
                for index in data.indices {
                    let xPosition = geometry.size.width / CGFloat(data.count) * CGFloat(index + 1)
                    let yAxis = maxY - minY
                    let yPosition = (1 - CGFloat((data[index] - minY) / yAxis)) * geometry.size.height
                    
                    if index == 0 {
                        path.move(to: CGPoint(x: xPosition, y: yPosition))
                    }
                    path.addLine(to: CGPoint(x: xPosition, y: yPosition))
                }
            }
            .trim(from: 0, to: percentage)
            .stroke(lineColor, style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
            .shadow(color: lineColor, radius: 10, x: 0.0, y: 10)
            .shadow(color: lineColor.opacity(0.5), radius: 10, x: 0.0, y: 20)
            .shadow(color: lineColor.opacity(0.2), radius: 10, x: 0.0, y: 30)
            .shadow(color: lineColor.opacity(0.1), radius: 10, x: 0.0, y: 40)
        }
    }
    
    private var chartBackground: some View {
        VStack {
            Divider()
            Spacer()
            Divider()
            Spacer()
            Divider()
        }
    }
    
    private var chartYAxis: some View {
        VStack {
            Text(maxY.formattedWithAbbreviations())
            Spacer()
            Text(((maxY + minY) / 2).formattedWithAbbreviations())
            Spacer()
            Text(minY.formattedWithAbbreviations())
        }
    }
    
    private var chartDateLabels: some View {
        HStack {
            Text(startingDate.asShortDateString())
            Spacer()
            Text(endingDate.asShortDateString())
        }
    }
}
