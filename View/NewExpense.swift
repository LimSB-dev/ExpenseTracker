//
//  NewExpense.swift
//  ExpenseTraker
//
//  Created by 임성빈 on 2022/05/22.
//

import SwiftUI

struct NewExpense: View {
    @EnvironmentObject var expenseViewModel: ExpenseViewModel
    // MARK: Environment Values
    @Environment(\.self) var env
    var body: some View {
        VStack(alignment: .center, spacing: 0, content: {
            VStack(alignment: .center, spacing: 15, content: {
                Text("Add Expenses")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .opacity(0.5)
                
                // MARK: Custom TextField
                if let symbol = expenseViewModel.convertNumberToPrice(value: 0).first {
                    TextField("0", text: $expenseViewModel.amount)
                        .font(.system(size: 35))
                        .foregroundColor(Color("Gradient2"))
                        .multilineTextAlignment(.center)
                        .keyboardType(.numberPad)
                        .background {
                            Text(expenseViewModel.amount == "" ? "0" : expenseViewModel.amount)
                                .font(.system(size: 35))
                                .opacity(0)
                                .overlay(alignment: .leading, content: {
                                    Text(String(symbol))
                                        .opacity(0.5)
                                        .offset(x: -15, y: 5)
                                })
                        }
                        .padding(.vertical, 10)
                        .frame(maxWidth: .infinity)
                        .background(
                            Capsule()
                                .fill(.white)
                        )
                        .padding(.horizontal, 20)
                        .padding(.top)
                }
                
                // MARK: Custom Remark Label
                Label(title: {
                    TextField("Remark", text: $expenseViewModel.remark)
                        .padding(.leading, 10)
                }, icon: {
                    Image(systemName: "list.bullet.rectangle.portrait.fill")
                        .font(.title3)
                        .foregroundColor(Color("Gray"))
                })
                .padding(20)
                .background {
                    RoundedRectangle(cornerRadius: 15, style: .continuous)
                        .fill(.white)
                }
                .padding(.top, 25)
                
                // MARK: Custom Check Boxes
                Label(title: {
                    CustomCheckBoxes()
                }, icon: {
                    Image(systemName: "arrow.up.arrow.down")
                        .font(.title3)
                        .foregroundColor(Color("Gray"))
                })
                .padding(20)
                .background {
                    RoundedRectangle(cornerRadius: 15, style: .continuous)
                        .fill(.white)
                }
                .padding(.top, 5)
                
                // MARK: Date Label
                Label(title: {
                    DatePicker.init("", selection: $expenseViewModel.date, in: Date.distantPast...Date(), displayedComponents: [.date])
                        .datePickerStyle(.compact)
                        .labelsHidden()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 5)
                    
                }, icon: {
                    Image(systemName: "calendar")
                        .font(.title3)
                        .foregroundColor(Color("Gray"))
                })
                .padding(20)
                .background {
                    RoundedRectangle(cornerRadius: 15, style: .continuous)
                        .fill(.white)
                }
                .padding(.top, 5)
            }) // END: VStack
            .frame(maxHeight:.infinity, alignment: .center)
            
            // MARK: Save Button
            Button(action: {
                expenseViewModel.saveData(env: env)
            }, label: {
                Text("Save")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .padding(.vertical, 15)
                    .frame(maxWidth: .infinity)
                    .background {
                        RoundedRectangle(cornerRadius: 15, style: .continuous)
                            .fill(
                                LinearGradient(colors: [
                                    Color("Gradient1"),
                                    Color("Gradient2"),
                                    Color("Gradient3")
                                ], startPoint: .topLeading, endPoint: .bottomTrailing)
                            )
                    }
                    .foregroundColor(.white)
                    .padding(.bottom, 10)
            })
            .disabled(expenseViewModel.remark == "" || expenseViewModel.type == .all || expenseViewModel.amount == "")
            .opacity(expenseViewModel.remark == "" || expenseViewModel.type == .all || expenseViewModel.amount == "" ? 0.6 : 1)
        }) // END: VStack
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Color("BG")
                .ignoresSafeArea()
        )
        .overlay(alignment: .topTrailing, content: {
            // MARK: Close Button
            Button(action: {
                self.env.dismiss()
            }, label: {
                Image(systemName: "xmark")
                    .font(.title2)
                    .foregroundColor(.black)
                    .opacity(0.7)
            })
            .padding()
        })
    }
    
    // MARK: Check Boxes
    @ViewBuilder
    func CustomCheckBoxes() -> some View {
        HStack(alignment: .center, spacing: 10, content: {
            ForEach([ExpenseType.income, ExpenseType.expense], id:\.self) { type in
                ZStack(content: {
                    RoundedRectangle(cornerRadius: 2)
                        .stroke(.black, lineWidth: 2)
                        .opacity(0.5)
                        .frame(width: 20, height: 20)
                    
                    if expenseViewModel.type == type {
                        Image(systemName: "checkmark")
                            .font(.caption.bold())
                            .foregroundColor(Color("Green"))
                    }
                }) // END: ZStack
                .contentShape(Rectangle())
                .onTapGesture(perform: {
                    expenseViewModel.type = type
                })
                
                Text(type.rawValue.capitalized)
                    .font(.callout)
                    .fontWeight(.semibold)
                    .opacity(0.7)
                
            } // END: Loop
        }) // END: HStack
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.leading, 10)
    }
}

struct NewExpense_Previews: PreviewProvider {
    static var previews: some View {
        NewExpense()
            .environmentObject(ExpenseViewModel())
    }
}
