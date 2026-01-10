---
description: ハンズオン手順。
---

// turbo-all

このワークフローは、Streamlitを用いたデータ可視化アプリの開発を体験するためのガイドです。

### 1. 計画とデザイン確認 (重要)
このハンズオンでは「人口流動可視化アプリ」の作成を通じて、Streamlitのデザインカスタマイズを学びます。アプリの機能は固定されていますが、見た目については以下の手順で合意形成を行います。
1. **デザインヒアリング**: アプリのUIデザイン（配色、ガラス質感の度合い、ダーク/ライトモード）や、ワイヤーフレームに相当する画面レイアウト（グラフや地図の配置）についてユーザーの要望を確認します。
2. **デザイン案の生成**: `generate_image` ツールを使用して、要望を反映した完成予想イメージ図を作成します。
3. **デザイン決定**: 生成したイメージを提示し、「このデザイン・レイアウトで実装を進める」旨の承認をユーザーから得ます。
4. **実装計画の作成**: 決定したデザインを具体化するための実装計画（`implementation_plan.md`）を作成し、承認を得てから次に進みます。
    - **重要**: 実装前に必ず [knowledge.md](file:///workspaces/st/knowledge.md) を参照し、デザイン（ガラス質感）や地図（GeoJSON）の不具合回避策を確認してください。

### 2. 環境準備
プロジェクトに必要なフォルダを作成します。
```bash
mkdir -p assets services views tests
```

### 3. 素材の準備
高品質な日本地図データ（GeoJSON）をローカルに取得します。
```bash
curl -L "https://raw.githubusercontent.com/dataofjapan/land/master/japan.geojson" -o assets/japan.geojson
```

### 4. 実装
以下の順番でファイルを実装します（エージェントに生成を依頼してください）。
1. `services/data_service.py`: データ生成または取得ロジック。
2. `views/map_view.py`: 地図描画ロジック（ローカルGeoJSONを使用）。
3. `assets/style.css`: ガラス質感のデザイン。
4. `app.py`: メインのレイアウト構成。

### 5. エラーチェックとデバッグ
実装後、動作を検証します。
```bash
# check-errors ワークフローを実行
/check-errors
```

### 6. 成果物の記録
動作が確認できたら、スクリーンショットを撮影して記録します。
```bash
/capture-screenshot
```

### 7. 完成
`walkthrough.md` を作成し、学んだ内容と成果物をまとめます。