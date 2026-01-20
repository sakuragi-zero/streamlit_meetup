## Google Antigravity起動後の設定手順
※必要最低限の設定だけ行います。

### Choose setup flow （設定のインポートを選択）
既存のエディターから設定をインポートする必要がない場合は**Start fresh**を選択してください。
- Start fresh
- import from VS Code
- import from Windsurf
- import from Cursor

---

### Choose an editor thome type （エディターテーマの選択）
お好みで選択してください。
- Dark
- Tokyo Night
- Light
- Solarized Light

---

### How do you want to use the Antigravity Agent? （エージェントモードの選択）
エージェントの振る舞いを決める重要な設定です。最初はAgent-assistedまたはReview-drivenがおすすめです。
今回のハンズオンでは[Secure Mode](https://antigravity.google/docs/secure-mode)を選択してください。
- Secure Mode (AIの操作は全て人間の承認が必要 + セキュリティ制御を強化)
- Agent-driven development （ほぼ全ての作業をAIが主導して進めるモード：上級者向け）
- Agent-assisted development （人間が主導しつつAIが必要に応じて積極的に支援するモード）
- Review-driven development （AIの操作は全て人間の承認が必要な安全重視モード）
- Custom configuration （開発の自動化レベルや権限を細かく自分で設定できるモード）

#### Terminal execution policy
- Always Proceed （常に進行）
エージェントは、（拒否リスト〈Deny list〉に含まれるものを除き）ターミナルコマンドを実行する前に確認を求めません。
長時間にわたって人の介入なしに動作できる最大限の能力をエージェントに与えますが、安全でないターミナルコマンドを実行してしまうリスクが最も高くなります。

- Request Review （レビューを要求）
エージェントは、（許可リスト〈Allow list〉に含まれるものを除き）ターミナルコマンドを実行する前に、必ず確認を求めます。

#### Review policy
- Always Proceed （常に進行）
エージェントはレビューを求めません。
- Agent Decides （エージェントが判断）
タスクの複雑さやユーザーの好みに基づいて、レビューを求めるかどうかをエージェントが判断します。
- Request Review （レビューを要求）
エージェントは常にレビューを求めます。

---

### 設定
お好みで設定してください。
- Keybindings (Normal / vim)
キーボードの操作方式の選択
- Extensions
よく使うプログラミング言語用の拡張機能を自動でインストール
- Command Line
ターミナルから**agy**コマンドでAntigravityを開けるようにする

最後にGoogleアカウントへのログインと利用規約の確認が終われば完了です。
お疲れ様でした!
