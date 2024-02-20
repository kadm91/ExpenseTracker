//
//  TransactionModel.swift
//  ExpenseTracker
//
//  Created by Kevin Martinez on 2/20/24.
//

import Foundation

struct Transaction: Identifiable {
    let id: Int
    let date: String
    let institution: String
    let account: String
    let merchant: String
    let amount: Double
    let type: TransactionType.RawValue
    var categoryId: Int
    var category: String
    let isPending: Bool
    var isTranfer: Bool
    var isExpense: Bool
    var isEdited: Bool
    
    var dateParsed: Date {
        date.dateParsed()
    }
}

enum TransactionType: String {
    case debit, credit
}


