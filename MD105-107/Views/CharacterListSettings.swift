//
//  CharacterListSettings.swift
//  MD105-107
//
//  Created by Andrew Hershey on 9/27/25.
//

import SwiftUI

struct CharacterListSettings {
    var showRatings: Bool = true
    var textSize: TextSize = .normal
    var backgroundColor: BackgroundColor = .redGradient
    
    enum TextSize: String, CaseIterable {
        case small = "Small"
        case normal = "Normal"
        case large = "Large"
        
        var titleFont: Font {
            switch self {
            case .small: return .subheadline
            case .normal: return .headline
            case .large: return .title2
            }
        }
        
        var bodyFont: Font {
            switch self {
            case .small: return .caption
            case .normal: return .subheadline
            case .large: return .body
            }
        }
        
        var detailFont: Font {
            switch self {
            case .small: return .caption2
            case .normal: return .footnote
            case .large: return .caption
            }
        }
    }
    
    enum BackgroundColor: String, CaseIterable {
        case redGradient = "Red"
        case blueGradient = "Blue"
        case purpleGradient = "Purple"
        case greenGradient = "Green"
        
        var gradient: LinearGradient {
            switch self {
            case .redGradient:
                return LinearGradient(colors: [.black, .red.opacity(0.6)], startPoint: .topLeading, endPoint: .bottomTrailing)
            case .blueGradient:
                return LinearGradient(colors: [.black, .blue.opacity(0.6)], startPoint: .topLeading, endPoint: .bottomTrailing)
            case .purpleGradient:
                return LinearGradient(colors: [.black, .purple.opacity(0.6)], startPoint: .topLeading, endPoint: .bottomTrailing)
            case .greenGradient:
                return LinearGradient(colors: [.black, .green.opacity(0.6)], startPoint: .topLeading, endPoint: .bottomTrailing)
            }
        }
    }
}
