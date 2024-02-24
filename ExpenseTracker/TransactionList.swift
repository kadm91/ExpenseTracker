//
//  TransactionList.swift
//  ExpenseTracker
//
//  Created by Kevin Martinez on 2/21/24.
//

import SwiftUI

struct TransactionList: View {
    
    @Environment (TransactionLIstViewModel.self) var vm
    
    
    var body: some View {
        VStack {
       
          transactionGroupList
            
        }
        .navigationTitle(navTitle)
        .navigationBarTitleDisplayMode(.inline)
    }
}

//MARK: - Transaction List Extention

extension TransactionList {
    
    var navTitle: String { "Transactions" }
    
    var transactionGroupList: some View {
        List {
            //MARK: - transaction Group
            ForEach(Array(vm.groupTransactionByMount()), id:\.key) { month , transactions in
                Section {
                    ForEach(transactions) { transaction in
                            TransactionRow(transaction: transaction)
                    }
                } header: {
                    //MARK: - Transaction Month
                    Text(month)
                }
                .listSectionSeparator(.hidden)
            }
        }
        .listStyle(.plain)
    }
    
    
}

//MARK: - Light Mode Preview
#Preview("Light Mode") {
    NavigationStack {
        TransactionList()
            .environment(TransactionLIstViewModel())
    }
}

//MARK: - Dark Mode Preview
#Preview ("Dark Mode") {
    
    NavigationStack {
        TransactionList()
            .environment(TransactionLIstViewModel())
        .preferredColorScheme(.dark)
    }
}
