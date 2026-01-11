---
description: Run Streamlit in headless mode, take a screenshot, and update the walkthrough.
---

// turbo-all

このワークフローは、Streamlitアプリケーションの視覚的検証を自動化します。特に Pydeck 等の WebGL を使用するコンポーネントの描画を安定させる構成になっています。

### 1. 依存関係の確認
`chromium` がインストールされていることを確認します。
```bash
which chromium || (sudo apt-get update && sudo apt-get install -y chromium)
```

### 2. アプリケーションの起動
バックグラウンドで Streamlit を起動します。ログはすべて `log/` ディレクトリに出力されます。
```bash
pgrep -f "streamlit run" | xargs -r kill || true
mkdir -p log
export STREAMLIT_SERVER_HEADLESS=true
nohup streamlit run app.py --server.port 8501 --server.enableCORS=false --server.enableXsrfProtection=false > log/screenshot_app.log 2>&1 &
# 起動確認
until curl -s http://localhost:8501/healthz > /dev/null; do sleep 1; done
# 複雑な地図のレンダリング待ち
sleep 45
```

### 3. スクリーンショットの撮影
WebGL の描画を安定させるため、ソフトウェアレンダリングを強制するフラグを使用します。
```bash
chromium --headless --no-sandbox --disable-gpu --use-gl=angle --use-angle=swiftshader --run-all-compositor-stages-before-draw --virtual-time-budget=60000 --screenshot="tests/app_screenshot.png" --window-size=1280,1024 "http://localhost:8501/?embed=true"
```

### 4. 検証と後始末
```bash
ls -l tests/app_screenshot.png
pgrep -f "streamlit run" | xargs -r kill || true
```

### 5. エージェントへの指示
生成された `tests/app_screenshot.png` を `/home/vscode/.gemini/antigravity/brain/...` (現在のタスクディレクトリ) にコピーし、`walkthrough.md` に埋め込んでください。