#!/bin/bash
# Quick launcher for different models

MODEL="${1:-cognitivecomputations/dolphin-2.9-llama3-8b}"

echo "Starting vLLM Blackwell stack..."
echo "Model: $MODEL"

# Update docker-compose with model
cat > docker-compose.override.yml <<EOF
version: '3.8'
services:
  vllm:
    command: >
      $MODEL
      --host 0.0.0.0
      --port 8000
EOF

docker compose up -d

echo ""
echo "Stack started!"
echo "SillyTavern: http://localhost:8000"
echo "vLLM API: http://localhost:5000/v1"
echo ""
echo "Check logs: docker compose logs -f vllm"
