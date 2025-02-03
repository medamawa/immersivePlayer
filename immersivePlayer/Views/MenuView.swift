//
//  MenuView.swift
//  immersivePlayer
//
//  Created by Sogo Nishihara on 2025/02/03.
//

import SwiftUI
import RealityKit

struct MenuView: View {
    @Bindable var appModel: AppModel

    var body: some View {
        VStack {
            ToggleImmersiveSpaceButton(appModel: appModel)
        }
    }
}
