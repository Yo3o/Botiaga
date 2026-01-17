# Setup Guide

## Prerequisites

- n8n Cloud account (https://juozas.app.n8n.cloud)
- OpenAI API key with GPT-4o access
- Upstash Redis account

## 1. n8n API Access

Get your n8n API key from Settings > API in n8n Cloud.

## 2. Import Workflows

### Option A: Via n8n UI
1. Go to n8n Dashboard
2. Click "Add Workflow"
3. Import JSON files from `n8n-workflows/` folder

### Option B: Via API
```bash
# Set your API key
export N8N_API_KEY="your-jwt-token"

# Import AI Brain workflow
curl -X POST https://juozas.app.n8n.cloud/api/v1/workflows \
  -H "X-N8N-API-KEY: $N8N_API_KEY" \
  -H "Content-Type: application/json" \
  -d @n8n-workflows/core/ai-brain-workflow.json
```

## 3. Configure Credentials

In n8n, create these credentials:

### OpenAI API
- Type: Header Auth
- Name: `x-api-key`
- Value: Your OpenAI key

### Upstash Redis
- URL: `https://huge-satyr-36763.upstash.io`
- Token: Your Upstash REST token

## 4. Activate Workflows

1. Open each workflow in n8n
2. Click the toggle to activate
3. Test with the webhook URLs

## 5. Test the System

```bash
# Test AI Brain
curl -X POST https://juozas.app.n8n.cloud/webhook/ai-brain \
  -H "Content-Type: application/json" \
  -d '{"idea": "Mobile app for tracking water intake"}'

# Expected response: Full business plan JSON
```

## Troubleshooting

### Webhook returns 404
- Ensure workflow is active
- Check webhook path matches
- Try deactivating and reactivating

### OpenAI errors
- Verify API key is valid
- Check you have GPT-4o access
- Monitor usage limits

### Redis connection issues
- Verify Upstash credentials
- Check REST URL format
- Test with Upstash dashboard

## n8n Workflow IDs

| Workflow | ID |
|----------|-----|
| AI Brain | UJvLJ4NHpzMvgdYH |
| Business Factory Hub | vPN7cD6LMdfQuRHT |
| Legal Agent | YU2FxHKlSfQD645v |
| Finance Agent | oxbrXIRbF22cvkP1 |
| Tech Agent | 1Xc5zV5ec8AqjtOw |
| Design Agent | 1lSJStgjOdel3EiN |
| Marketing Agent | ix2mu2MclaNzr0w9 |
| Reflection Loop | siIdlZdltXVKuREW |
| Human Approval | duClzlTT7jqNWLAw |
| Agent Memory | FU40Ti3yaj0VwihC |
| Business History API | 85fIbwUoFOnBvxoj |
