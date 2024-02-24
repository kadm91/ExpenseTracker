//
//  ContentView.swift
//  ExpenseTracker
//
//  Created by Kevin Martinez on 2/19/24.
//

import SwiftUI
import Charts


struct ContentView: View {
    
    @Environment (TransactionLIstViewModel.self) var vm
    
    
  private var demoData: [Double] = [8, 2, 4, 6, 12, 9, 2]
    
    
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    OverviewChart()
                    RecentTransactionList()
                }
                .padding()
                .frame(maxWidth: .infinity)
            }
            .onAppear {
                //vm.groupexpences()
            }
            .background(Color.background)
            .navigationTitle("Overview")
            //.navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem {
                    notificationIcon
                }
            }
        }
    }
}


//MARK: - ContentView Extensions

extension ContentView {
    
    //MARK: - Notification Icon
    
    var notificationIcon: some View {
        Image(systemName: "bell.badge")
            .symbolRenderingMode(.palette)
            .foregroundStyle(Color.icon, .primary)
    }
    
    //MARK: - Title
    
    var title: some View {
        Text("Overview")
            .font(.title2)
            .bold()
        
    }
}


//MARK: - Light Mode Preview

#Preview("Light Mode Preview"){
    ContentView()
        .environment(TransactionLIstViewModel())
    
}

//MARK: - Dark Mode Preview

#Preview ("Dark Mode Preview") {
    ContentView()
        .environment(TransactionLIstViewModel())
        .preferredColorScheme(.dark)
}
