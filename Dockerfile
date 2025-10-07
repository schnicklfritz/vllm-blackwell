# Use official vLLM image (already has Blackwell support)
FROM vllm/vllm-openai:latest

# Expose port
EXPOSE 8000

# Entry point already configured in base image
