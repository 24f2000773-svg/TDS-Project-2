FROM python:3.12-slim

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PATH=/root/.local/bin:$PATH

WORKDIR /app

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential curl git gcc g++ libpq-dev \
    libnss3 libatk1.0-0 libatk-bridge2.0-0 libcups2 \
    libx11-xcb1 libxcomposite1 libxdamage1 libxrandr2 \
    libgbm1 libxss1 libasound2 libpangocairo-1.0-0 ca-certificates \
  && rm -rf /var/lib/apt/lists/*

COPY requirements.txt pyproject.toml /app/

RUN python -m pip install --upgrade pip setuptools wheel \
 && pip install -r requirements.txt

COPY . /app

RUN python -m pip install --upgrade pip setuptools wheel \
 && pip install -e . \
 && python -m playwright install --with-deps || true

ENV PYTHONPATH=/app:${PYTHONPATH}

CMD ["python", "main.py"]
