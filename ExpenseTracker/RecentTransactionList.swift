//
//  RecentTransactionList.swift
//  ExpenseTracker
//
//  Created by Kevin Martinez on 2/20/24.
//

import SwiftUI

struct RecentTransactionList: View {
    
    @Environment (TransactionLIstViewModel.self) var vm
    
    var body: some View {
        VStack {
            HStack {
                title
                
                Spacer()
                
                NavigationLink {
                    
                } label: {
                  navigationLinkLabel
                }
            }
            .padding(.vertical)
            
            recentTransactrionList
            
            
        }
        .padding()
        .background(Color.systemBackground)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(color: Color.primary.opacity(0.2), radius: 10, x:0, y: 5)
    }
}

//MARK: - RecentTransactionList Extension

private extension RecentTransactionList {
    
    //MARK: - Title
    var title: some View {
        Text("Recent Transactions")
            .bold()
    }
    
    //MARK: - NavigationLink Label
    var navigationLinkLabel: some View {
        HStack (spacing: 4) {
            Text("See All")
            Image(systemName: "chevron.right")
        }
        .foregroundStyle(Color.text)
    }
    
    //MARK: - Recent Transaction List
    var recentTransactrionList: some View {
        
        ForEach(Array(vm.transactions.prefix(5).enumerated()), id: \.element) { index, transaction in
            TransactionRow(transaction: transaction)
            Divider()
                .opacity(index == 4 ? 0 : 1)
        }
    }
}






//MARK: - Ligth Mode Preview
#Preview ("Light Mode"){
    
    do {
        let transactionListVM: TransactionLIstViewModel = {
            let transactionListVM = TransactionLIstViewModel()
            transactionListVM.transactions = transactionListPreviewData
            return transactionListVM
        }()
        
        return RecentTransactionList()
            .environment(transactionListVM)
        
    }
    
   
}

//MARK: - Dark Mode Preview
#Preview ("Dark Mode"){
    do {
        let transactionListVM: TransactionLIstViewModel = {
            let transactionListVM = TransactionLIstViewModel()
            transactionListVM.transactions = transactionListPreviewData
            return transactionListVM
        }()
        
        return RecentTransactionList()
            .environment(transactionListVM)
            .preferredColorScheme(.dark)
        
    }
}
