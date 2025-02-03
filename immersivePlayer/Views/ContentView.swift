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
    @Bindable var appModel = AppModel()

    var body: some View {
        VStack {
            ToggleImmersiveSpaceButton(appModel: appModel)

            Text("Hello, world!")

            ButterflyView()
                .frame(width: 200, height: 200)
        }
        .padding()
    }
}

#Preview(windowStyle: .automatic) {
    ContentView()
}
