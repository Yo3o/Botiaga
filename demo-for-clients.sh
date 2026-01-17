#!/bin/bash

# BOTIAGA AI - Client Demo Script
# Showcase the AI Business Factory capabilities

clear

echo "╔═══════════════════════════════════════════════════════════╗"
echo "║                                                           ║"
echo "║            🤖 BOTIAGA AI - BUSINESS FACTORY               ║"
echo "║                                                           ║"
echo "║        Generate Complete Business Plans in Seconds       ║"
echo "║                                                           ║"
echo "╚═══════════════════════════════════════════════════════════╝"
echo ""
echo "Welcome to Botiaga AI! Let me show you what we can do..."
echo ""
sleep 2

# Demo 1: Quick Idea
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "DEMO 1: Quick Business Idea Analysis"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "💡 Idea: 'Sustainable coffee subscription for remote workers'"
echo ""
echo "Analyzing with AI Brain (fast mode)..."
echo ""

RESULT=$(curl -s -X POST https://juozas.app.n8n.cloud/webhook/ai-brain \
  -H "Content-Type: application/json" \
  -d '{"idea": "Sustainable coffee subscription for remote workers"}' \
  --max-time 30)

echo "$RESULT" | python3 << 'PYTHON'
import json, sys
d = json.load(sys.stdin)
a = d.get('analysis', {})
print(f"✅ Analysis Complete!")
print(f"")
print(f"   Domain: {a.get('domain', 'N/A')}")
print(f"   Complexity: {a.get('complexity', 'N/A')}")
print(f"   Market: {str(a.get('market_size', 'N/A'))[:60]}...")
print(f"   Competition: {str(a.get('competition', 'N/A'))[:60]}...")
print(f"")
PYTHON

sleep 3
echo ""

# Demo 2: Full Business Plan
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "DEMO 2: Complete Business Plan Generation"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "💡 Idea: 'AI-powered meal planning app for busy professionals'"
echo ""
echo "Generating comprehensive business plan with CEO Agent..."
echo "(This takes 10-15 seconds)"
echo ""

RESULT=$(curl -s -X POST https://juozas.app.n8n.cloud/webhook/ceo \
  -H "Content-Type: application/json" \
  -d '{"idea": "AI-powered meal planning app for busy professionals"}' \
  --max-time 90)

SESSION_ID=$(echo "$RESULT" | python3 -c "import json,sys; d=json.load(sys.stdin); print(d.get('session_id',''))" 2>/dev/null)

echo "$RESULT" | python3 << 'PYTHON'
import json, sys
d = json.load(sys.stdin)
bp = d.get('business_plan', {})
es = bp.get('executive_summary', {})
fin = bp.get('financial', {})
ma = bp.get('market_analysis', {})
prod = bp.get('product', {})

print("✅ Business Plan Generated!")
print("")
print("═" * 60)
print(f"📊 BUSINESS: {es.get('business_name', 'N/A')}")
print("═" * 60)
print("")
print("💰 FINANCIAL OVERVIEW:")
print(f"   Initial Investment: {fin.get('initial_investment', 'N/A')}")
print(f"   Break-even: {str(fin.get('break_even_analysis', 'N/A'))[:50]}...")
print("")
print("🎯 MARKET:")
print(f"   Size: {str(ma.get('market_size', 'N/A'))[:55]}...")
print(f"   Target: {str(ma.get('target_audience', ma.get('target_market', 'N/A')))[:55]}...")
print("")
print("🛠️  PRODUCT:")
prods = prod.get('main_products', prod.get('core_features', []))
if isinstance(prods, list):
    for idx, p in enumerate(prods[:3], 1):
        print(f"   {idx}. {str(p)[:55]}...")
print("")
print("📋 Complete plan includes:")
print("   ✓ Executive Summary")
print("   ✓ Market Analysis")
print("   ✓ Business Model & Revenue")
print("   ✓ Product Specifications")
print("   ✓ Legal Requirements (Germany/EU)")
print("   ✓ Financial Projections")
print("   ✓ Marketing Strategy")
print("   ✓ Action Plan (Week 1, 2, Month 1)")
print("   ✓ Risk Assessment")
print("   ✓ Team Requirements")
print("")
PYTHON

echo "Session ID: $SESSION_ID"
echo "(Stored in Redis for 7 days)"
echo ""
sleep 3

# Summary
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🎉 DEMO COMPLETE"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "What you just saw:"
echo ""
echo "  ⚡ AI Brain (Quick Mode)"
echo "     → 5-8 seconds"
echo "     → Domain, complexity, market overview"
echo "     → Perfect for rapid idea validation"
echo ""
echo "  🧠 CEO Agent (Full Mode)"
echo "     → 10-15 seconds"
echo "     → Complete 10-section business plan"
echo "     → Market research, financials, legal, action plan"
echo "     → Ready to present to investors"
echo ""
echo "  💾 Memory System"
echo "     → All plans stored in Redis"
echo "     → Retrieve by Session ID"
echo "     → 7-day retention"
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "🚀 Ready to use Botiaga AI for your business ideas?"
echo ""
echo "Try it now:"
echo "  curl -X POST https://juozas.app.n8n.cloud/webhook/ceo \\"
echo "    -H 'Content-Type: application/json' \\"
echo "    -d '{\"idea\": \"Your business idea here\"}'"
echo ""
echo "Or visit: https://botiaga.com (coming soon)"
echo ""
