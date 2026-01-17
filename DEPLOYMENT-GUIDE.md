# 🚀 Botiaga AI - Deployment Guide

**Complete setup instructions for activating all workflows**

---

## 📋 Prerequisites

Before deploying, ensure you have:

✅ n8n Cloud account (https://juozas.app.n8n.cloud)
✅ OpenAI API key with credits
✅ Upstash Redis database (for memory)
✅ Git repository access

---

## 🔧 Step 1: Setup API Keys

### 1.1 OpenAI API Key

1. Go to https://platform.openai.com/api-keys
2. Create new secret key
3. Copy the key (starts with `sk-proj-...`)
4. **Keep it safe** - you won't see it again

**Required for:**
- CEO Agent (business plans)
- AI Brain (quick analysis)
- POD Design Generator (DALL-E 3)
- Marketing Automation (GPT-4o)

### 1.2 Upstash Redis

1. Go to https://console.upstash.com
2. Create new Redis database
3. Copy connection string: `redis://default:password@host:port`

**Used for:**
- Business plan caching (7 days TTL)
- Session storage
- Memory system

---

## 📥 Step 2: Import Workflows to n8n

### Method 1: Manual Import (Recommended)

For each workflow file in `n8n-workflows/`:

1. Login to n8n: https://juozas.app.n8n.cloud
2. Click **"+"** → **"Import from file"**
3. Select workflow JSON file
4. Click **"Import"**
5. **Important:** Don't activate yet!

**Core Workflows (Priority Order):**
1. `core/ai-brain-workflow.json` - Quick analysis
2. `core/pod-design-generator.json` - Design generation
3. `agents/marketing-automation-agent.json` - Marketing campaigns
4. `core/business-factory-hub.json` - CEO Agent orchestrator
5. `agents/legal-agent.json` - Legal documents
6. `agents/finance-agent.json` - Financial planning
7. `agents/tech-agent.json` - Tech architecture
8. `agents/design-agent.json` - Brand design
9. `core/reflection-loop.json` - Quality assurance

### Method 2: API Import (Advanced)

```bash
# Set your n8n API key
N8N_API_KEY="your-n8n-api-key"
N8N_URL="https://juozas.app.n8n.cloud"

# Import all workflows
for file in n8n-workflows/**/*.json; do
  echo "Importing $file..."
  curl -X POST "$N8N_URL/api/v1/workflows" \
    -H "X-N8N-API-KEY: $N8N_API_KEY" \
    -H "Content-Type: application/json" \
    -d @"$file"
done
```

---

## 🔑 Step 3: Configure Credentials

### 3.1 OpenAI Credentials

For **each** imported workflow:

1. Open workflow in n8n editor
2. Find all nodes with `YOUR_OPENAI_API_KEY`
3. Replace with your actual OpenAI API key
4. Alternative: Create n8n credential:
   - Go to **Credentials** → **New**
   - Type: **HTTP Header Auth**
   - Header Name: `Authorization`
   - Header Value: `Bearer sk-proj-YOUR_KEY`
   - Save as: `OpenAI API Key`

**Workflows requiring OpenAI key:**
- `ai-brain-workflow.json` (GPT-4o)
- `pod-design-generator.json` (GPT-4o + DALL-E 3)
- `marketing-automation-agent.json` (GPT-4o)
- `business-factory-hub.json` (GPT-4o)

### 3.2 Upstash Redis (Optional)

For memory-enabled workflows:

1. Go to **Credentials** → **New**
2. Type: **Redis**
3. Enter Upstash details:
   - Host: `your-redis-host.upstash.io`
   - Port: `6379`
   - Password: `your-password`
   - Database: `0`
   - SSL: ✅ Enabled
4. Save as: `Upstash Redis`

---

## ✅ Step 4: Activate Workflows

### Activation Checklist

Before activating each workflow, verify:

- [ ] OpenAI API key is configured
- [ ] Webhook path is unique
- [ ] All nodes are properly connected
- [ ] Test with sample data

### Activate in Order:

```bash
# 1. Core functionality
ai-brain-workflow           → /webhook/ai-brain
pod-design-generator        → /webhook/pod-designs

# 2. Marketing automation
marketing-automation-agent  → /webhook/marketing-auto

# 3. CEO & Department Agents
business-factory-hub        → /webhook/ceo
legal-agent                 → /webhook/legal
finance-agent               → /webhook/finance
tech-agent                  → /webhook/tech
design-agent                → /webhook/design

# 4. Quality & Reflection
reflection-loop             → (called internally)
```

### Activation Steps:

1. Open workflow in n8n
2. Click **"Save"** (if you made changes)
3. Toggle **"Active"** switch (top right)
4. Verify **"Listening"** badge appears on webhook node
5. Copy webhook URL

---

## 🧪 Step 5: Test Endpoints

### Test 1: AI Brain (Quick Analysis)

```bash
curl -X POST https://juozas.app.n8n.cloud/webhook/ai-brain \
  -H "Content-Type: application/json" \
  -d '{"idea": "Coffee subscription for remote workers"}'
```

**Expected:** JSON response with business analysis (5-8 seconds)

### Test 2: POD Design Generator

```bash
curl -X POST https://juozas.app.n8n.cloud/webhook/pod-designs \
  -H "Content-Type: application/json" \
  -d '{
    "theme": "funny cats doing yoga",
    "count": 1,
    "style": "cartoon"
  }'
```

**Expected:** JSON with image_url from DALL-E 3 (10-15 seconds)

### Test 3: Marketing Automation

```bash
curl -X POST https://juozas.app.n8n.cloud/webhook/marketing-auto \
  -H "Content-Type: application/json" \
  -d '{
    "product_name": "Cat Yoga T-Shirt",
    "product_description": "Funny cat doing yoga poses",
    "image_url": "https://example.com/design.png",
    "target_audience": "cat lovers",
    "platforms": ["instagram", "facebook"]
  }'
```

**Expected:** Complete marketing package (10-15 seconds)

### Test 4: Complete POD Pipeline

```bash
# Run integration test
./test-pod-marketing-integration.sh
```

**Expected:** Both design and marketing working

---

## 🐛 Troubleshooting

### Issue: Webhook returns 404

**Cause:** Workflow not activated or webhook path wrong

**Fix:**
1. Check workflow is Active (green toggle)
2. Verify webhook node has "Listening" badge
3. Check webhook path in URL matches workflow

### Issue: "unauthorized" error

**Cause:** OpenAI API key missing or invalid

**Fix:**
1. Open workflow
2. Find HTTP Request node with OpenAI call
3. Check Authorization header: `Bearer sk-proj-...`
4. Verify API key is valid on OpenAI dashboard

### Issue: "Your credit balance is too low"

**Cause:** No OpenAI credits

**Fix:**
1. Go to https://platform.openai.com/account/billing
2. Add payment method
3. Purchase credits ($5 minimum)

### Issue: Design generation fails

**Cause:** DALL-E 3 prompt too long or invalid

**Fix:**
1. Check theme is descriptive but concise
2. Avoid requesting text in designs
3. Keep style parameter simple

### Issue: Marketing output incomplete

**Cause:** Response timeout or API rate limit

**Fix:**
1. Increase timeout in workflow settings
2. Check OpenAI rate limits: https://platform.openai.com/account/limits
3. Retry request after 1 minute

---

## 📊 Monitoring

### Check Workflow Executions

1. Go to n8n Dashboard
2. Click **"Executions"**
3. Filter by workflow name
4. Check success/failure status
5. View execution logs for errors

### API Usage Tracking

Monitor OpenAI costs:
1. Dashboard: https://platform.openai.com/usage
2. Expected costs per 1000 requests:
   - AI Brain: $2-3
   - Design Gen: $40-50 (DALL-E)
   - Marketing: $3-5
   - **Total:** ~$50/1000 products

---

## 🔒 Security Best Practices

### 1. Protect API Keys

- ✅ Use n8n credentials system
- ✅ Never commit API keys to git
- ❌ Don't share workflow JSON with keys
- ❌ Don't expose API keys in logs

### 2. Webhook Security

- Consider adding authentication to webhooks
- Use HTTPS only (n8n Cloud enforces this)
- Rate limit requests if public-facing

### 3. Data Privacy

- Don't store sensitive customer data
- Use session IDs, not personal info
- Set Redis TTL appropriately (7 days max)

---

## 📈 Scaling

### Current Limits (n8n Cloud Starter)

- Executions: 5,000/month
- Execution time: 5 minutes/workflow
- Active workflows: 20
- Storage: 50MB

### Scaling Options

**Option 1: n8n Cloud Pro ($20/month)**
- 10,000 executions/month
- 10 minute timeout
- 50 active workflows

**Option 2: Self-hosted n8n**
- Unlimited executions
- Full control
- Requires server management

---

## ✅ Post-Deployment Checklist

After everything is activated:

- [ ] All 9 core workflows activated
- [ ] OpenAI API keys configured
- [ ] Test endpoints responding
- [ ] Webhook URLs documented
- [ ] Monitor costs for 24 hours
- [ ] Run full integration test
- [ ] Update FINAL-SUMMARY.md with live endpoints

---

## 🚀 Going Live

### Production Readiness

Before launching to users:

1. **Load Testing:** Test with 10+ concurrent requests
2. **Error Handling:** Verify all error scenarios
3. **Documentation:** Update API docs with real examples
4. **Monitoring:** Setup alerts for failures
5. **Backup:** Export all workflows as JSON

### Recommended Launch Sequence

**Week 1:** Internal testing only
**Week 2:** Beta users (5-10 people)
**Week 3:** Public soft launch
**Week 4:** Full launch + marketing

---

## 📞 Support

If issues persist:

- **n8n Docs:** https://docs.n8n.io
- **OpenAI Docs:** https://platform.openai.com/docs
- **GitHub Issues:** https://github.com/Yo3o/Botiaga/issues
- **Email:** juozas@botiaga.com

---

**Deployment Time:** 1-2 hours
**Technical Level:** Intermediate
**Cost:** $5-10 initial setup

**Status after deployment:** 🟢 PRODUCTION READY
