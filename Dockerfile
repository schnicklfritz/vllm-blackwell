# vLLM for RTX 5090 (Blackwell)
FROM nvidia/cuda:12.8.0-devel-ubuntu24.04

ENV DEBIAN_FRONTEND=noninteractive
ENV TORCH_CUDA_ARCH_LIST="12.0"
ENV VLLM_FLASH_ATTN_VERSION=2

# Install dependencies (removed nvidia-cuda-toolkit)
RUN apt-get update && apt-get install -y \
    python3.12 \
    python3.12-venv \
    python3-pip \
    python3-dev \
    build-essential \
    git \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Create non-root user
RUN useradd -m -s /bin/bash vllm
USER vllm
WORKDIR /home/vllm

# Create venv
RUN python3.12 -m venv /home/vllm/venv

# Install PyTorch nightly with CUDA 12.8
RUN /home/vllm/venv/bin/pip install --upgrade pip && \
    /home/vllm/venv/bin/pip install --pre torch torchvision \
    --index-url https://download.pytorch.org/whl/nightly/cu128

# Build vLLM from source with Blackwell support
RUN /home/vllm/venv/bin/pip install \
    git+https://github.com/vllm-project/vllm.git

ENV PATH="/home/vllm/venv/bin:$PATH"

EXPOSE 8000

ENTRYPOINT ["/home/vllm/venv/bin/vllm", "serve"]
CMD ["--help"]
