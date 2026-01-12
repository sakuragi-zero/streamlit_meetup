---
description: Run Streamlit in headless mode, take a screenshot, and update the walkthrough.
---

// turbo-all

このワークフローは、Streamlitアプリケーションの視覚的検証を自動化します。特に Pydeck 等の WebGL を使用するコンポーネントの描画を安定させる構成になっています。


### 1. アプリケーションの起動
Streamlit をバックグラウンドで起動します。**※ nohup は絶対に使用しないでください。**
ログはすべて `log/` ディレクトリに出力されます。
```bash
mkdir -p log
streamlit run app.py > log/streamlit.log 2>&1 &
# 複雑な地図のレンダリング待ち
sleep 480
```

### 2. スクリーンショットの撮影
WebGL の描画を安定させるため、ソフトウェアレンダリングを強制するフラグを使用します。
```bash
chromium --headless --no-sandbox --disable-gpu --use-gl=angle --use-angle=swiftshader --run-all-compositor-stages-before-draw --virtual-time-budget=480000 --screenshot="tests/app_screenshot.png" --window-size=1280,1024 "http://localhost:8501/?embed=true"
```

### 3. 検証と後始末
```bash
ls -l tests/app_screenshot.png
pgrep -f "streamlit run" | xargs -r kill || true
```

### 4. エージェントへの指示
生成された `tests/app_screenshot.png` を `/home/vscode/.gemini/antigravity/brain/...` (現在のタスクディレクトリ) にコピーし、`walkthrough.md` に埋め込んでください。