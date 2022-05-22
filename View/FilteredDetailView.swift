//
//  FilteredDetailView.swift
//  ExpenseTraker
//
//  Created by 임성빈 on 2022/05/22.
//

import SwiftUI

struct FilteredDetailView: View {
    @EnvironmentObject var expenseViewModel: ExpenseViewModel
    // MARK: Environment Values
    @Environment(\.self) var env
    @Namespace var animation
    var body: some View {
        ScrollView(.vertical, showsIndicators: false, content: {
            VStack(alignment: .center, spacing: 15, content: {
                HStack(alignment: .center, spacing: 12, content: {
                    // MARK: Back Button
                    Button(action: {
                        self.env.dismiss()
                    }, label: {
                        Image(systemName: "arrow.backward.circle.fill")
                            .foregroundColor(.gray)
                            .frame(width: 40, height: 40)
                            .background(Color.white, in: RoundedRectangle(cornerRadius: 10, style: .continuous))
                            .shadow(color: .black.opacity(0.1), radius: 5, x: 5, y: 5)
                    })
                    
                    Text("Transactions")
                        .font(.title.bold())
                        .opacity(0.7)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Button(action: {
                        expenseViewModel.showFilterView = true
                    }, label: {
                        Image(systemName: "slider.horizontal.3")
                            .foregroundColor(.gray)
                            .frame(width: 40, height: 40)
                            .background(Color.white, in:RoundedRectangle(cornerRadius: 10, style:.continuous))
                            .shadow(color: .black.opacity(0.1), radius:5, x: 5, y: 5)
                    }) // END: Button
                    
                }) // END: HStack
                
                // MARK: Expense Card View For Currently Selected Date
                ExpenseCard(isFilter: true)
                    .environmentObject(expenseViewModel)
                
                CustomSegmentedControl()
                    .padding(.top)
                
                // MARK: Currently Filtered Date With Amount
                VStack(alignment: .center, spacing: 15, content: {
                    Text(expenseViewModel.convertDateToString())
                        .opacity(0.7)
                    
                    Text(expenseViewModel.convertExpensesToCurrency(expenses: expenseViewModel.expenses, type: expenseViewModel.tabName))
                        .font(.title.bold())
                        .opacity(0.9)
                        .animation(.none, value: expenseViewModel.tabName)
                })
                .padding()
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 15, style: .continuous)
                        .fill(.white)
                )
                .padding(.vertical, 20)
                
                ForEach(expenseViewModel.expenses.filter{
                    return $0.type == expenseViewModel.tabName
                }) { expense in
                    TransactionCardView(expense: expense)
                        .environmentObject(expenseViewModel)
                }
                
            }) // END: VStack
            .padding()
        }) // END: ScrollView
        .navigationBarHidden(true)
        .background(
            Color("BG")
                .ignoresSafeArea()
        )
        .overlay {
            FilterView()
        }
    }
    
    // MARK: Filter View
    @ViewBuilder
    func FilterView() -> some View {
        ZStack(content: {
            Color.black
                .opacity(expenseViewModel.showFilterView ? 0.25 : 0)
                .ignoresSafeArea()
            
            // MARK: Based On the Date Filter Expenses Array
            if expenseViewModel.showFilterView {
                VStack(alignment: .leading, spacing: 10, content: {
                    HStack {
                        Text("Start Date")
                            .font(.callout)
                        .opacity(0.7)
                        
                        Spacer()
                        
                        DatePicker("", selection: $expenseViewModel.startDate, in: Date.distantPast...Date(), displayedComponents: [.date])
                            .labelsHidden()
                            .datePickerStyle(.compact)
                    }
                 
                    Divider()
                    
                    HStack {
                        Text("End Date")
                            .font(.callout)
                            .opacity(0.7)
    
                        Spacer()
                        
                        DatePicker("", selection: $expenseViewModel.endDate, in: Date.distantPast...Date(), displayedComponents: [.date])
                            .labelsHidden()
                            .datePickerStyle(.compact)
                    }
                    
                }) // END: VStack
                .padding()
                .background{
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(.white)
                }
                // MARK: Close Button
                .overlay(alignment: .topTrailing, content: {
                    Button(action: {
                        expenseViewModel.showFilterView = false
                    }, label: {
                        Image(systemName: "xmark")
                            .font(.title3)
                            .foregroundColor(.black)
                            .padding(6)
                    })
                    .background(
                        Circle()
                            .foregroundColor(.white)
                    )
                    .offset(y: -35)
                })
                .padding()
            }
        })
        .animation(.easeInOut, value: expenseViewModel.showFilterView)
    }
    
    // MARK: Custom Segmented Control
    @ViewBuilder
    func CustomSegmentedControl() -> some View {
        HStack(alignment: .center, spacing: 0, content: {
            ForEach([ExpenseType.income, ExpenseType.expense], id:\.rawValue) { tab in
                Text(tab.rawValue.capitalized)
                    .fontWeight(.semibold)
                    .foregroundColor(expenseViewModel.tabName == tab ? .white : .black)
                    .opacity(expenseViewModel.tabName == tab ? 1 : 0.7)
                    .padding(.vertical, 12)
                    .frame(maxWidth: .infinity)
                    .background{
                        // MARK: With Match Geometry Effect
                        if expenseViewModel.tabName == tab {
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(
                                    LinearGradient(colors: [
                                        Color("Gradient1"),
                                        Color("Gradient2"),
                                        Color("Gradient3")
                                    ], startPoint: .topLeading, endPoint: .bottomTrailing)
                                )
                                .matchedGeometryEffect(id: "TAB", in: animation)
                        }
                    }
                    .contentShape(Rectangle())
                    .onTapGesture(perform: {
                        withAnimation{
                            expenseViewModel.tabName = tab
                        }
                    })
            } // END: Loop
        }) // END: HStack
        .padding(5)
        .background(
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(.white)
        )
    }
}

struct FilteredDetailView_Previews: PreviewProvider {
    static var previews: some View {
        FilteredDetailView()
            .environmentObject(ExpenseViewModel())
    }
}
