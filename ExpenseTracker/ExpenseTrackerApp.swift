//
//  ExpenseTrackerApp.swift
//  ExpenseTracker
//
//  Created by Kevin Martinez on 2/19/24.
//

import SwiftUI

@main
struct ExpenseTrackerApp: App {
    
   @State var transactionListVM = TransactionLIstViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(transactionListVM)
        }
    }
}
