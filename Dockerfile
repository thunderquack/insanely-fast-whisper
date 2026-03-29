FROM nvidia/cuda:12.8.1-cudnn-runtime-ubuntu22.04

ENV DEBIAN_FRONTEND=noninteractive \
    PYTHONUNBUFFERED=1 \
    PIP_NO_CACHE_DIR=1 \
    HF_HOME=/cache/huggingface \
    TRANSFORMERS_CACHE=/cache/huggingface

RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    python3-venv \
    ffmpeg \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

RUN python3 -m pip install --upgrade pip setuptools wheel && \
    python3 -m pip install --index-url https://download.pytorch.org/whl/cu128 \
    torch torchvision torchaudio && \
    python3 -m pip install \
    transformers \
    accelerate \
    pyannote-audio>=3.1.0 \
    setuptools>=68.2.2 \
    rich>=13.7.0

COPY . /app

RUN python3 -m pip install --no-deps .

ENTRYPOINT ["insanely-fast-whisper"]
