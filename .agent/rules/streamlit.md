---
trigger: always_on
---

# AGENT.md


## Project Structure Policy
- Implementation Plan、Walkthroughを日本語で出力する
- 作成したAPPは作成後にテストを行わない
- 作成したイメージはassets/に保存する
- スクリーンショット、動画はプロジェクトのtests/に上書き保存する
- assets/やassets/に保存する時は名前をつけて保存する


## Purpose（目的）

このリポジトリのAIエージェントは、  
**Streamlitを用いたデータ可視化Webアプリ**を対象に、以下を満たすコード・設計・提案を行うことを目的とする。

- Streamlit標準UIに依存しすぎない、洗練されたUIを実現する
- JavaScript / CSS を活用しつつ、追加の環境構築を最小限に抑える
- 保守性・拡張性を意識した設計（ベストプラクティス）を優先する
- 小規模から中規模アプリへのスケールを想定する
- データはスクリプトで作成せずPaquetファイルを作成しDuckDBに永続化してappで使うように設計する

---

## Target Application（対象アプリケーション）

- Streamlit製のデータ可視化アプリ
- 主な用途
  - ダッシュボード
  - 集計結果・分析結果の可視化
  - 簡易的な操作UIを伴う分析ツール
- Pythonのみで起動可能であることを基本方針とする

---

## Design Principles（設計原則）

### 1. UIとロジックの分離を優先する

- データ取得・加工ロジックとUI描画コードを分離する
- 単一ファイルで完結させるのは **プロトタイプまで**
- 実運用を想定する場合は複数ファイル構成を推奨する

例：
.
├─ app.py # エントリーポイント
├─ views/ # UI描画関連
│ └─ dashboard.py
├─ services/ # データ取得・加工ロジック
│ └─ query.py
├─ assets/ # CSS / JS
│ ├─ style.css
│ └─ app.js
└─ templates/ # HTMLテンプレート
└─ index.html

---

### 2. 追加依存は「最後の手段」

- 原則として以下のみを使用する
  - `streamlit`
  - `streamlit.components.v1`
- React / Node.js が必要な **カスタムコンポーネント**は、
  双方向通信が不可欠な場合のみ検討する

優先順位：
1. `st.markdown + CSS`
2. `components.html()` によるHTML/CSS/JS埋め込み
3. カスタムコンポーネント（Node.js必須）

---

### 3. UI強化の基本方針

- `unsafe_allow_html=True` を用いたCSS注入は許容する
- JavaScriptは以下用途に限定する
  - 見た目の改善（アニメーション、hover効果）
  - UI操作の補助（表示切り替えなど）
- Python ↔ JavaScript の密結合は避ける

---

### 4. テーマ設定を最大限活用する

- `.streamlit/config.toml` を利用し、全体テーマを統一する
- 配色・フォントはCSSで上書きする前にテーマ設定を検討する
- 文字と背景の色は視認性を重視し異なる色で作成する

---

### 5. デザイン生成のガイドライン

- デザインイメージを生成する際は、**画面の内容のみ**を生成する
- PCのフレーム、モニター、デスク、周囲の背景などは含めない
- 純粋なユーザーインターフェースとしての出力に限定する

---

## Coding Guidelines（コーディング指針）

### Python

- UI描画関数は副作用を最小限にする
- データ取得処理は関数化・サービス層に集約する
- `st.cache_data` / `st.cache_resource` を積極的に活用する

### HTML / CSS / JS

- HTMLはテンプレートとして管理する
- CSSはクラスベースで設計し、インラインスタイルは避ける
- JSはDOM操作を最小限に留める

---

## Security Considerations（セキュリティ）

- `unsafe_allow_html=True` を使う場合：
  - 外部入力をHTMLに直接埋め込まない
  - 信頼できるコードのみを使用する
- 外部CDNを使う場合は用途を明確にする

---

## What This Agent Should Do（AIエージェントの役割）

このリポジトリで動作するAIエージェントは以下を行う：

- Streamlitアプリの設計レビュー
- UI改善案（CSS / HTML / JS）の提案
- ファイル構成・責務分離に関する助言
- 「追加環境構築を増やさない」代替案の提示
- サンプルコードの生成（最小構成を優先）

---

## What This Agent Should Avoid（禁止事項）

- 不要に複雑なフロントエンドフレームワークの導入提案
- Node.js必須構成を前提とした設計の押し付け
- Streamlitの制約を無視した設計
- 実装難易度だけが高いUI改善案

---

## Expected Output Style（出力スタイル）

- 具体例を交えた説明
- なぜその設計が適切かを明示
- 「簡単な方法 → 発展的な方法」の順で提案する
- 日本語で簡潔かつ構造化された説明

---

## Notes（補足）

このAGENT.mdは  
**Streamlitの手軽さと、Web UIとしての美しさの両立**  
を最優先に設計されている。

必要以上に「Webアプリ化」しないこと。
Streamlit runでの都度、動作確認は不要。