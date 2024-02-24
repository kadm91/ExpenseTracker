//
//  OverviewChart.swift
//  ExpenseTracker
//
//  Created by Kevin Martinez on 2/23/24.
//

import SwiftUI
import Charts

struct OverviewChart: View {
    
    
    @Environment (TransactionLIstViewModel.self) var vm
    
    private var linearGradient = LinearGradient(gradient: Gradient(colors: [Color.icon.opacity(0.4), Color.icon.opacity(0)]), startPoint: .top, endPoint: .bottom)
    
    @State private var pointSelection: String?
    
    
    var body: some View {
        
        
        VStack (alignment: .leading) {
            
            total
            expensesChard
        
        }
        .padding()
        .background(Color.systemBackground)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(color: Color.primary.opacity(0.2), radius: 10, x:0, y: 0)
        
    }

}






//MARK: - OverviewChart Extension

extension OverviewChart {
    
    
    @ViewBuilder var total: some View {
        
        let data = vm.AccumulateTransactions()
        let keys = data.keys
        let lastKey = keys.last ?? "No Key available"
        let total = data[lastKey] ?? 0.00
        
        Text(total, format: .currency(code: "USD"))
                .font(.title)
                .bold()
                .opacity(pointSelection == nil ? 1 : 0)
    }
    
    
    
    var expensesChard: some View {
        
        Chart {
            ForEach (Array(vm.AccumulateTransactions()), id: \.key) { date, dailyExpense in
                LineMark (x: .value("Date", date), y: .value("amount", dailyExpense))
                
            }
            
            .interpolationMethod(.cardinal)
            
            ForEach (Array(vm.AccumulateTransactions()), id: \.key) { date, dailyExpense in
                AreaMark (x: .value("Date", date), y: .value("amount", dailyExpense))
            }
            
            .interpolationMethod(.cardinal)
            .foregroundStyle(linearGradient)
            
            
            if let pointSelection {
                RuleMark(x: .value("Day", pointSelection))
                    .foregroundStyle(.accent.opacity(0.35))
                    .zIndex(-10)
                    .offset(yStart: 25)
                    .annotation (
                        position: .top,
                        spacing: 0,
                        overflowResolution: .init(x: .fit, y: .disabled)) {
                            if let transactionDaysum = vm.findTransaction(pointSelection) {
                                chartPopOverView(amount: transactionDaysum, day: pointSelection)
                                    .offset(CGSize(width: 10.0, height: 10.0))
                            }
                                
                        }
            }
        }
        .chartXSelection(value: $pointSelection)
        .frame(height: 100)
        .chartXAxis(.hidden)
        .chartYAxis(.hidden)
        .chartYScale(domain: 850.00...1000.00)
        .aspectRatio(1, contentMode: .fit)
        
    }
    
    
    //MARK: - Chart Popover View
    
    @ViewBuilder func chartPopOverView (amount: Double, day: String ) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            
            let modifiedDay = day.dropLast(10)
            
           
            
                Text(amount, format: .currency(code: "USD"))
                    .font(.title2)
                    .fontWeight(.semibold)
            
            Text(modifiedDay)
                .font(.title3)
                
            
           
        }
        .padding()
        .background(Color.background)
        .opacity(1)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
    
}

//MARK: - Light Mode Preview
#Preview ("Light Mode"){
    OverviewChart()
        .padding()
        .environment(TransactionLIstViewModel())
}

//MARK: - Dark Mode Preivew
#Preview ("Dark Mode"){
    OverviewChart()
        .preferredColorScheme(.dark)
        .padding()
        .environment(TransactionLIstViewModel())
}

