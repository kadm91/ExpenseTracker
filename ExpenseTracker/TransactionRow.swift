//
//  TransactionRow.swift
//  ExpenseTracker
//
//  Created by Kevin Martinez on 2/20/24.
//

import SwiftUI
import SwiftUIFontIcon

struct TransactionRow: View {
    
    var transaction: Transaction
    
    var body: some View {
        HStack (spacing: 20) {
            
            transactionIcon
            
            VStack (alignment: .leading, spacing: 6) {
                transactionMerchant
                transactionCategory
                transactionDate
            }
            
            Spacer()
            
            transactionAmount
          
        }
        .padding(.vertical, 8)
    }
}

//MARK: - TransactionRow Extension

private extension TransactionRow {
    
    //MARK: - Transaction Merchant
    var transactionMerchant: some View {
        Text(transaction.merchant)
            .font(.subheadline)
            .bold()
            .lineLimit(1)
    }
    
    //MARK: - Transacion Category
    var transactionCategory: some View {
            Text(transaction.category)
                .font(.footnote)
                .opacity(0.7)
                .lineLimit(1)
    }
    

    //MARK: - Transaction Date
    var transactionDate: some View {
        Text(transaction.dateParsed, format: .dateTime.year().month().day())
            .font(.footnote)
            .foregroundStyle(.secondary)
    }
    
    //MARK: - Transaction Amount
    var transactionAmount: some View {
        Text(transaction.signedAmount, format: .currency(code: "USD"))
            .bold()
            .foregroundStyle(transaction.type == TransactionType.credit.rawValue ? Color.text : .primary)
    }
    
    //MARK: - Transaction Icon
    var transactionIcon: some View {
        RoundedRectangle(cornerRadius: 20, style: .continuous)
            .fill(Color.icon.opacity(0.3))
            .frame(width: 44, height: 44)
            .overlay {
                FontIcon.text(.awesome5Solid(code: .icons), fontsize: 24, color: Color.icon)
            }
    }
    
}



//MARK: - Ligth Mode Preview
#Preview("Light Mode") {
        TransactionRow(transaction: transactionPreviewData)
}

#Preview("Dark Mode"){
    TransactionRow(transaction: transactionPreviewData)
        .preferredColorScheme(.dark)
}
