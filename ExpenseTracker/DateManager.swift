//
//  DateManager.swift
//  ExpenseTracker
//
//  Created by Kevin Martinez on 2/20/24.
//

import Foundation

final class DataManager {
    
    private let url = URL(string: "https://designcode.io/data/transactions.json")!
    
    
    
    
    func getTransaction() async throws -> [Transaction] {
        async let (data, _) = URLSession.shared.data(from: url)
        let transactions = try await JSONDecoder().decode([Transaction].self, from: data)
        return transactions
    }
}
