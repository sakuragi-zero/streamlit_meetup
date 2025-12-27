---
description: Run Streamlit in headless mode, take a screenshot, and update the walkthrough.
---

// turbo-all

This workflow automates the visual verification process for Streamlit applications.

### 1. Ensure Dependencies
Ensure that `chromium` is installed for capturing screenshots.
```bash
which chromium || (sudo apt-get update && sudo apt-get install -y chromium)
```

### 2. Run Streamlit (if not running)
Start the Streamlit application in headless mode. 
**IMPORTANT**: Wait for at least 20 seconds to ensure the loading screen has cleared and charts have finished rendering.
```bash
streamlit run app.py --server.headless true &
sleep 20
```

### 3. Capture Screenshot
Capture the running Streamlit app.
```bash
chromium --headless --no-sandbox --disable-gpu --virtual-time-budget=20000 --screenshot="/home/vscode/.gemini/antigravity/brain/aa519c18-f8f8-4667-a126-63377eda2b97/latest_dashboard.png" --window-size=1280,1024 http://localhost:8501
```

### 4. Verification
Confirm the screenshot was generated.
```bash
ls -l /home/vscode/.gemini/antigravity/brain/aa519c18-f8f8-4667-a126-63377eda2b97/latest_dashboard.png
```

### 5. Instruction for the Agent
Once the screenshot is generated, the agent should update the `walkthrough.md` with:
`![Dashboard Screenshot](/home/vscode/.gemini/antigravity/brain/aa519c18-f8f8-4667-a126-63377eda2b97/latest_dashboard.png)`
