//
//  Expense.swift
//  ExpenseTraker
//
//  Created by 임성빈 on 2022/05/22.
//

import SwiftUI

// MARK: Expense Model And Sample Data
struct Expense: Identifiable, Hashable {
    var id = UUID().uuidString
    var remark: String
    var amount: Double
    var date: Date
    var type: ExpenseType
    var color: String
}

enum ExpenseType: String {
    case income = "Income"
    case expense = "Expense"
    case all = "All"
}

var sample_expenses: [Expense] = [
    Expense(remark: "Magic Keyboard", amount: 99, date: Date(timeIntervalSince1970: 1652987245), type: .expense, color: "Yellow"),
    Expense(remark: "Food", amount: 19, date: Date(timeIntervalSince1970: 1652814445), type: .expense, color: "Red"),
    Expense(remark: "Magic Tracked", amount: 99, date: Date(timeIntervalSince1970: 1652382445), type: .expense, color: "Purple"),
    Expense(remark: "Uber Cab", amount: 20, date: Date(timeIntervalSince1970: 1652296045), type: .expense, color: "Green"),
    Expense(remark: "Amazon Purchase", amount: 299, date: Date(timeIntervalSince1970: 1652209645), type: .expense, color: "Yellow"),
    Expense(remark: "Stocks", amount: 399, date: Date(timeIntervalSince1970: 1652036845), type: .expense, color: "Purple"),
    Expense(remark: "In App Purchase", amount: 5.99, date: Date(timeIntervalSince1970: 1651864045), type: .expense, color: "Red"),
    Expense(remark: "Movie Ticket", amount: 99, date: Date(timeIntervalSince1970: 1651691245), type: .expense, color: "Yellow"),
    Expense(remark: "Apple Music", amount: 25, date: Date(timeIntervalSince1970: 1651518445), type: .expense, color: "Green"),
    Expense(remark: "Snack", amount: 49, date: Date(timeIntervalSince1970: 1651432045), type: .expense, color: "Purple")
]
