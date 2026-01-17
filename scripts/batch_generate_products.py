#!/usr/bin/env python3
"""
Batch POD Product Generation
Creates 10 products automatically in parallel
"""
import requests
import json
import base64
import time
from concurrent.futures import ThreadPoolExecutor, as_completed

PRINTFUL_API_KEY = "ahwHiVuJt86gDyENW6vBvdLcCDnZPJiHlSfXzwkm"
PRINTFUL_STORE_ID = "17560131"

# 10 Product Ideas - diverse themes
PRODUCT_IDEAS = [
    {
        "theme": "Retro synthwave sunset with palm trees",
        "style": "80s aesthetic, neon colors, vaporwave",
        "price": "29.99",
        "audience": "80s nostalgia fans, synthwave music lovers"
    },
    {
        "theme": "Minimalist mountain landscape at sunrise",
        "style": "minimalist, peaceful earth tones, geometric",
        "price": "27.99",
        "audience": "nature lovers, hikers, minimalism enthusiasts"
    },
    {
        "theme": "Cyberpunk samurai warrior",
        "style": "futuristic, neon, japanese art fusion",
        "price": "32.99",
        "audience": "anime fans, cyberpunk enthusiasts, gamers"
    },
    {
        "theme": "Coffee addict penguin with espresso machine",
        "style": "cute cartoon, warm coffee colors, playful",
        "price": "28.99",
        "audience": "coffee lovers, penguin fans, morning people"
    },
    {
        "theme": "Abstract geometric lion portrait",
        "style": "low poly, bold colors, modern art",
        "price": "31.99",
        "audience": "art lovers, lion enthusiasts, modern design fans"
    },
    {
        "theme": "Retro gaming pixel art arcade",
        "style": "8-bit pixel art, bright arcade colors",
        "price": "29.99",
        "audience": "retro gamers, arcade enthusiasts, pixel art fans"
    },
    {
        "theme": "Yoga cat in tree pose meditation",
        "style": "peaceful, pastel colors, zen minimalist",
        "price": "27.99",
        "audience": "yoga practitioners, cat lovers, wellness enthusiasts"
    },
    {
        "theme": "Space exploration rocket launch",
        "style": "vintage poster, retro sci-fi, bold typography",
        "price": "30.99",
        "audience": "space enthusiasts, sci-fi fans, nasa lovers"
    },
    {
        "theme": "Tropical beach sunset with surfboard",
        "style": "vibrant tropical colors, summer vibes",
        "price": "28.99",
        "audience": "surfers, beach lovers, summer enthusiasts"
    },
    {
        "theme": "Steampunk octopus inventor",
        "style": "victorian steampunk, brass and copper tones",
        "price": "31.99",
        "audience": "steampunk fans, octopus lovers, inventors"
    }
]

def upload_to_printful_library(image_url, filename):
    """Upload image to Printful File Library"""
    print(f"      📤 Uploading {filename} to Printful...")

    # Try URL upload first (faster)
    upload_response = requests.post(
        "https://api.printful.com/files",
        headers={
            "Authorization": f"Bearer {PRINTFUL_API_KEY}",
            "Content-Type": "application/json",
            "X-PF-Store-Id": PRINTFUL_STORE_ID
        },
        json={
            "type": "default",
            "filename": filename,
            "url": image_url
        },
        timeout=30
    )

    if upload_response.status_code in [200, 201]:
        file_data = upload_response.json()
        file_id = file_data['result']['id']
        print(f"      ✅ File uploaded (ID: {file_id})")
        return file_id
    else:
        print(f"      ❌ Upload failed: {upload_response.status_code}")
        return None

def create_single_product(product_idea, index):
    """Create single POD product"""
    theme = product_idea['theme']
    style = product_idea['style']
    price = product_idea['price']
    audience = product_idea['audience']

    print(f"\n{'='*70}")
    print(f"🎨 PRODUCT {index}/10: {theme[:40]}...")
    print(f"{'='*70}")

    try:
        # Step 1: Generate Design
        print(f"   🎨 Generating design...")
        design_response = requests.post(
            "https://juozas.app.n8n.cloud/webhook/pod-designs",
            json={"theme": theme, "style": style},
            timeout=40
        )

        if design_response.status_code != 200:
            print(f"   ❌ Design failed: {design_response.status_code}")
            return {"success": False, "error": "Design generation failed"}

        design_data = design_response.json()
        print(f"   ✅ Design: {design_data['design_id']}")

        # Step 2: Generate Marketing
        print(f"   📱 Generating marketing...")
        marketing_response = requests.post(
            "https://juozas.app.n8n.cloud/webhook/marketing-auto",
            json={
                "product_name": f"{theme} T-Shirt",
                "description": design_data['prompt'],
                "target_audience": audience,
                "platforms": ["instagram", "facebook"]
            },
            timeout=40
        )

        if marketing_response.status_code == 200:
            print(f"   ✅ Marketing: Ready")
        else:
            print(f"   ⚠️  Marketing: Skipped")

        # Step 3: Upload to Printful
        print(f"   🛒 Uploading to Printful...")
        file_id = upload_to_printful_library(
            design_data['image_url'],
            f"{design_data['design_id']}.png"
        )

        if not file_id:
            return {"success": False, "error": "File upload failed"}

        # Step 4: Create Product
        printful_payload = {
            "sync_product": {
                "name": f"{theme} T-Shirt"
            },
            "sync_variants": [{
                "retail_price": price,
                "variant_id": 4011,
                "files": [{"id": file_id}]
            }]
        }

        printful_response = requests.post(
            "https://api.printful.com/store/products",
            headers={
                "Authorization": f"Bearer {PRINTFUL_API_KEY}",
                "Content-Type": "application/json",
                "X-PF-Store-Id": PRINTFUL_STORE_ID
            },
            json=printful_payload,
            timeout=30
        )

        if printful_response.status_code in [200, 201]:
            printful_data = printful_response.json()
            product_id = printful_data['result']['id']
            print(f"   ✅ Printful Product: {product_id}")
            print(f"   💰 Cost: $0.07 | Price: ${price} | Profit: ${float(price) - 12.07:.2f}")

            return {
                "success": True,
                "theme": theme,
                "design_id": design_data['design_id'],
                "printful_id": product_id,
                "price": price,
                "cost": 0.07
            }
        else:
            print(f"   ❌ Printful failed: {printful_response.status_code}")
            return {"success": False, "error": "Printful creation failed"}

    except Exception as e:
        print(f"   ❌ Error: {str(e)}")
        return {"success": False, "error": str(e)}

def batch_generate():
    """Generate 10 products in parallel"""
    print("╔══════════════════════════════════════════════════════════════╗")
    print("║                                                              ║")
    print("║       🚀 BATCH POD PRODUCT GENERATION                       ║")
    print("║          Creating 10 Products Automatically                 ║")
    print("║                                                              ║")
    print("╚══════════════════════════════════════════════════════════════╝")
    print()
    print("🎯 TARGET: 10 Live Products")
    print("⏱️  Estimated time: 3-5 minutes")
    print("💰 Total cost: ~$0.70")
    print("📈 Potential revenue: ~$300")
    print()

    start_time = time.time()
    results = []

    # Use ThreadPoolExecutor for parallel execution
    with ThreadPoolExecutor(max_workers=3) as executor:
        # Submit all tasks
        future_to_product = {
            executor.submit(create_single_product, product, i+1): (product, i+1)
            for i, product in enumerate(PRODUCT_IDEAS)
        }

        # Collect results as they complete
        for future in as_completed(future_to_product):
            product, index = future_to_product[future]
            try:
                result = future.result()
                results.append(result)
            except Exception as e:
                print(f"\n❌ Product {index} failed with exception: {e}")
                results.append({"success": False, "error": str(e)})

    # Summary
    elapsed = time.time() - start_time
    successful = [r for r in results if r.get('success')]
    failed = [r for r in results if not r.get('success')]

    print("\n\n")
    print("╔══════════════════════════════════════════════════════════════╗")
    print("║                                                              ║")
    print("║                  📊 BATCH GENERATION COMPLETE               ║")
    print("║                                                              ║")
    print("╚══════════════════════════════════════════════════════════════╝")
    print()
    print(f"⏱️  Total time: {elapsed:.1f} seconds")
    print(f"✅ Successful: {len(successful)}/10")
    print(f"❌ Failed: {len(failed)}/10")
    print()

    if successful:
        print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
        print("✅ SUCCESSFUL PRODUCTS:")
        print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
        total_cost = 0
        total_price = 0
        for r in successful:
            print(f"   🎨 {r['theme'][:50]}")
            print(f"      Printful: {r['printful_id']} | Price: ${r['price']}")
            total_cost += r['cost']
            total_price += float(r['price'])

        print()
        print(f"💰 Total Investment: ${total_cost:.2f}")
        print(f"💵 Total Retail Value: ${total_price:.2f}")
        print(f"📈 Potential Profit: ${total_price - total_cost - (len(successful) * 12):.2f}")
        print()

    if failed:
        print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
        print("❌ FAILED PRODUCTS:")
        print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
        for r in failed:
            print(f"   Error: {r.get('error', 'Unknown')}")
        print()

    print("🌐 View all products: https://www.printful.com/dashboard/default/products")
    print()

    # Save results
    with open('/tmp/batch-generation-results.json', 'w') as f:
        json.dump({
            "total": len(results),
            "successful": len(successful),
            "failed": len(failed),
            "elapsed_seconds": elapsed,
            "products": results
        }, f, indent=2)

    print("📁 Results saved to: /tmp/batch-generation-results.json")
    print()
    print("✨ BATCH GENERATION COMPLETE! ✨")

    return results

if __name__ == "__main__":
    batch_generate()
