//
//  TransactionLIstViewModel.swift
//  ExpenseTracker
//
//  Created by Kevin Martinez on 2/20/24.
//

import Foundation
import Collections

typealias TransactionGroup = OrderedDictionary<String, [Transaction]>
typealias TransactionPrefixSum = OrderedDictionary<String, Double>

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
    
    func AccumulateTransactions() -> TransactionPrefixSum {
       
        guard !transactions.isEmpty else {return [:] }
        
        let today = "02/17/2022".dateParsed() // Date()
        let dateInterval = Calendar.current.dateInterval(of: .month, for: today)!
      
        
        var sum: Double = .zero
        var cumulativeSum = TransactionPrefixSum()
        
        for date in stride(from: dateInterval.start, through: today, by: 60 * 60 * 24) {
            let dailyExpenses = transactions.filter({ $0.dateParsed == date && $0.isExpense })
            let dailyTotal = dailyExpenses.reduce(0) { $0 - $1.signedAmount }
            
            sum += dailyTotal
            cumulativeSum[date.formatted()] = sum
           
        }
        return cumulativeSum
    }
    
    
    func findTransaction(_ day: String) -> Double? {
        if let transaction = AccumulateTransactions().first(where: {$0.key == day}) {
            return transaction.value
        }
        return nil
    }
}
