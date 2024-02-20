//
//  ContentView.swift
//  ExpenseTracker
//
//  Created by Kevin Martinez on 2/19/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    title
                }
                .padding()
                .frame(maxWidth: .infinity)
            }
            .background(Color.background)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem {
                    notificationIcon
                }
            }
        }
    
    }
}


//MARK: - ContentView Extensions

extension ContentView {
    
    //MARK: - Notification Icon
    
    var notificationIcon: some View {
        Image(systemName: "bell.badge")
            .symbolRenderingMode(.palette)
            .foregroundStyle(Color.icon, .primary)
    }
    
    //MARK: - Title
    
    var title: some View {
        Text("Overview")
            .font(.title2)
            .bold()
        
    }
}


//MARK: - Light Mode Preview

#Preview("Light Mode Preview"){
    ContentView()

}

//MARK: - Dark Mode Preview

#Preview ("Dark Mode Preview") {
    ContentView()
        .preferredColorScheme(.dark)
}
