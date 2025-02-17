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


## Immersive Playerを起動する流れ

- wantsToPresentImmersiceSpace : イマーシブビューを表示するかどうか
- immersiveSpaceState : イマーシブビューが表示されている・されていない・遷移中かどうか

1. wantsToPresentImmersiveSpaceがtoggleされる(buttonによってtoggleされる)
2. immersiveSpaceStateが.openなら閉じる
3. immersiveSpaceStateが.closeなら.inTransitionにして開く処理を始める
4. immersiveViewがonApperになったタイミングで.openに変更する

## blenderで作成したモデルを読み込む

1. .usdcでエクスポートする
2. Reality Composer Proを開いて読み込む
3. .usdcファイルを開いて、env_lightを削除する
4. シーン(.usdaファイル)を作成して、.usdcを読み込む
5. 角度などを調整して保存する

## audio関連

- 普段はAVFoundationを使って再生・停止管理を行う（on PlayerView）
- Immersiveモードになったら、AVFoundationをmuteにしながら再生・停止を行い、それに合わせてAudioPlaybackControllerを使って音を流す
- 同期のために、AppModel内のaudioPlayerStateで状態を管理
- AVFoundation側では、immersiveSpaceStateが.openに変わったらミュート、.closeに変わったらアンミュートの切り替えを行う
