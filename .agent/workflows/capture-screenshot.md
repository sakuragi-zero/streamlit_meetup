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

### 2. Capture Screenshot
Capture the running Streamlit app (assumes it's running on port 8501).
We use a virtual time budget to allow Streamlit's animations and charts to render.
```bash
chromium --headless --no-sandbox --disable-gpu --virtual-time-budget=15000 --screenshot="/home/vscode/.gemini/antigravity/brain/d842d632-3986-4301-8a47-a1d283cb5bb1/latest_dashboard.png" --window-size=1280,1024 http://localhost:8501
```

### 3. Verification
Confirm the screenshot was generated.
```bash
ls -l /home/vscode/.gemini/antigravity/brain/d842d632-3986-4301-8a47-a1d283cb5bb1/latest_dashboard.png
```

### 4. Instruction for the Agent
Once the screenshot is generated, the agent should update the `walkthrough.md` with:
`![Dashboard Screenshot](/home/vscode/.gemini/antigravity/brain/d842d632-3986-4301-8a47-a1d283cb5bb1/latest_dashboard.png)`
