# Botiaga - Usage Examples

## Quick Start

### 1. Generate Business Plan (CEO Agent)

```bash
curl -X POST https://juozas.app.n8n.cloud/webhook/ceo \
  -H "Content-Type: application/json" \
  -d '{
    "idea": "AI-powered language learning app for Lithuanian expats"
  }'
```

**Response:**
```json
{
  "session_id": "BIZ-1768665382425",
  "status": "COMPLETED",
  "tokens": 1042,
  "business_plan": {
    "executive_summary": {
      "business_name": "LitSpeak AI",
      "mission_statement": "...",
      "business_goals": [...]
    },
    "market_analysis": {...},
    "business_model": {...},
    "product": {...},
    "legal_germany": {...},
    "financial": {
      "initial_investment": "€150,000",
      "break_even_analysis": "18 months"
    },
    "marketing": {...},
    "action_plan": {...},
    "risks": [...],
    "team": {...}
  }
}
```

---

### 2. Quick Analysis (AI Brain)

For faster, lightweight analysis:

```bash
curl -X POST https://juozas.app.n8n.cloud/webhook/ai-brain \
  -H "Content-Type: application/json" \
  -d '{
    "idea": "Subscription box for eco-friendly cleaning products"
  }'
```

**Response:**
```json
{
  "session_id": "BIZ-...",
  "status": "COMPLETED",
  "ai_model": "gpt-4o",
  "analysis": {
    "domain": "ecommerce",
    "complexity": "medium",
    "market_size": "€500M+ in Germany",
    "competition": "Medium - some established players",
    "unique_value": "Sustainable focus + convenience"
  },
  "business_plan": {...},
  "decision": "GO"
}
```

---

### 3. Retrieve Business History

```bash
curl -X GET https://juozas.app.n8n.cloud/webhook/business-history
```

**Response:**
```json
{
  "status": "success",
  "count": 5,
  "sessions": [
    "BIZ-1768665382425",
    "BIZ-1768665410611",
    ...
  ]
}
```

---

### 4. Get Specific Business Plan

```bash
curl -X POST https://juozas.app.n8n.cloud/webhook/business-plan \
  -H "Content-Type: application/json" \
  -d '{
    "session_id": "BIZ-1768665382425"
  }'
```

---

## Business Ideas to Test

### E-commerce
```bash
curl -X POST https://juozas.app.n8n.cloud/webhook/ceo \
  -H "Content-Type: application/json" \
  -d '{"idea": "Sustainable fashion marketplace for Lithuania"}'
```

### SaaS
```bash
curl -X POST https://juozas.app.n8n.cloud/webhook/ceo \
  -H "Content-Type: application/json" \
  -d '{"idea": "Project management tool for remote teams"}'
```

### Fintech
```bash
curl -X POST https://juozas.app.n8n.cloud/webhook/ceo \
  -H "Content-Type: application/json" \
  -d '{"idea": "Micro-investment app for millennials in Germany"}'
```

### Food & Beverage
```bash
curl -X POST https://juozas.app.n8n.cloud/webhook/ceo \
  -H "Content-Type: application/json" \
  -d '{"idea": "Ghost kitchen for healthy meal delivery"}'
```

### Education
```bash
curl -X POST https://juozas.app.n8n.cloud/webhook/ceo \
  -H "Content-Type: application/json" \
  -d '{"idea": "Online coding bootcamp for career changers"}'
```

---

## Advanced Usage

### With Context

```bash
curl -X POST https://juozas.app.n8n.cloud/webhook/ceo \
  -H "Content-Type: application/json" \
  -d '{
    "idea": "Subscription coffee delivery",
    "context": {
      "budget": "low",
      "timeline": "fast",
      "legal_entity": "GmbH",
      "market": "germany"
    }
  }'
```

---

## Business Plan Structure

Every plan includes:

- **Executive Summary** - Business name, mission, goals
- **Market Analysis** - TAM/SAM/SOM, competition, trends
- **Business Model** - Revenue streams, pricing tiers
- **Product** - Features, tech stack, unique value
- **Legal (Germany)** - Entity type, permits, compliance
- **Financial** - Startup costs, projections, break-even
- **Marketing** - Channels, strategy, launch plan
- **Action Plan** - Week 1, Week 2, Month 1 tasks
- **Risks** - Market, operational, financial risks
- **Team** - Required roles, responsibilities

---

## Testing Script

Run comprehensive tests:

```bash
cd /root/Botiaga
./test-system.sh
```

---

## System Status

Check n8n workflows:
```bash
curl https://juozas.app.n8n.cloud/api/v1/workflows \
  -H "X-N8N-API-KEY: your-key"
```

---

## Performance

- **CEO Agent**: ~10-15 seconds, 800-1200 tokens
- **AI Brain**: ~5-8 seconds, 300-500 tokens
- **Memory**: Instant
- **History**: Instant

---

## Limitations

- OpenAI API rate limits apply
- Redis storage: 7 days TTL
- Max timeout: 90 seconds
- GPT-4o context: 4096 tokens max output

---

## Next Steps

1. Add Anthropic API credits for Claude Sonnet 4.5
2. Create web dashboard for results
3. Integrate GitHub for auto-repo creation
4. Add voice input (Azure Speech)
5. Deploy department agents to full pipeline
