//
//  TransactionList.swift
//  ExpenseTracker
//
//  Created by Kevin Martinez on 2/23/24.
//

import SwiftUI

struct TransactionList: View {
    
    @Environment (TransactionLIstViewModel.self) var vm
    
    var body: some View {
        VStack {
            List {
                transactionGroups
            }
            .listStyle(.plain)
        }
        .navigationTitle("Transactions")
        .navigationBarTitleDisplayMode(.inline)
    }
}


//MARK: - Transaction List extension

private extension TransactionList {
    
    var navTitle: String  { "Transactions" }
    
    var transactionGroups: some View {
        ForEach(Array(vm.groupTransactionByMonth()), id: \.key) { month, transations in
            Section {
                ForEach (transations) { TransactionRow(transaction: $0) }
            } header: {
                Text(month)
            }
            .listSectionSeparator(.hidden)
        }
    }
    
}
//MARK: - Preview

#Preview ("Light Mode") {
    NavigationStack {
        TransactionList()
            .environment(TransactionLIstViewModel())
    }
}

#Preview ("Dark Mode") {
    NavigationStack {
        TransactionList()
            .environment(TransactionLIstViewModel())
        .preferredColorScheme(.dark)
    }
}
