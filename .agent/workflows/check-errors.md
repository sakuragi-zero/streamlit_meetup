---
description: Check for Streamlit execution errors and logical crashes.
---

// turbo-all

このワークフローは、Streamlitアプリケーションの実行時エラーを検出します。

### 1. アプリケーションの試行起動
バックグラウンドでStreamlitを起動し、ログをファイルに出力します。
```bash
# ポートが既に使用されている場合は解放
pgrep -f "streamlit run" | xargs -r kill
mkdir -p log
nohup streamlit run app.py --server.headless true --server.port 8501 > log/error_detection.log 2>&1 &
sleep 15
```

### 2. 画面上のエラー確認 (ブラウザチェック)
ブラウザを使用して実際の画面に表示されているエラーメッセージや、不完全なレンダリングを検出します。
```bash
# エージェントへの指示: 
# http://localhost:8501 にアクセスし、画面内に "Error", "Exception", "Traceback" 
# という文字が表示されていないか、または画面が真っ白でないか確認してください。
```

### 2. エラーログの走査
出力されたログに `Traceback`, `Error`, `Exception` などのキーワードが含まれていないか確認します。
```bash
grep -Ei "traceback|error|exception" log/error_detection.log || echo "No obvious errors found in log."
```

### 3. プロセスのクリーンアップ
検証用のプロセスを終了します。
```bash
pgrep -f "streamlit run" | xargs -r kill
```

### 4. 判定
もしログにエラーが含まれていた場合は、該当箇所を修正してください。画面が白い場合は、ライブラリの読み込み不良やGeoJSONの取得失敗などが考えられます。