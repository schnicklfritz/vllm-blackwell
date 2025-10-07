# vLLM Blackwell + SillyTavern Stack

Pre-configured stack for RTX 5090 with:
- vLLM (PyTorch 2.9, CUDA 12.8, sm_120 support)
- SillyTavern (official image)
- Docker Compose orchestration

## Quick Start

Clone repository

git clone https://github.com/Schnicklfritz/vllm-blackwell
cd vllm-blackwell
Start stack

docker compose up -d
Check logs

docker compose logs -f vllm

## Access

- **SillyTavern**: http://localhost:8000
- **vLLM API**: http://localhost:5000/v1

## Configuration

### Change Model

Edit `docker-compose.yml` command section:

command: >
YOUR-MODEL-HERE
--host 0.0.0.0
--port 8000

### Examples

**Dolphin 70B AWQ:**
command: >
julep-ai/dolphin-2.9.1-llama-3-70b-awq
--host 0.0.0.0
--port 8000
--gpu-memory-utilization 0.85

**Qwen 32B Abliterated:**
command: >
huihui-ai/Qwen2.5-32B-Instruct-abliterated
--host 0.0.0.0
--port 8000

## SillyTavern Setup

1. Open SillyTavern: http://localhost:8000
2. Go to API Settings
3. Select "Text Completion" or "Chat Completion"
4. API URL: `http://vllm:8000/v1` (internal) or `http://localhost:5000/v1` (external)
5. Save and test connection

## QuickPod Usage

Use this repo as a custom template or pull the image:

docker pull schnicklbob/vllm-blackwell:latest

## Troubleshooting

**GPU not detected:**
docker run --rm --runtime=nvidia --gpus all nvidia/cuda:12.8.0-base-ubuntu24.04 nvidia-smi

**Model download slow:**
Set HuggingFace token:

environment:

    HF_TOKEN=your_token_here


