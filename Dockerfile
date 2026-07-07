FROM python:3.11-slim

# Install system dependencies and curl
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Install uv for fast package management (recommended by AgentScope)
ADD https://astral.sh/uv/install.sh /uv-installer.sh
RUN sh /uv-installer.sh && rm /uv-installer.sh
ENV PATH="/root/.local/bin/:$PATH"

WORKDIR /app

# Install QwenPaw 
RUN uv pip install --system qwenpaw agentscope

# Copy your configuration files if you have any pre-configured locally
COPY . /app

# Render passes the PORT environment variable. We tell QwenPaw to bind to it.
# If QwenPaw natively looks for a flag, we inject $PORT. 
EXPOSE 10000

# Start command: Replace `--port` with QwenPaw's actual server flag if it differs
CMD ["sh", "-c", "qwenpaw start --host 0.0.0.0 --port ${PORT:-10000}"]

