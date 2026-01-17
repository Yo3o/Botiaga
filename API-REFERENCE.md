# Botiaga AI - API Reference

## Base URL
```
https://juozas.app.n8n.cloud/webhook
```

---

## Endpoints

### 1. CEO Agent - Full Business Plan

**Endpoint:** `POST /ceo`

**Request:**
```json
{
  "idea": "Your business idea description",
  "context": {
    "budget": "low|moderate|high",
    "timeline": "fast|standard|thorough",
    "legal_entity": "GmbH|UG|Einzelunternehmen",
    "market": "germany|eu|global"
  }
}
```

**Response:**
```json
{
  "session_id": "BIZ-1768665382425",
  "status": "COMPLETED",
  "tokens": 1042,
  "idea": "Your business idea",
  "business_plan": {
    "executive_summary": {...},
    "market_analysis": {...},
    "business_model": {...},
    "product": {...},
    "legal_germany": {...},
    "financial": {...},
    "marketing": {...},
    "action_plan": {...},
    "risks": [...],
    "team": {...}
  }
}
```

**Example:**
```bash
curl -X POST https://juozas.app.n8n.cloud/webhook/ceo \
  -H "Content-Type: application/json" \
  -d '{"idea": "Sustainable fashion e-commerce for Lithuania"}'
```

**Performance:** 10-15 seconds | 800-1200 tokens

---

### 2. AI Brain - Quick Analysis

**Endpoint:** `POST /ai-brain`

**Request:**
```json
{
  "idea": "Business idea"
}
```

**Response:**
```json
{
  "session_id": "BIZ-...",
  "status": "COMPLETED",
  "ai_model": "gpt-4o",
  "analysis": {
    "domain": "ecommerce|saas|fintech|...",
    "complexity": "low|medium|high",
    "market_size": "Description",
    "competition": "Description",
    "unique_value": "Description"
  },
  "business_plan": {...},
  "decision": "GO|NEEDS_REFINEMENT|HIGH_RISK"
}
```

**Example:**
```bash
curl -X POST https://juozas.app.n8n.cloud/webhook/ai-brain \
  -H "Content-Type: application/json" \
  -d '{"idea": "AI language learning app"}'
```

**Performance:** 5-8 seconds | 300-500 tokens

---

### 3. Business History

**Endpoint:** `GET /business-history`

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

**Example:**
```bash
curl -X GET https://juozas.app.n8n.cloud/webhook/business-history
```

---

### 4. Get Business Plan by ID

**Endpoint:** `POST /business-plan`

**Request:**
```json
{
  "session_id": "BIZ-1768665382425"
}
```

**Response:**
```json
{
  "session_id": "BIZ-1768665382425",
  "status": "COMPLETED",
  "idea": "...",
  "business_plan": {...}
}
```

**Example:**
```bash
curl -X POST https://juozas.app.n8n.cloud/webhook/business-plan \
  -H "Content-Type: application/json" \
  -d '{"session_id": "BIZ-1768665382425"}'
```

---

### 5. Memory System

**Endpoint:** `POST /memory`

**Request:**
```json
{
  "action": "set|get|delete",
  "key": "your-key",
  "value": "your-value"
}
```

**Example:**
```bash
curl -X POST https://juozas.app.n8n.cloud/webhook/memory \
  -H "Content-Type: application/json" \
  -d '{"action": "set", "key": "test", "value": "hello"}'
```

---

## Rate Limits

- **OpenAI API:** Subject to your OpenAI account limits
- **n8n Cloud:** No enforced limits currently
- **Recommended:** Max 10 requests/minute for optimal performance

---

## Response Codes

- **200** - Success
- **400** - Bad Request (invalid JSON)
- **404** - Webhook not found
- **500** - Server error
- **504** - Timeout (>90s)

---

## Data Retention

- **Redis Storage:** 7 days (604800 seconds)
- **Business History:** Last 100 sessions
- **Session ID Format:** `BIZ-{timestamp}`

---

## Error Handling

```json
{
  "error": true,
  "message": "Error description",
  "session_id": "BIZ-..."
}
```

---

## Best Practices

1. **Be Specific:** More detailed ideas = better plans
2. **Use Context:** Add budget/timeline for tailored advice
3. **Store Session IDs:** Retrieve plans later
4. **Timeout:** Set client timeout to 120s
5. **Retry Logic:** Implement exponential backoff

---

## SDKs & Libraries

### JavaScript/Node.js
```javascript
const response = await fetch('https://juozas.app.n8n.cloud/webhook/ceo', {
  method: 'POST',
  headers: { 'Content-Type': 'application/json' },
  body: JSON.stringify({ idea: 'Your business idea' })
});

const data = await response.json();
console.log(data.business_plan);
```

### Python
```python
import requests

response = requests.post(
    'https://juozas.app.n8n.cloud/webhook/ceo',
    json={'idea': 'Your business idea'}
)

data = response.json()
print(data['business_plan'])
```

### cURL
```bash
curl -X POST https://juozas.app.n8n.cloud/webhook/ceo \
  -H "Content-Type: application/json" \
  -d '{"idea": "Your business idea"}' \
  | jq .
```

---

## Support

- **Issues:** https://github.com/Yo3o/Botiaga/issues
- **Email:** juozas@botiaga.com
- **Documentation:** /root/Botiaga/README.md

---

**Version:** 1.0.0
**Last Updated:** 2026-01-17
