#!/usr/bin/env python3
"""
Complete POD Product Automation v2
Fixed: Printful file upload via File Library
"""
import requests
import json
import base64
from io import BytesIO

PRINTFUL_API_KEY = "ahwHiVuJt86gDyENW6vBvdLcCDnZPJiHlSfXzwkm"
PRINTFUL_STORE_ID = "17560131"

def upload_to_printful_library(image_url, filename="design.png"):
    """Upload image to Printful File Library"""
    print(f"   📥 Downloading image from DALL-E...")

    # Download image
    img_response = requests.get(image_url, timeout=30)
    if img_response.status_code != 200:
        print(f"   ❌ Failed to download image")
        return None

    print(f"   ✅ Downloaded {len(img_response.content)} bytes")

    # Convert to base64
    image_base64 = base64.b64encode(img_response.content).decode('utf-8')

    print(f"   📤 Uploading to Printful File Library...")

    # Upload to Printful
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
            "url": image_url  # Printful can also fetch from URL!
        },
        timeout=30
    )

    if upload_response.status_code in [200, 201]:
        file_data = upload_response.json()
        file_id = file_data['result']['id']
        print(f"   ✅ Uploaded to Printful Library (ID: {file_id})")
        return file_id
    else:
        print(f"   ⚠️  File Library upload failed: {upload_response.status_code}")
        print(f"   Trying direct base64 upload...")

        # Try base64 upload
        upload_response2 = requests.post(
            "https://api.printful.com/files",
            headers={
                "Authorization": f"Bearer {PRINTFUL_API_KEY}",
                "Content-Type": "application/json",
                "X-PF-Store-Id": PRINTFUL_STORE_ID
            },
            json={
                "type": "default",
                "filename": filename,
                "contents": image_base64
            },
            timeout=60
        )

        if upload_response2.status_code in [200, 201]:
            file_data = upload_response2.json()
            file_id = file_data['result']['id']
            print(f"   ✅ Uploaded via base64 (ID: {file_id})")
            return file_id
        else:
            print(f"   ❌ Both upload methods failed")
            print(f"   Response: {upload_response2.text[:200]}")
            return None

def create_pod_product(theme, style="modern, vibrant colors", price="29.99", target_audience="general"):
    """Create complete POD product automatically with proper file upload"""

    print("╔══════════════════════════════════════════════════════════════╗")
    print("║                                                              ║")
    print("║       🤖 AUTOMATED POD PRODUCT CREATION v2                  ║")
    print("║                                                              ║")
    print("╚══════════════════════════════════════════════════════════════╝")
    print()
    print(f"Theme: {theme}")
    print(f"Style: {style}")
    print(f"Price: ${price}")
    print()

    # Step 1: Generate Design
    print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
    print("🎨 STEP 1: Generating Design (DALL-E 3)...")
    print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")

    design_response = requests.post(
        "https://juozas.app.n8n.cloud/webhook/pod-designs",
        json={"theme": theme, "style": style},
        timeout=30
    )

    if design_response.status_code != 200:
        print(f"❌ Design generation failed: {design_response.status_code}")
        return None

    design_data = design_response.json()
    print(f"✅ Design created!")
    print(f"   ID: {design_data['design_id']}")
    print(f"   Cost: ${design_data['cost_usd']}")
    print()

    # Step 2: Generate Marketing
    print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
    print("📱 STEP 2: Generating Marketing Content (GPT-4o)...")
    print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")

    marketing_response = requests.post(
        "https://juozas.app.n8n.cloud/webhook/marketing-auto",
        json={
            "product_name": f"{theme} T-Shirt",
            "description": design_data['prompt'],
            "target_audience": target_audience,
            "platforms": ["instagram", "facebook", "email"]
        },
        timeout=30
    )

    if marketing_response.status_code != 200:
        print(f"❌ Marketing generation failed: {marketing_response.status_code}")
        marketing_data = {"cost_usd": 0.03}
    else:
        marketing_data = marketing_response.json()
        print(f"✅ Marketing content created!")
        print(f"   Platforms: Instagram, Facebook, Email")
        print(f"   Cost: ${marketing_data.get('cost_usd', 0.03)}")
    print()

    # Step 3: Upload image to Printful File Library
    print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
    print("📦 STEP 3: Uploading to Printful File Library...")
    print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")

    file_id = upload_to_printful_library(
        design_data['image_url'],
        filename=f"{design_data['design_id']}.png"
    )

    if not file_id:
        print("❌ File upload failed - cannot create product")
        return None

    print()

    # Step 4: Create Printful Product
    print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
    print("🛒 STEP 4: Creating Printful Product...")
    print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")

    printful_payload = {
        "sync_product": {
            "name": f"{theme} T-Shirt"
        },
        "sync_variants": [{
            "retail_price": price,
            "variant_id": 4011,  # Unisex T-Shirt, size S
            "files": [{
                "id": file_id
            }]
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

    if printful_response.status_code not in [200, 201]:
        print(f"❌ Printful product creation failed: {printful_response.status_code}")
        print(f"   Response: {printful_response.text[:500]}")
        return None

    printful_data = printful_response.json()
    print(f"✅ Product created in Printful!")
    print(f"   Product ID: {printful_data['result']['id']}")
    print()

    # Summary
    total_cost = design_data['cost_usd'] + marketing_data.get('cost_usd', 0.03)

    print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
    print("✅ PRODUCT CREATED SUCCESSFULLY!")
    print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
    print()
    print(f"📦 Product: {theme} T-Shirt")
    print(f"🎨 Design ID: {design_data['design_id']}")
    print(f"🛒 Printful ID: {printful_data['result']['id']}")
    print(f"💰 Total Cost: ${total_cost:.2f}")
    print(f"💵 Retail Price: ${price}")
    print(f"📈 Potential Profit: ${float(price) - float(total_cost) - 12:.2f}")
    print()
    print("🎉 PRODUCT IS NOW LIVE IN PRINTFUL STORE!")
    print(f"🌐 View at: https://www.printful.com/dashboard/default/products")
    print()

    return {
        "design": design_data,
        "marketing": marketing_data,
        "printful": printful_data,
        "costs": {"total": total_cost}
    }

if __name__ == "__main__":
    result = create_pod_product(
        theme="Skateboarding sloth wearing sunglasses",
        style="cartoon, vibrant colors, playful",
        price="29.99",
        target_audience="skateboarders, animal lovers, fun lifestyle"
    )

    if result:
        with open('/tmp/complete-product-v2.json', 'w') as f:
            json.dump(result, f, indent=2)
        print("📁 Full results saved to: /tmp/complete-product-v2.json")
        print()
        print("✨ AUTOMATION SUCCESSFUL! ✨")
