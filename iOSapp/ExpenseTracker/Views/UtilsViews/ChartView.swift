//
//  ChartView.swift
//  ExpenseTracker
//
//  Created by Aleksandra Generowicz on 25/05/2022.
//

import SwiftUI

struct ChartView: View {

    var data: [Double]
    private var minY: Double
    private var maxY: Double
    private var lineColor: Color
    @State var percentage: CGFloat = 0.0
    
    init(data: [Double]) {
        self.data = data
        self.minY = 0.0
        self.maxY = data.max() ?? 0.0
        self.lineColor = Color("GraphLineColor")
    }
    
    var body: some View {
        VStack {
            GeometryReader { geometry in
                Path { path in
                    for index in 0..<data.count {
                        let xPosition = geometry.size.width / CGFloat(data.count) * CGFloat(index + 1)
                        let yAxisLength = maxY - minY
                        let yPosition = (1 - CGFloat((data[index] - minY) / yAxisLength)) * geometry.size.height
                        
                        if index == 0 {
                            path.move(to: CGPoint(x: 0, y: yPosition))
                        }
                        path.addLine(to: CGPoint(x: xPosition, y: yPosition))
                    }
                }
                .trim(from: 0, to: percentage)
                .stroke(lineColor, style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
                .shadow(color: lineColor, radius: 10, x: 0, y: 10)
                .shadow(color: lineColor.opacity(0.7), radius: 10, x: 0, y: 10)
                .shadow(color: lineColor.opacity(0.4), radius: 10, x: 0, y: 10)
                .shadow(color: lineColor.opacity(0.1), radius: 10, x: 0, y: 10)
            }
            .frame(height: 200)
            .background(chartBackground)
            .overlay(yAxisLabels, alignment: .leading)
            
            HStack {
                Text("1")
                Spacer()
                Text("\(data.count)")
            }
            .padding(10)
        }
        .font(.caption)
        .foregroundColor(Color.secondary)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                withAnimation(.linear(duration: 2.0)) {
                    percentage = 1.0
                }
            }
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
    
    private var yAxisLabels: some View {
        VStack {
            Text(String(format: "%.2f", maxY))
            Spacer()
            Text(String(format: "%.2f", (maxY - minY) / 2))
            Spacer()
            Text(String(format: "%.2f", minY))
        }
    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView(data: [1.2, 0.7, 0.4, 1.5, 3.5, 2.3, 8.9, 10.2, 4.5, 3.4, 9.0])
    }
}
