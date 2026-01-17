#!/bin/bash

# BOTIAGA POD WORKFLOWS - POST-ACTIVATION TESTING
# Run this script AFTER importing workflows to n8n Cloud

set -e

echo "╔══════════════════════════════════════════════════════════════╗"
echo "║                                                              ║"
echo "║       🧪 BOTIAGA WORKFLOW ACTIVATION TESTS                  ║"
echo "║                                                              ║"
echo "╚══════════════════════════════════════════════════════════════╝"
echo ""

N8N_URL="https://juozas.app.n8n.cloud"
RESULTS_DIR="/tmp/botiaga-test-results"
mkdir -p "$RESULTS_DIR"

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "📋 PRE-FLIGHT CHECKS"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Check if n8n is accessible
echo "1. Checking n8n Cloud accessibility..."
if curl -s --head "$N8N_URL" | grep "200\|301\|302" > /dev/null; then
    echo "   ✅ n8n Cloud is accessible"
else
    echo "   ❌ n8n Cloud is not accessible"
    echo "   Please check your internet connection"
    exit 1
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🧪 TEST 1: POD Design Generator"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

echo "Sending test request to /webhook/pod-designs..."
echo ""

DESIGN_RESPONSE=$(curl -s -X POST "$N8N_URL/webhook/pod-designs" \
  -H 'Content-Type: application/json' \
  -d '{
    "theme": "funny cat doing yoga",
    "count": 1,
    "style": "cartoon, vibrant colors"
  }' 2>&1)

echo "$DESIGN_RESPONSE" > "$RESULTS_DIR/design-test.json"

if echo "$DESIGN_RESPONSE" | grep -q "image_url\|design_id"; then
    echo "✅ Design Generator: WORKING"
    echo "   Response saved to: $RESULTS_DIR/design-test.json"
    DESIGN_URL=$(echo "$DESIGN_RESPONSE" | jq -r '.[0].image_url // "NOT_FOUND"')
    echo "   Design URL: $DESIGN_URL"
    DESIGN_WORKING=true
elif echo "$DESIGN_RESPONSE" | grep -q "404\|Workflow is not active"; then
    echo "❌ Design Generator: NOT ACTIVE"
    echo "   Please activate 'pod-design-generator' workflow in n8n"
    DESIGN_WORKING=false
else
    echo "⚠️  Design Generator: UNKNOWN RESPONSE"
    echo "   Response: $DESIGN_RESPONSE"
    DESIGN_WORKING=false
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🧪 TEST 2: Marketing Automation Agent"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

echo "Sending test request to /webhook/marketing-auto..."
echo ""

MARKETING_RESPONSE=$(curl -s -X POST "$N8N_URL/webhook/marketing-auto" \
  -H 'Content-Type: application/json' \
  -d '{
    "product_name": "Cat Yoga T-Shirt",
    "product_description": "Hilarious t-shirt featuring a cat attempting yoga poses",
    "image_url": "https://via.placeholder.com/1024",
    "target_audience": "cat lovers, yoga enthusiasts",
    "platforms": ["instagram", "facebook"]
  }' 2>&1)

echo "$MARKETING_RESPONSE" > "$RESULTS_DIR/marketing-test.json"

if echo "$MARKETING_RESPONSE" | grep -q "marketing_package\|session_id"; then
    echo "✅ Marketing Agent: WORKING"
    echo "   Response saved to: $RESULTS_DIR/marketing-test.json"
    echo "   Generated content for platforms: Instagram, Facebook, Email, Ads"
    MARKETING_WORKING=true
elif echo "$MARKETING_RESPONSE" | grep -q "404\|Workflow is not active"; then
    echo "❌ Marketing Agent: NOT ACTIVE"
    echo "   Please activate 'marketing-automation-agent' workflow in n8n"
    MARKETING_WORKING=false
else
    echo "⚠️  Marketing Agent: UNKNOWN RESPONSE"
    echo "   Response: $MARKETING_RESPONSE"
    MARKETING_WORKING=false
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🧪 TEST 3: Shopify Integration Agent"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

echo "Sending test request to /webhook/shopify-upload..."
echo ""

SHOPIFY_RESPONSE=$(curl -s -X POST "$N8N_URL/webhook/shopify-upload" \
  -H 'Content-Type: application/json' \
  -d '{
    "product_name": "TEST Cat Yoga T-Shirt",
    "product_description": "Test product - do not publish",
    "design_url": "https://via.placeholder.com/1024",
    "price": 29.99,
    "shopify_store": "test-store.myshopify.com"
  }' 2>&1)

echo "$SHOPIFY_RESPONSE" > "$RESULTS_DIR/shopify-test.json"

if echo "$SHOPIFY_RESPONSE" | grep -q "shopify\|product_id"; then
    echo "✅ Shopify Integration: WORKING"
    echo "   Response saved to: $RESULTS_DIR/shopify-test.json"
    SHOPIFY_WORKING=true
elif echo "$SHOPIFY_RESPONSE" | grep -q "404\|Workflow is not active"; then
    echo "❌ Shopify Integration: NOT ACTIVE"
    echo "   Please activate 'shopify-integration-agent' workflow in n8n"
    SHOPIFY_WORKING=false
elif echo "$SHOPIFY_RESPONSE" | grep -q "Invalid access token\|CONFIGURE_IN_N8N"; then
    echo "⚠️  Shopify Integration: NEEDS CREDENTIALS"
    echo "   Workflow is active but Shopify/Printful API keys not configured"
    echo "   This is OPTIONAL - you can skip Shopify integration for now"
    SHOPIFY_WORKING="partial"
else
    echo "⚠️  Shopify Integration: UNKNOWN RESPONSE"
    echo "   Response: $SHOPIFY_RESPONSE"
    SHOPIFY_WORKING=false
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🧪 TEST 4: Complete POD Orchestrator"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

if [ "$DESIGN_WORKING" = true ] && [ "$MARKETING_WORKING" = true ]; then
    echo "Prerequisites met (Design + Marketing working)"
    echo "Sending test request to /webhook/pod-complete..."
    echo ""

    COMPLETE_RESPONSE=$(curl -s -X POST "$N8N_URL/webhook/pod-complete" \
      -H 'Content-Type: application/json' \
      -d '{
        "theme": "funny cat yoga",
        "product_name": "Cat Yoga Shirt",
        "count": 1,
        "target_audience": "cat lovers",
        "price": 29.99,
        "shopify_store": "test-store.myshopify.com",
        "auto_publish": false
      }' 2>&1)

    echo "$COMPLETE_RESPONSE" > "$RESULTS_DIR/complete-test.json"

    if echo "$COMPLETE_RESPONSE" | grep -q "status.*COMPLETE\|results"; then
        echo "✅ Complete Pipeline: WORKING"
        echo "   Response saved to: $RESULTS_DIR/complete-test.json"
        COMPLETE_WORKING=true
    elif echo "$COMPLETE_RESPONSE" | grep -q "404\|Workflow is not active"; then
        echo "❌ Complete Pipeline: NOT ACTIVE"
        echo "   Please activate 'complete-pod-orchestrator' workflow in n8n"
        COMPLETE_WORKING=false
    else
        echo "⚠️  Complete Pipeline: UNKNOWN RESPONSE"
        echo "   Response: $COMPLETE_RESPONSE"
        COMPLETE_WORKING=false
    fi
else
    echo "⏭️  SKIPPED - Prerequisites not met"
    echo "   Design Working: $DESIGN_WORKING"
    echo "   Marketing Working: $MARKETING_WORKING"
    COMPLETE_WORKING="skipped"
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "📊 TEST RESULTS SUMMARY"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

echo "Workflow Status:"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
printf "%-30s %s\n" "POD Design Generator:" "$( [ "$DESIGN_WORKING" = true ] && echo '✅ WORKING' || echo '❌ NOT ACTIVE' )"
printf "%-30s %s\n" "Marketing Automation:" "$( [ "$MARKETING_WORKING" = true ] && echo '✅ WORKING' || echo '❌ NOT ACTIVE' )"
printf "%-30s %s\n" "Shopify Integration:" "$( [ "$SHOPIFY_WORKING" = true ] && echo '✅ WORKING' || [ "$SHOPIFY_WORKING" = "partial" ] && echo '⚠️  NEEDS CREDENTIALS' || echo '❌ NOT ACTIVE' )"
printf "%-30s %s\n" "Complete Pipeline:" "$( [ "$COMPLETE_WORKING" = true ] && echo '✅ WORKING' || [ "$COMPLETE_WORKING" = "skipped" ] && echo '⏭️  SKIPPED' || echo '❌ NOT ACTIVE' )"

echo ""
echo "Results saved to: $RESULTS_DIR/"
echo ""

# Overall status
CRITICAL_WORKING=0
if [ "$DESIGN_WORKING" = true ]; then ((CRITICAL_WORKING++)); fi
if [ "$MARKETING_WORKING" = true ]; then ((CRITICAL_WORKING++)); fi

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
if [ $CRITICAL_WORKING -eq 2 ]; then
    echo "🎉 SUCCESS - Core workflows are active!"
    echo ""
    echo "Your POD automation system is READY:"
    echo "  ✅ Design generation (DALL-E 3)"
    echo "  ✅ Marketing content (Instagram, Facebook, Email, Ads)"
    echo ""
    if [ "$SHOPIFY_WORKING" != true ]; then
        echo "  ⚠️  Shopify integration needs credentials (optional)"
        echo "     See: SHOPIFY-INTEGRATION-GUIDE.md for setup"
    fi
    echo ""
    echo "Next steps:"
    echo "  1. Test design generation with real themes"
    echo "  2. Generate marketing content for your products"
    echo "  3. (Optional) Configure Shopify for automated uploads"
    echo ""
    exit 0
elif [ $CRITICAL_WORKING -eq 1 ]; then
    echo "⚠️  PARTIAL - Some workflows need activation"
    echo ""
    echo "Please activate missing workflows in n8n Cloud:"
    if [ "$DESIGN_WORKING" != true ]; then
        echo "  ❌ pod-design-generator"
    fi
    if [ "$MARKETING_WORKING" != true ]; then
        echo "  ❌ marketing-automation-agent"
    fi
    echo ""
    exit 1
else
    echo "❌ FAILED - No workflows are active"
    echo ""
    echo "Action required:"
    echo "  1. Login to n8n Cloud: $N8N_URL"
    echo "  2. Import workflows from: /tmp/botiaga-activated-workflows/"
    echo "  3. Activate each workflow (toggle switch)"
    echo "  4. Run this test script again"
    echo ""
    exit 1
fi
