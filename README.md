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

### AI Brain (GPT-4o Powered)
```bash
curl -X POST https://juozas.app.n8n.cloud/webhook/ai-brain \
  -H "Content-Type: application/json" \
  -d '{"idea": "Coffee subscription service for remote workers"}'
```

### Business Factory Hub
```bash
curl -X POST https://juozas.app.n8n.cloud/webhook/business-factory \
  -H "Content-Type: application/json" \
  -d '{
    "idea": "SaaS for freelancers",
    "context": { "budget": "moderate", "timeline": "standard" }
  }'
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

## Tech Stack

- **n8n Cloud** - Workflow automation
- **OpenAI GPT-4o** - AI analysis engine
- **Upstash Redis** - Serverless memory
- **Anthropic Claude** - (Pending credits)

## API Keys Required

Create credentials in n8n for:
- OpenAI API
- Upstash Redis
- GitHub (for code generation)
- Azure Speech (for voice input)

## Development

```bash
# Import workflow to n8n
curl -X POST https://juozas.app.n8n.cloud/api/v1/workflows \
  -H "X-N8N-API-KEY: YOUR_API_KEY" \
  -H "Content-Type: application/json" \
  -d @n8n-workflows/core/ai-brain-workflow.json
```

## License

Private - Juozas Kaziukenas
