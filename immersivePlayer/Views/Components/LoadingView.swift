//
//  LoadingView.swift
//  immersivePlayer
//
//  Created by Sogo Nishihara on 2025/02/05.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ZStack {
            // loading indicator
            VStack(spacing: 20) {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    .scaleEffect(1.5)
            }
        }
    }
}

#Preview {
    LoadingView()
}
