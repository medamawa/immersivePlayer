//
//  ToggleImmersiveSpaceButton.swift
//  immersivePlayer
//
//  Created by Sogo Nishihara on 2025/02/01.
//

import SwiftUI

struct ToggleImmersiveSpaceButton: View {
    @Bindable var appModel: AppModel

    var body: some View {
        Button {
            appModel.wantsToPresentImmersiveSpace.toggle()
        } label: {
            Text(appModel.wantsToPresentImmersiveSpace ? "back" : "immersive")
        }
    }
}

#Preview {
    ToggleImmersiveSpaceButton(appModel: AppModel())
}
