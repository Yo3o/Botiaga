# 📥 Workflow Import Guide - Step by Step

**Time required:** 10-15 minutes
**Prerequisites:** n8n Cloud account access

---

## 🎯 What You're Importing

4 workflows that create a complete POD automation system:

1. **pod-design-generator.json** - DALL-E 3 powered design creation
2. **marketing-automation-agent.json** - Social media & ad content generation
3. **shopify-integration-agent.json** - Automated Shopify product upload
4. **complete-pod-orchestrator.json** - End-to-end pipeline orchestrator

---

## 📋 Step-by-Step Import Process

### Step 1: Access Activated Workflows

The workflows with your real OpenAI API key are ready in:
```
/tmp/botiaga-activated-workflows/
```

Files:
- `pod-design-generator.json`
- `marketing-automation-agent.json`
- `shopify-integration-agent.json`
- `complete-pod-orchestrator.json`

### Step 2: Login to n8n Cloud

1. Open browser
2. Go to: **https://juozas.app.n8n.cloud**
3. Login with your credentials

### Step 3: Import First Workflow (Design Generator)

1. Click **"+" button** (top left) → **"Import from file"**
2. Navigate to: `/tmp/botiaga-activated-workflows/`
3. Select: **`pod-design-generator.json`**
4. Click **"Import"**
5. Review the workflow nodes (should see webhook, GPT-4o nodes)
6. Click **"Save"** (top right)
7. **IMPORTANT:** Toggle the workflow to **"Active"** (top right switch)
8. Verify webhook status shows **"Listening"**
9. Note the webhook URL: `https://juozas.app.n8n.cloud/webhook/pod-designs`

### Step 4: Import Second Workflow (Marketing Automation)

Repeat Step 3 for: **`marketing-automation-agent.json`**

Expected:
- Webhook path: `/webhook/marketing-auto`
- Should see GPT-4o node for content generation
- Multiple formatting nodes for Instagram, Facebook, Email, Ads

### Step 5: Import Third Workflow (Shopify Integration)

Repeat Step 3 for: **`shopify-integration-agent.json`**

Expected:
- Webhook path: `/webhook/shopify-upload`
- Shopify API nodes will show placeholders: `CONFIGURE_IN_N8N`
- This is NORMAL - you can configure Shopify later

**Note:** This workflow will work for testing but needs Shopify credentials for real product uploads.

### Step 6: Import Fourth Workflow (Complete Pipeline)

Repeat Step 3 for: **`complete-pod-orchestrator.json`**

Expected:
- Webhook path: `/webhook/pod-complete`
- Should see HTTP Request nodes calling the 3 previous workflows
- Orchestrates: Design → Marketing → Shopify in sequence

---

## ✅ Verification Checklist

After importing all 4 workflows, verify:

- [ ] All 4 workflows show as **"Active"** (green toggle)
- [ ] All webhooks show **"Listening"** status
- [ ] Webhook URLs are accessible:
  - `https://juozas.app.n8n.cloud/webhook/pod-designs`
  - `https://juozas.app.n8n.cloud/webhook/marketing-auto`
  - `https://juozas.app.n8n.cloud/webhook/shopify-upload`
  - `https://juozas.app.n8n.cloud/webhook/pod-complete`

---

## 🧪 Testing After Import

Run the automated test script:

```bash
./test-activated-workflows.sh
```

This will:
1. Test each workflow endpoint
2. Verify responses
3. Save results to `/tmp/botiaga-test-results/`
4. Give you a summary of what's working

Expected output:
```
✅ Design Generator: WORKING
✅ Marketing Agent: WORKING
⚠️  Shopify Integration: NEEDS CREDENTIALS (optional)
✅ Complete Pipeline: WORKING
```

---

## 🔧 Manual Testing (Alternative)

If you prefer to test manually:

### Test 1: Design Generator

```bash
curl -X POST https://juozas.app.n8n.cloud/webhook/pod-designs \
  -H 'Content-Type: application/json' \
  -d '{
    "theme": "funny cat doing yoga",
    "count": 1,
    "style": "cartoon"
  }'
```

**Expected response:** JSON with `image_url`, `design_id`, `prompt`

### Test 2: Marketing Automation

```bash
curl -X POST https://juozas.app.n8n.cloud/webhook/marketing-auto \
  -H 'Content-Type: application/json' \
  -d '{
    "product_name": "Cat Yoga T-Shirt",
    "product_description": "Funny cat design",
    "image_url": "https://example.com/image.png",
    "target_audience": "cat lovers"
  }'
```

**Expected response:** JSON with `marketing_package` containing Instagram, Facebook, Email, Ads content

### Test 3: Complete Pipeline

```bash
curl -X POST https://juozas.app.n8n.cloud/webhook/pod-complete \
  -H 'Content-Type: application/json' \
  -d '{
    "theme": "retro gaming",
    "product_name": "Gaming T-Shirt",
    "count": 1,
    "price": 29.99
  }'
```

**Expected response:** Complete results from all 3 workflows (Design → Marketing → Shopify)

---

## ⚠️ Troubleshooting

### Issue: "Workflow is not active"

**Solution:** Click the workflow name → Toggle "Active" switch (top right)

### Issue: "Webhook not found"

**Cause:** Workflow not saved or not active

**Solution:**
1. Open the workflow
2. Click "Save"
3. Toggle "Active"
4. Refresh the page

### Issue: "Invalid API key" or "OpenAI error"

**Cause:** API key not properly injected

**Solution:**
1. Check `activate-workflows.sh` was run with correct `OPENAI_API_KEY`
2. Re-run activation script
3. Re-import the workflow

### Issue: Shopify errors

**This is NORMAL** - Shopify integration requires additional setup:
1. Create Shopify store
2. Get Admin API access token
3. Update `shopify-integration-agent` workflow
4. See: [SHOPIFY-INTEGRATION-GUIDE.md](SHOPIFY-INTEGRATION-GUIDE.md)

---

## 📊 What Happens After Successful Import

Your POD automation system will be **95% operational**:

✅ **Design Generation**
- Endpoint: `POST /webhook/pod-designs`
- Creates DALL-E 3 images
- Time: 10-15 seconds
- Cost: $0.04/design

✅ **Marketing Content**
- Endpoint: `POST /webhook/marketing-auto`
- Generates Instagram, Facebook, Email, Ads
- Time: 10-15 seconds
- Cost: $0.03/campaign

⚠️ **Shopify Upload** (needs credentials)
- Endpoint: `POST /webhook/shopify-upload`
- Uploads products to Shopify
- Time: 15-20 seconds
- Requires: Shopify + Printful API keys

✅ **Complete Pipeline**
- Endpoint: `POST /webhook/pod-complete`
- Runs all 3 agents in sequence
- Time: 35-45 seconds total
- Cost: $0.07/product

---

## 🎯 Next Steps After Import

### Immediate (Today):

1. **Test design generation**
   - Generate 5-10 test designs
   - Review quality
   - Save favorite prompts

2. **Test marketing content**
   - Generate campaigns for test products
   - Review Instagram/Facebook copy
   - Adjust target audiences

### Short-term (This Week):

3. **Configure Shopify** (optional)
   - Create Shopify store
   - Get API credentials
   - Update workflow
   - Test product upload

4. **Production testing**
   - Generate 20 real product designs
   - Create marketing campaigns
   - (If Shopify configured) Upload products

### Long-term (This Month):

5. **Launch POD store**
   - Publish products
   - Start marketing campaigns
   - Begin selling
   - Monitor performance

---

## 💰 Cost Monitoring

After activation, monitor your OpenAI API usage:

**Typical costs per 100 products:**
- Design generation (100 × $0.04) = **$4.00**
- Marketing content (100 × $0.03) = **$3.00**
- **Total: $7.00 for 100 complete products**

**Revenue potential:**
- 100 products × 10% conversion × €7 profit = **€70**
- Net profit: **€65** (93% margin)

---

## 📞 Support

If you encounter issues during import:

1. **Check n8n execution logs** - Click workflow → "Executions" tab
2. **Review documentation** - See other guides in `/root/Botiaga/`
3. **Test with curl** - Manual endpoint testing
4. **Check API quotas** - OpenAI dashboard

---

## 🎉 Success Criteria

Import is successful when:

✅ All 4 workflows show "Active" status
✅ Test script returns "SUCCESS - Core workflows are active!"
✅ Design generation returns valid image URLs
✅ Marketing content returns complete campaigns
✅ You can generate 10 products without errors

**You are now ready to automate your POD business!**

---

**Version:** 1.0.0
**Last Updated:** 2026-01-17
**Time to Complete:** 10-15 minutes
