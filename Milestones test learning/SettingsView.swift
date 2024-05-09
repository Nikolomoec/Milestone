//
//  SettingsView.swift
//  Milestones test learning
//
//  Created by Nikita Kolomoec on 09.05.2024.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        ScrollView {
            LazyVStack {
                
            }
        }
    }
}

#Preview {
    SettingsView()
}

struct SettingsTopBar: View {
    var title: String
    
    var backButtonOn = true
    var leaveSheetButtonOn = true
    
    var body: some View {
        HStack {
            if backButtonOn {
                Image(systemName: "chevron.left")
            }
            
            Text(title)
            
            if leaveSheetButtonOn {
                Image(systemName: "checkmark")
            }
        }
        .foregroundStyle(.white)
    }
}
