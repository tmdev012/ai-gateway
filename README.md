# AI Gateway

> Unified LLM gateway — multi-provider routing, cost tracking, rate limiting, fallback chains. Single API for Ollama, OpenAI, Anthropic, OpenRouter.

[![Python](https://img.shields.io/badge/python-3.10+-blue)]()
[![FastAPI](https://img.shields.io/badge/FastAPI-0.100+-green)]()
[![Docker](https://img.shields.io/badge/docker-compose-blue)]()

## Architecture

```
Client Request
      │
      ▼
┌──────────────┐     ┌──────────────┐     ┌──────────────┐
│   Gateway    │────▶│  Rate Limit  │────▶│    Cache     │
│   (FastAPI)  │     │  (Redis)     │     │   (Redis)    │
└──────────────┘     └──────────────┘     └──────────────┘
      │                                         │ miss
      ▼                                         ▼
┌──────────────────────────────────────────────────────┐
│                  Provider Router                      │
│  ┌────────┐  ┌────────┐  ┌────────┐  ┌────────────┐ │
│  │ Ollama │  │OpenAI  │  │Anthropic│  │OpenRouter  │ │
│  │ (local)│  │  ($)   │  │  ($$)  │  │(free tier) │ │
│  └────────┘  └────────┘  └────────┘  └────────────┘ │
│         Fallback chain: Ollama → OpenRouter → OpenAI │
└──────────────────────────────────────────────────────┘
      │
      ▼
┌──────────────┐
│ Cost Tracker │  ← per-query cost logging to SQLite
│  (SQLite)    │
└──────────────┘
```

## Features

| Feature | Description |
|---------|-------------|
| Provider routing | Single `/v1/chat` endpoint routes to any LLM |
| Fallback chains | If primary fails, auto-retry next provider |
| Cost tracking | Per-query cost logged (model, tokens, price) |
| Rate limiting | Token bucket per API key (Redis-backed) |
| Response cache | Identical prompts served from cache |
| Streaming | SSE streaming pass-through |
| Auth | API key management with scoped permissions |

## Provider Comparison

| Provider | Cost | Latency | Context | Offline |
|----------|------|---------|---------|---------|
| Ollama (local) | Free | ~4 tok/s | 4K-128K | Yes |
| OpenRouter | Free tier | ~2s | varies | No |
| OpenAI | $2-60/M tok | ~1s | 128K | No |
| Anthropic | $3-75/M tok | ~1s | 200K | No |

## Quick Start

```bash
docker-compose up -d
curl http://localhost:8000/v1/chat -d '{"prompt": "hello", "provider": "ollama"}'
```

## Revenue

Sell as managed AI gateway to businesses — **R5,000/month per client**. They get unified API, cost tracking, and provider redundancy without managing any infrastructure.

---
*MIT License*
