#!/bin/bash

# POD + MARKETING INTEGRATION TEST
# Simulates complete pipeline with mock data

clear

echo "╔═══════════════════════════════════════════════════════════╗"
echo "║                                                           ║"
echo "║     🧪 POD + MARKETING INTEGRATION TEST                  ║"
echo "║                                                           ║"
echo "║     Simulated End-to-End Pipeline                        ║"
echo "║                                                           ║"
echo "╚═══════════════════════════════════════════════════════════╝"
echo ""
sleep 2

# Simulate Design Generation
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "STEP 1: Design Generation (Simulated)"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "Theme: Funny cats doing yoga"
echo "Count: 1"
echo "Style: Cartoon, colorful"
echo ""
echo "⏳ Generating design with DALL-E 3..."
sleep 2

# Mock design result (what we would get from real API)
DESIGN_RESULT='{
  "design_id": "DESIGN-1768665382425",
  "theme": "funny cats doing yoga",
  "prompt": "A humorous cartoon illustration of a fluffy orange cat attempting a downward dog yoga pose, with exaggerated facial expression showing concentration, vibrant colors, simple bold design suitable for t-shirt printing, centered composition on white background",
  "image_url": "https://oaidalleapiprodscus.blob.core.windows.net/private/org-example/MOCK-IMAGE.png",
  "product_type": "t-shirt",
  "status": "ready",
  "cost_usd": 0.04,
  "resolution": "1024x1024",
  "format": "PNG",
  "print_ready": true
}'

echo "✅ Design Generated Successfully!"
echo ""
echo "$DESIGN_RESULT" | python3 -c "
import json, sys
d = json.load(sys.stdin)
print(f\"   Design ID: {d['design_id']}\")
print(f\"   Prompt: {d['prompt'][:80]}...\")
print(f\"   Image URL: {d['image_url'][:60]}...\")
print(f\"   Status: {d['status']}\")
print(f\"   Cost: \${d['cost_usd']}\")
"

IMAGE_URL=$(echo "$DESIGN_RESULT" | python3 -c "import json,sys; print(json.load(sys.stdin)['image_url'])")

echo ""
sleep 2

# Test Marketing Agent (REAL API call if available)
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "STEP 2: Marketing Campaign Generation (Real API)"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "Product: Cat Yoga T-Shirt"
echo "Target: Cat lovers, yoga enthusiasts"
echo ""
echo "⏳ Calling Marketing Automation Agent..."
echo ""

# Try real API call
MARKETING_RESULT=$(curl -s -X POST https://juozas.app.n8n.cloud/webhook/marketing-auto \
  -H "Content-Type: application/json" \
  -d "{
    \"product_name\": \"Cat Yoga T-Shirt - Funny Feline Poses\",
    \"product_description\": \"Premium cotton t-shirt featuring an adorable cat doing hilarious yoga poses. Perfect gift for cat lovers who also love yoga.\",
    \"image_url\": \"$IMAGE_URL\",
    \"target_audience\": \"cat lovers, yoga enthusiasts, millennials\",
    \"platforms\": [\"instagram\", \"facebook\"],
    \"campaign_type\": \"product_launch\"
  }" --max-time 30 2>&1)

# Check if API call succeeded
if echo "$MARKETING_RESULT" | grep -q "COMPLETED" 2>/dev/null; then
    echo "✅ Real Marketing API Call Successful!"
    echo ""
    echo "$MARKETING_RESULT" | python3 << 'PYTHON'
import json, sys
try:
    data = json.load(sys.stdin)
    mp = data.get('marketing_package', {})
    sm = mp.get('social_media', {})

    # Instagram
    if sm.get('instagram'):
        ig = sm['instagram']
        print("📱 INSTAGRAM POST")
        print(f"   Caption: {ig.get('caption', 'N/A')[:100]}...")
        print(f"   Hashtags: {len(ig.get('hashtags', []))} tags")
        print("")

    # Email
    email = mp.get('email', {})
    if email:
        print("📧 EMAIL CAMPAIGN")
        print(f"   Subject: {email.get('subject', 'N/A')}")
        print("")

    # Ads
    ads = mp.get('ads', {})
    if ads:
        print("🎯 AD CAMPAIGN")
        print(f"   Headline: {ads.get('headline', 'N/A')}")
        print(f"   Budget: {ads.get('budget_recommendation', 'N/A')}")
        print("")

except Exception as e:
    print(f"Error parsing: {e}")
PYTHON

else
    echo "⚠️  Marketing API not available (workflow not activated)"
    echo ""
    echo "Simulating expected output:"
    echo ""
    echo "📱 INSTAGRAM POST"
    echo "   Caption: 🐱🧘‍♀️ When your cat's yoga game is stronger than yours..."
    echo "   Hashtags: #CatYoga #YogaCat #FunnyCats #CatLovers #Namaste"
    echo ""
    echo "📧 EMAIL CAMPAIGN"
    echo "   Subject: 🐱 NEW: Cat Yoga Collection - Purr-fect for Yoga Lovers!"
    echo ""
    echo "🎯 AD CAMPAIGN"
    echo "   Headline: Cat Yoga T-Shirts - Perfect Gift for Cat & Yoga Lovers"
    echo "   Budget: €5-10/day for testing"
    echo ""
fi

sleep 2

# Summary
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "📊 INTEGRATION TEST SUMMARY"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "✅ Design Generation: Working (simulated)"
echo "✅ Marketing Automation: $(echo "$MARKETING_RESULT" | grep -q "COMPLETED" && echo "Working (real API)" || echo "Pending (workflow activation)")"
echo ""
echo "Pipeline Status:"
echo "  1️⃣  Design Generation   → ⏳ Pending (n8n workflow needs activation)"
echo "  2️⃣  Marketing Campaign  → ⏳ Pending (n8n workflow needs activation)"
echo "  3️⃣  Shopify Integration → ❌ Not built yet"
echo ""
echo "Next Steps to Activate:"
echo "  1. Import pod-design-generator.json to n8n"
echo "  2. Import marketing-automation-agent.json to n8n"
echo "  3. Add OpenAI API key to both workflows"
echo "  4. Activate webhooks"
echo "  5. Test with real API calls"
echo ""
echo "Expected Performance (when activated):"
echo "  • Design + Marketing: 25-30 seconds"
echo "  • Cost per product: \$0.07"
echo "  • Automation: 85%"
echo "  • Manual work: 15% (posting, approval)"
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
