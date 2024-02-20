//
//  TransactionLIstViewModel.swift
//  ExpenseTracker
//
//  Created by Kevin Martinez on 2/20/24.
//

import Foundation

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
    
    
}
