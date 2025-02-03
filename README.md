# Immersive Player

## ファイル構造

### AppModel
- 環境変数の宣言

### ImmersivePlayerApp
- アプリのメイン関数
- ウィンドウやイマーシブビューの管理を行う

### /Views
- viewのファイルがまとまっている

### /ViewModels
- viewの要素を構成するためのロジックがまとまっている
- entityの初期化、更新の設定などをしている

### /ECS
- Entity, Component, Systemの設定を行う


### Immersive Playerを起動する流れ

- wantsToPresentImmersiceSpace : イマーシブビューを表示するかどうか
- immersiveSpaceState : イマーシブビューが表示されている・されていない・遷移中かどうか

1. wantsToPresentImmersiveSpaceがtoggleされる(buttonによってtoggleされる)
2. immersiveSpaceStateが.openなら閉じる
3. immersiveSpaceStateが.closeなら.inTransitionにして開く処理を始める
4. immersiveViewがonApperになったタイミングで.openに変更する

