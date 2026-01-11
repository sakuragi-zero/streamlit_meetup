FROM mcr.microsoft.com/devcontainers/python:3.12

# system packages
RUN apt-get update && apt-get install -y \
    chromium \
    fonts-noto-cjk \
    fonts-noto-color-emoji \
    curl \
    && rm -rf /var/lib/apt/lists/*

# install uv into /usr/local/bin
RUN curl -LsSf https://astral.sh/uv/install.sh \
    | UV_INSTALL_DIR=/usr/local/bin sh

# python deps (system install, root)
WORKDIR /tmp
COPY requirements.txt .

RUN uv pip install --system -r requirements.txt
