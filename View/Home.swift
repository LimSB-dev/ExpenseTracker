//
//  Home.swift
//  ExpenseTraker
//
//  Created by 임성빈 on 2022/05/22.
//

import SwiftUI

struct Home: View {
    @StateObject var expenseViewModel: ExpenseViewModel = .init()
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false, content: {
            VStack(alignment: .leading, spacing: 12, content: {
                HStack(alignment: .center, spacing: 12, content: {
                    VStack(alignment: .leading, spacing: 4, content: {
                        Text("Welcome")
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundColor(.gray)
                        
                        Text("Lim Seong Bin")
                            .font(.title2.bold())
                    }) // END: VStack
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    NavigationLink {
                        FilteredDetailView()
                            .environmentObject(expenseViewModel)
                    } label: {
                        Image(systemName: "hexagon.fill")
                            .foregroundColor(.gray)
                            .overlay(content: {
                                Circle()
                                    .stroke(.white, lineWidth: 2)
                                    .padding(7)
                            })
                            .frame(width: 40, height: 40)
                            .background(Color.white, in: RoundedRectangle(cornerRadius: 10, style: .continuous))
                            .shadow(color: .black.opacity(0.1), radius: 5, x: 5, y: 5)
                    }
                }) // END: HStack
                
                ExpenseCard()
                    .environmentObject(expenseViewModel)
                TransactionsView()
            }) // END: VStack
            .padding()
        }) // END: ScrollView
        .background(
            Color("BG")
                .ignoresSafeArea()
        )
        .fullScreenCover(isPresented: $expenseViewModel.addNewExpense) {
            expenseViewModel.clearData()
        } content: {
            NewExpense()
                .environmentObject(expenseViewModel)
        }
        .overlay(alignment: .bottomTrailing, content: {
            AddButton()
        })
    }
    
    // MARK: Add New Expense Button
    @ViewBuilder
    func AddButton() -> some View {
        Button(action: {
            expenseViewModel.addNewExpense.toggle()
        }, label: {
            Image(systemName: "plus")
                .font(.system(size: 25, weight: .medium))
                .foregroundColor(.white)
                .frame(width: 55, height: 55)
                .background {
                    Circle()
                        .fill(
                            .linearGradient(colors: [
                                Color("Gradient3"),
                                Color("Gradient2"),
                                Color("Gradient1"),
                            ], startPoint: .topLeading, endPoint: .bottomTrailing)
                        )
                }
                .shadow(color: .black.opacity(0.1), radius: 5, x: 5, y: 5)
        })
        .padding()
    }
    
    // MARK: Transactions view
    @ViewBuilder
    func TransactionsView() -> some View {
        VStack(alignment: .center, spacing: 15, content: {
            Text("Transactions")
                .font(.title2.bold())
                .opacity(0.7)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom)
            
            ForEach(expenseViewModel.expenses) { expense in
                // MARK: Transaction Card View
                TransactionCardView(expense: expense)
                    .environmentObject(expenseViewModel)
            }
        })
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
