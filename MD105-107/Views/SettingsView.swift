//
//  SettingsView.swift
//  MD105-107
//
//  Created by Andrew Hershey on 9/27/25.
//

import SwiftUI

struct SettingsView: View {
    @Binding var listSettings: CharacterListSettings
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            Form {
                Section("List Settings") {
                    Toggle(isOn: $listSettings.showRatings) {
                        HStack {
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                            Text("Show Ratings")
                        }
                    }
                    
                    Picker("Text Size", selection: $listSettings.textSize) {
                        ForEach(CharacterListSettings.TextSize.allCases, id: \.self) { size in
                            Text(size.rawValue).tag(size)
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    Picker("Background Color", selection: $listSettings.backgroundColor) {
                        ForEach(CharacterListSettings.BackgroundColor.allCases, id: \.self) { color in
                            Text(color.rawValue).tag(color)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section {
                    Text("Customize how the character list appears and behaves.")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                    .fontWeight(.semibold)
                }
            }
        }
    }
}

#Preview {
    SettingsView(listSettings: .constant(CharacterListSettings()))
}
