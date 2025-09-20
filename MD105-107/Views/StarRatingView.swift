//
//  StarRatingView.swift
//  MD105-107
//
//  Created by Andrew Hershey on 9/20/25.
//

import SwiftUI

struct StarRatingView: View {
    @Binding var rating: Int
    var max: Int = 5
    
    var body: some View {
        HStack(spacing: 8) {
            ForEach(1...max, id: \.self) { star in
                Image(systemName: star <= rating ? "star.fill" : "star")
                    .foregroundColor(star <= rating ? .yellow : .gray)
                    .font(.system(size: 22))
                    .accessibilityLabel("\(star) star\(star == 1 ? "" : "s")")
                    .onTapGesture { rating = star }
            }
        }
    }
}

#Preview("Stars") {
    StarRatingView(rating: .constant(3))
        .padding()
}
