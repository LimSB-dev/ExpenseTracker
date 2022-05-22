//
//  ContentView.swift
//  ExpenseTraker
//
//  Created by 임성빈 on 2022/05/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView(content: {
            Home()
                .navigationBarHidden(true)
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
