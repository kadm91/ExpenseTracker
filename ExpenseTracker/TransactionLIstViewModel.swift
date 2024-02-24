//
//  TransactionLIstViewModel.swift
//  ExpenseTracker
//
//  Created by Kevin Martinez on 2/20/24.
//

import Foundation

typealias TransactionGroup = Dictionary<String, [Transaction]>

@Observable
final class TransactionLIstViewModel {
    
    
    
    
    var transactions = [Transaction]()
    @ObservationIgnored private let dataServices = DataManager()
    
    init() {
        Task {
            await loadTransactions()
        }
    }
    
    func loadTransactions() async {
        do {
            self.transactions = try await dataServices.getTransaction()
        } catch {
            print("[TransactionListViewModel / loadTransaction] couln't load transaction error: \(error)")
        }
    }
    
    func groupTransactionByMonth() -> TransactionGroup {
        guard !transactions.isEmpty else { return [:] }
        
        return TransactionGroup(grouping: transactions) { $0.month }
    }
    
}
