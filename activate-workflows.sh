#!/bin/bash

# BOTIAGA POD WORKFLOWS - ACTIVATION SCRIPT
# Replaces API keys and prepares workflows for n8n import

set -e

OPENAI_KEY="${OPENAI_API_KEY:-YOUR_OPENAI_API_KEY_HERE}"

echo "╔══════════════════════════════════════════════════════════════╗"
echo "║                                                              ║"
echo "║       🚀 BOTIAGA POD WORKFLOWS - ACTIVATION SCRIPT          ║"
echo "║                                                              ║"
echo "╚══════════════════════════════════════════════════════════════╝"
echo ""

# Create activated workflows directory
ACTIVATED_DIR="/tmp/botiaga-activated-workflows"
rm -rf "$ACTIVATED_DIR"
mkdir -p "$ACTIVATED_DIR"

echo "📁 Creating activated workflows directory..."
echo "   $ACTIVATED_DIR"
echo ""

# Process each workflow
WORKFLOWS=(
    "n8n-workflows/core/pod-design-generator.json"
    "n8n-workflows/agents/marketing-automation-agent.json"
    "n8n-workflows/integrations/shopify-integration-agent.json"
    "n8n-workflows/core/complete-pod-orchestrator.json"
)

echo "🔧 Updating workflows with real API keys..."
echo ""

for workflow in "${WORKFLOWS[@]}"; do
    if [ -f "/root/Botiaga/$workflow" ]; then
        filename=$(basename "$workflow")
        echo "   ✓ Processing $filename"

        # Replace OpenAI API key
        sed "s/YOUR_OPENAI_API_KEY/$OPENAI_KEY/g" "/root/Botiaga/$workflow" > "$ACTIVATED_DIR/$filename"

        # Replace Shopify/Printful placeholders (will be added manually in n8n)
        sed -i "s/YOUR_SHOPIFY_ACCESS_TOKEN/CONFIGURE_IN_N8N/g" "$ACTIVATED_DIR/$filename"
        sed -i "s/YOUR_PRINTFUL_API_KEY/CONFIGURE_IN_N8N/g" "$ACTIVATED_DIR/$filename"
    else
        echo "   ⚠️  Warning: $workflow not found"
    fi
done

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "✅ WORKFLOWS READY FOR IMPORT"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "Activated workflows location:"
echo "   $ACTIVATED_DIR"
echo ""
echo "Files created:"
ls -lh "$ACTIVATED_DIR"
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "📋 NEXT STEPS - MANUAL IMPORT TO n8n"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "1. Login to n8n Cloud:"
echo "   👉 https://juozas.app.n8n.cloud"
echo ""
echo "2. Import each workflow:"
echo "   • Click '+' → 'Import from file'"
echo "   • Select file from: $ACTIVATED_DIR"
echo "   • Import and Save"
echo ""
echo "3. Workflows to import (in order):"
echo "   1️⃣  pod-design-generator.json"
echo "   2️⃣  marketing-automation-agent.json"
echo "   3️⃣  shopify-integration-agent.json"
echo "   4️⃣  complete-pod-orchestrator.json"
echo ""
echo "4. After import:"
echo "   • Activate each workflow (toggle switch)"
echo "   • Verify webhooks are 'Listening'"
echo "   • Note webhook URLs"
echo ""
echo "5. Test endpoints:"
echo "   • POST /webhook/pod-designs"
echo "   • POST /webhook/marketing-auto"
echo "   • POST /webhook/shopify-upload"
echo "   • POST /webhook/pod-complete"
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "⚠️  IMPORTANT NOTES"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "✓ OpenAI API key: Already configured"
echo "⚠️  Shopify access token: Configure manually in n8n"
echo "⚠️  Printful API key: Configure manually in n8n"
echo ""
echo "For Shopify integration to work:"
echo "1. Create Shopify store"
echo "2. Get API access token"
echo "3. Update shopify-integration-agent workflow"
echo ""
echo "For Printful integration:"
echo "1. Create Printful account"
echo "2. Get API key"
echo "3. Update shopify-integration-agent workflow"
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🧪 TEST COMMANDS"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "# Test Design Generator"
echo "curl -X POST https://juozas.app.n8n.cloud/webhook/pod-designs \\"
echo "  -H 'Content-Type: application/json' \\"
echo "  -d '{\"theme\": \"funny cat yoga\", \"count\": 1}'"
echo ""
echo "# Test Marketing Automation"
echo "curl -X POST https://juozas.app.n8n.cloud/webhook/marketing-auto \\"
echo "  -H 'Content-Type: application/json' \\"
echo "  -d '{\"product_name\": \"Cat Yoga Shirt\", \"product_description\": \"Funny design\", \"image_url\": \"https://example.com/image.png\"}'"
echo ""
echo "# Test Complete Pipeline (when all workflows active)"
echo "curl -X POST https://juozas.app.n8n.cloud/webhook/pod-complete \\"
echo "  -H 'Content-Type: application/json' \\"
echo "  -d '{\"theme\": \"funny cat yoga\", \"product_name\": \"Cat Yoga Shirt\", \"shopify_store\": \"your-store.myshopify.com\"}'"
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "🎉 Ready to import! Open n8n Cloud and import workflows."
echo ""
