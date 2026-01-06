---
description: 人口流動可視化アプリ開発のハンズオン手順。
---

// turbo-all

このワークフローは、日本地図を用いた人口流動可視化アプリの開発を体験するためのガイドです。

### 1. 環境準備
プロジェクトに必要なフォルダを作成します。
```bash
mkdir -p assets services views tests .agent/workflows
```

### 2. 素材の準備
高品質な日本地図データ（GeoJSON）をローカルに取得します。
```bash
curl -L "https://raw.githubusercontent.com/dataofjapan/land/master/japan.geojson" -o assets/japan.geojson
```

### 3. 実装
以下の順番でファイルを実装します（エージェントに生成を依頼してください）。
1. `services/data_service.py`: ダミーデータの生成ロジック。
2. `views/map_view.py`: `choropleth_map` を用いた地図描画（ローカルGeoJSONを使用）。
3. `assets/style.css`: ガラス質感のダークモードデザイン。
4. `app.py`: メインのレイアウト構成。

### 4. エラーチェックとデバッグ
実装後、動作を検証します。
```bash
# check-errors ワークフローを実行
/check-errors
```
**注意**: 画面が白い場合は、GeoJSONのパスやPlotlyの `featureidkey`（今回は `properties.nam_ja`）が正しいか再確認してください。

### 5. 成果物の記録
動作が確認できたら、スクリーンショットを撮影して記録します。
```bash
/capture-screenshot
```

### 6. 完成
`walkthrough.md` を作成し、学んだ内容と成果物をまとめます。
