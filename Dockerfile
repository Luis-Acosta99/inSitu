# 1. Use the official Playwright image
FROM mcr.microsoft.com/playwright/python:v1.40.0-jammy

# 2. Set the working directory
WORKDIR /app

# 3. Install uv in the container
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx

# 4. Copy your dependency files first (for Docker caching)
COPY pyproject.toml uv.lock ./

# 5. Install dependencies
RUN /uv sync --frozen --no-dev

# 6. Copy the rest of your code
COPY . .

# 7. Expose the FastAPI port
EXPOSE 8000

# 8. Start the FastAPI server using the uv virtual environment
CMD ["/app/.venv/bin/uvicorn", "src.main:app", "--host", "0.0.0.0", "--port", "8000"]
