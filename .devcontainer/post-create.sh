#!/bin/bash
set -e

echo "🚀 Starting post-create setup..."

# Install uv
echo "📦 Installing uv..."
curl -LsSf https://astral.sh/uv/install.sh | sh
export PATH="$HOME/.cargo/bin:$PATH"

# Install system dependencies
echo "🔧 Installing system dependencies..."
sudo apt-get update
sudo apt-get install -y chromium fonts-noto-cjk fonts-noto-color-emoji

# Install Python dependencies
echo "🐍 Installing Python dependencies..."
uv pip install --system -r requirements.txt

echo "✅ Post-create setup completed!"
