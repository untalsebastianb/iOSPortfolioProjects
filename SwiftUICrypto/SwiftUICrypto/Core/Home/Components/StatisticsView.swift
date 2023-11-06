//
//  StatisticsView.swift
//  SwiftUICrypto
//
//  Created by Juan Sebastian Bueno on 11/6/23.
//

import SwiftUI

struct StatisticsView: View {
    let stat: StatisticsModel
    var body: some View {
        VStack(alignment: .leading, spacing: 4) { 
            Text(stat.title)
                .font(.caption)
                .foregroundColor(Color.theme.secondaryText)
            Text(stat.value)
                .font(.headline)
                .foregroundColor(Color.theme.accent)
            HStack(spacing: 4) {
                Image(systemName: "triangle.fill")
                    .font(.caption2)
                    .rotationEffect(Angle(degrees: (stat.percentageChange ?? 0) >= 0 ? 0 : 180))
                Text(stat.percentageChange?.asPercentString() ?? "")
                    .font(.caption)
                .bold()
            }
            .foregroundColor( (stat.percentageChange ?? 0) >= 0 ? Color.theme.green : Color.theme.red)
            .opacity(stat.percentageChange == nil ? 0.0 : 1.0)
        }
    }
}

struct StatisticsView_Previews: PreviewProvider {
    static var previews: some View {
            StatisticsView(stat: dev.stat1)
            StatisticsView(stat: dev.stat2)
            StatisticsView(stat: dev.stat3)
            
    }
}
