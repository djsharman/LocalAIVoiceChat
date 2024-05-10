# Use a base image with Python 3.9 and CUDA support
FROM nvidia/cuda:11.8.0-cudnn8-runtime-ubuntu20.04

# Set environment variables to avoid interactive prompts
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/Zurich

# Set working directory
WORKDIR /app

# Install dependencies
RUN apt-get update && apt-get install -y \
    tzdata \
    ffmpeg \
    git \
    python3.9 \
    python3.9-venv \
    python3.9-dev \
    python3-pip \
    portaudio19-dev \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Configure timezone
RUN ln -fs /usr/share/zoneinfo/$TZ /etc/localtime && dpkg-reconfigure --frontend noninteractive tzdata

# Copy local repository files
COPY . .

RUN sed -i 's|D:\\\\Projekte\\\\LLaMa\\\\text-gen\\\\text-generation-webui\\\\models\\\\zephyr-7b-beta.Q5_K_M.gguf|/app/models/zephyr-7b-beta.Q5_K_M.gguf|g' /app/creation_params.json


# Install required Python packages
RUN python3.9 -m pip install --no-cache-dir \
    llama-cpp-python --force-reinstall --upgrade --no-cache-dir --verbose \
    RealtimeSTT==0.1.7 \
    RealtimeTTS==0.2.7 \
    networkx==2.8.8 \
    typing_extensions==4.10.0 \
    fsspec==2023.6.0 \
    imageio==2.31.6 \
    numpy==1.24.3 \
    requests==2.31.0 \
    pyaudio==0.2.13 \
    webrtcvad==2.0.10 \
    typeguard==4.2.1

# Define the entry point command
CMD ["python3.9", "ai_voicetalk_local.py"]
