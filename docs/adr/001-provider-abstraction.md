# ADR-001: Unified Provider Abstraction

## Status: Accepted | Date: 2026-02-10

## Context
Each LLM provider has different APIs, auth, pricing, and capabilities. Direct integration couples application code to specific providers.

## Decision
Abstract all providers behind a unified gateway API. Applications call one endpoint; the gateway handles provider selection, fallback, and cost tracking.

## Consequences
- **Pro**: Switch providers without changing application code
- **Pro**: Cost visibility across all providers in one dashboard
- **Pro**: Automatic failover when a provider goes down
- **Con**: Additional network hop (mitigated by co-locating gateway)
