//
//  ContentView.swift
//  immersivePlayer
//
//  Created by Sogo Nishihara on 2025/02/01.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ContentView: View {
    var body: some View {
        VStack {
            ToggleImmersiveSpaceButton()

            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview(windowStyle: .automatic) {
    ContentView()
}
