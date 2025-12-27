---
description: Check if the devcontainer environment is correctly set up with required tools.
---

// turbo-all

This workflow verifies the presence of key tools in the environment and suggests fixes if they are missing.

### 1. Check Python and Dependency Managers
Run the following to check for `python`, `pip`, and `uv`.
```bash
python --version
pip --version
uv --version
```

### 2. Check Streamlit
Verify if `streamlit` is installed and accessible.
```bash
streamlit --version
```

### 3. Check Browser Environment
Verify if `chromium` is installed (required for automated screenshots/testing).
```bash
chromium --version || chromium-browser --version
```

### 4. Check Workspace Structure
Ensure the necessary project directories exist.
```bash
ls -d assets services views
```

### 5. Summary and Fixes
If any of the above fail, run the following to attempt a repair:
```bash
pip install uv streamlit && sudo apt-get update && sudo apt-get install -y chromium
```
