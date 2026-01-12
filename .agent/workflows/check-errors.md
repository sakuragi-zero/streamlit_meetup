---
description: Check for Streamlit execution errors and logical crashes.
---

// turbo-all

このワークフローは、Streamlitアプリケーションの実行時エラー（起動時および初回アクセス時）を検出します。

### 1. アプリケーションの試行起動
バックグラウンドでStreamlitを起動し、ログをファイルに出力します。
```bash
# プロセスのクリーンアップ
pgrep -f "streamlit run" | xargs -r kill || true
mkdir -p log
export STREAMLIT_SERVER_HEADLESS=true
export PYTHONUNBUFFERED=1
nohup streamlit run app.py --server.port 8501 --server.enableCORS=false --server.enableXsrfProtection=false > log/error_detection.log 2>&1 &
# サーバーの起動待機
until curl -s http://localhost:8501/healthz > /dev/null; do sleep 1; done
```

### 2. アクセストリガー（実行時エラーの誘発）
実際にページにアクセスして、セッション開始時に発生するエラーをログに出力させます。
```bash
chromium --headless --no-sandbox --disable-gpu --dump-dom http://localhost:8501 > /dev/null 2>&1
sleep 5
```

### 3. エラーログの走査
出力されたログに `Traceback`, `Error`, `Exception`, `Uncaught app execution` などのキーワードが含まれていないか確認します。
```bash
grep -Ei "traceback|error|exception|uncaught" log/error_detection.log || echo "No obvious errors found in log."
```

### 4. プロセスのクリーンアップ
検証用のプロセスを終了します。
```bash
pgrep -f "streamlit run" | xargs -r kill || true
```

### 5. 判定
もしログにエラーが含まれていた場合は、該当箇所を修正してください。
特にセッション開始後の `NameError` や `ImportError` は、アクセスを発生させるまでログに出ないため注意が必要です。