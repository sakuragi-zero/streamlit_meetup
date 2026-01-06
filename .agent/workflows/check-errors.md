---
description: Check for Streamlit execution errors and logical crashes.
---

// turbo-all

このワークフローは、Streamlitアプリケーションの実行時エラーを検出します。

### 1. アプリケーションの試行起動
バックグラウンドでStreamlitを起動し、ログをファイルに出力します。
```bash
mkdir -p log
pgrep -f "streamlit run" | xargs -r kill
nohup streamlit run app.py --server.headless true > log/error_detection.log 2>&1 &
sleep 15
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