# Botiaga - AI Business Factory

**Enterprise-level Multi-Agent System** that autonomously creates businesses from idea to working product.

## Architecture

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                          HUMAN OVERSIGHT LAYER                               │
│  • Approval webhooks • Decision logging • Risk alerts • Override capability  │
└──────────────────────────────────┬──────────────────────────────────────────┘
                                   │
┌──────────────────────────────────▼──────────────────────────────────────────┐
│                    🧠 CEO AGENT (Master Orchestrator)                        │
│  Webhook: POST /business-factory                                            │
│  • GPT-4o powered analysis                                                   │
│  • Domain & complexity detection                                             │
│  • Risk assessment                                                           │
│  • Department orchestration                                                  │
└───────┬─────────────┬─────────────┬─────────────┬─────────────┬────────────┘
        │             │             │             │             │
   ┌────▼────┐   ┌────▼────┐   ┌────▼────┐   ┌────▼────┐   ┌────▼────┐
   │ LEGAL   │   │FINANCE  │   │  TECH   │   │  DESIGN  │   │MARKETING│
   │ AGENT   │   │ AGENT   │   │  AGENT  │   │  AGENT  │   │  AGENT  │
   └─────────┘   └─────────┘   └─────────┘   └─────────┘   └─────────┘
```

## Working Endpoints

### 1. CEO Agent - Business Plan Generator
```bash
curl -X POST https://juozas.app.n8n.cloud/webhook/ceo \
  -H "Content-Type: application/json" \
  -d '{"idea": "AI-powered meal planning app for busy professionals"}'
```

### 2. AI Brain - Quick Analysis
```bash
curl -X POST https://juozas.app.n8n.cloud/webhook/ai-brain \
  -H "Content-Type: application/json" \
  -d '{"idea": "Coffee subscription service for remote workers"}'
```

### 3. POD Design Generator - DALL-E 3
```bash
curl -X POST https://juozas.app.n8n.cloud/webhook/pod-designs \
  -H "Content-Type: application/json" \
  -d '{
    "theme": "funny cats doing yoga",
    "count": 5,
    "style": "cartoon"
  }'
```

### 4. Marketing Automation - Complete Campaigns
```bash
curl -X POST https://juozas.app.n8n.cloud/webhook/marketing-auto \
  -H "Content-Type: application/json" \
  -d '{
    "product_name": "Cat Yoga T-Shirt",
    "product_description": "Premium cotton t-shirt with funny cat yoga designs",
    "image_url": "https://your-design.png",
    "target_audience": "cat lovers, yoga enthusiasts",
    "platforms": ["instagram", "facebook"]
  }'
```

### 5. Memory & History
```bash
# Get all business history
curl -X GET https://juozas.app.n8n.cloud/webhook/business-history

# Get specific business plan
curl -X POST https://juozas.app.n8n.cloud/webhook/business-plan \
  -H "Content-Type: application/json" \
  -d '{"session_id": "BIZ-1768665382425"}'
```

## Workflows

### Core Workflows (`n8n-workflows/core/`)
| File | Description | n8n ID |
|------|-------------|--------|
| `ai-brain-workflow.json` | GPT-4o business analyzer | UJvLJ4NHpzMvgdYH |
| `business-factory-hub.json` | Main orchestrator | vPN7cD6LMdfQuRHT |
| `reflection-loop.json` | Quality assurance loop | siIdlZdltXVKuREW |
| `human-approval.json` | Human-in-the-loop decisions | duClzlTT7jqNWLAw |

### Agent Workflows (`n8n-workflows/agents/`)
| File | Description | n8n ID |
|------|-------------|--------|
| `legal-agent.json` | German legal & compliance | YU2FxHKlSfQD645v |
| `finance-agent.json` | Financial planning & Stripe | oxbrXIRbF22cvkP1 |
| `tech-agent.json` | Architecture & stack | 1Xc5zV5ec8AqjtOw |
| `design-agent.json` | Brand & UI/UX | 1lSJStgjOdel3EiN |
| `marketing-agent.json` | Launch strategy | ix2mu2MclaNzr0w9 |

## Memory System

- **Upstash Redis** - Session storage and business plan caching
- **Business History API** - Retrieve past analyses

## 🎯 Features

✅ **Business Planning** - Complete investor-ready plans in 10-15 seconds
✅ **Design Generation** - AI-powered designs with DALL-E 3 ($0.04/design)
✅ **Marketing Automation** - Instagram, Facebook, Email, Ads (85% automated)
✅ **Print-on-Demand** - 90% automated POD business setup
✅ **Memory System** - Redis-based conversation and business plan storage

## 📊 Use Cases

### ✅ Working Now
1. **Business Idea Validation** - Full analysis in 15 seconds
2. **Business Plan Generation** - 10-section comprehensive plans
3. **POD Store Launch** - Design + Marketing automation
4. **Social Media Marketing** - Auto-generated campaigns
5. **Market Research** - Automated competitor & market analysis

### 🔨 In Development
1. Shopify API integration (automated product upload)
2. Direct social media posting (Instagram/Facebook APIs)
3. Email automation (ConvertKit/Mailchimp)
4. Web dashboard for visualization

## 💰 Cost Efficiency

| Service | Cost | Value |
|---------|------|-------|
| CEO Agent (Business Plan) | $0.02 | €500-1,000 consulting value |
| DALL-E Design | $0.04 | €50-200 designer cost |
| Marketing Campaign | $0.03 | €300-500 agency cost |
| **Total per product** | **$0.09** | **€850-1,700 value** |

**ROI:** 9,400% - 18,900%

## Tech Stack

- **n8n Cloud** - Workflow automation platform
- **OpenAI GPT-4o** - Primary AI engine for analysis
- **DALL-E 3** - AI image generation
- **Upstash Redis** - Serverless memory & caching
- **Anthropic Claude** - Ready (pending credits)

## API Keys Required

Create credentials in n8n for:
- OpenAI API
- Upstash Redis
- GitHub (for code generation)
- Azure Speech (for voice input)

## 📚 Documentation

| Document | Description |
|----------|-------------|
| [API-REFERENCE.md](API-REFERENCE.md) | Complete API documentation |
| [EXAMPLES.md](EXAMPLES.md) | Usage examples & code samples |
| [POD-AUTOMATION-GUIDE.md](POD-AUTOMATION-GUIDE.md) | Print-on-Demand complete guide |
| [POD-QUICK-START.md](POD-QUICK-START.md) | 30-minute POD launch |
| [MARKETING-AUTOMATION-GUIDE.md](MARKETING-AUTOMATION-GUIDE.md) | Marketing automation docs |
| [TOP-5-FAST-REVENUE-BUSINESSES.md](TOP-5-FAST-REVENUE-BUSINESSES.md) | Business analysis |
| [GERMAN-COMPANY-FORMATION-GUIDE.md](GERMAN-COMPANY-FORMATION-GUIDE.md) | Legal setup guide |

## 🧪 Testing

```bash
# Run complete system test
./test-system.sh

# Demo POD + Marketing pipeline
./demo-marketing-automation.sh

# Client demo (business planning)
./demo-for-clients.sh
```

## 🚀 Quick Start

### 1. Generate Business Plan
```bash
curl -X POST https://juozas.app.n8n.cloud/webhook/ceo \
  -H "Content-Type: application/json" \
  -d '{"idea": "Your business idea here"}'
```

### 2. Launch POD Store (Complete Pipeline)
```bash
# Generate design
curl -X POST https://juozas.app.n8n.cloud/webhook/pod-designs \
  -d '{"theme": "funny cats", "count": 10}' > designs.json

# Generate marketing for each design
cat designs.json | jq -r '.[] | @json' | while read design; do
  IMAGE_URL=$(echo "$design" | jq -r '.image_url')
  curl -X POST https://juozas.app.n8n.cloud/webhook/marketing-auto \
    -d "{\"product_name\": \"Cat T-Shirt\", \"image_url\": \"$IMAGE_URL\"}"
done
```

## 📈 Performance

- **Business Plan:** 10-15 seconds (800-1,200 tokens)
- **Quick Analysis:** 5-8 seconds (300-500 tokens)
- **Design Generation:** 10-15 seconds per design
- **Marketing Campaign:** 10-15 seconds
- **Complete POD Product:** 25-30 seconds (design + marketing)

## 🔒 Security

- All API keys stored in n8n credentials (encrypted)
- GitHub secret scanning compliance
- No sensitive data in repository
- HTTPS-only communication
- Session-based isolation

## Development

```bash
# Import workflow to n8n
curl -X POST https://juozas.app.n8n.cloud/api/v1/workflows \
  -H "X-N8N-API-KEY: YOUR_API_KEY" \
  -H "Content-Type: application/json" \
  -d @n8n-workflows/core/ai-brain-workflow.json
```

## 📞 Support

- **GitHub Issues:** https://github.com/Yo3o/Botiaga/issues
- **Documentation:** Full guides in `/docs`
- **Email:** juozas@botiaga.com

## License

Private - Juozas Kaziukenas

---

**Version:** 1.1.0
**Status:** 🟢 Production Ready
**Automation Level:** 85-90%
**Last Updated:** 2026-01-17
