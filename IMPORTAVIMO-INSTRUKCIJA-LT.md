# 📥 n8n Workflow Importavimo Instrukcija

**Laikas:** 10-15 minučių
**Sunkumas:** Labai lengva (drag & drop)

---

## 🎯 Kas Reikia Padaryti

Turime **4 workflow failus** su jūsų OpenAI API raktu:
- `/tmp/botiaga-activated-workflows/pod-design-generator.json`
- `/tmp/botiaga-activated-workflows/marketing-automation-agent.json`
- `/tmp/botiaga-activated-workflows/shopify-integration-agent.json`
- `/tmp/botiaga-activated-workflows/complete-pod-orchestrator.json`

**Juos reikia įkelti į n8n Cloud rankiniu būdu** (per naršyklę).

---

## 📋 ŽINGSNIS PO ŽINGSNIO INSTRUKCIJA

### ŽINGSNIS 1: Atidarykite n8n Cloud

1. **Atidarykite naršyklę** (Chrome, Firefox, Safari - bet kurią)

2. **Eikite į:**
   ```
   https://juozas.app.n8n.cloud
   ```

3. **Prisijunkite** su savo n8n paskyra
   - Įveskite email
   - Įveskite slaptažodį
   - Spauskite "Login" arba "Sign in"

4. **Turėtumėte matyti n8n Dashboard'ą**
   - Viršuje kairėje matosi "n8n" logo
   - Kairėje pusėje meniu su "Workflows", "Executions", etc.
   - Viduryje galbūt matote "Create a new workflow" arba workflow'ų sąrašą

---

### ŽINGSNIS 2: Importuokite Pirmą Workflow (Design Generator)

#### 2.1. Pradėkite importavimą:

1. **Kairėje viršuje spauskite "+" mygtuką**
   - Arba spauskite "Add Workflow" / "New Workflow"
   - Turėtų atsirasti dropdown meniu

2. **Pasirinkite "Import from file"**
   - Kartais tai gali būti "Import from File" arba "Import"
   - Turėtų atsidaryti failo pasirinkimo dialogas

#### 2.2. Pasirinkite failą:

1. **Failų naršyklėje** eikite į:
   ```
   /tmp/botiaga-activated-workflows/
   ```

2. **Pasirinkite failą:**
   ```
   pod-design-generator.json
   ```

3. **Spauskite "Open" arba "Atidaryti"**

#### 2.3. Išsaugokite ir aktyvuokite:

1. **Palaukite** kol workflow užsikrauna (1-2 sekundės)
   - Turėtumėte matyti daug mazgų (nodes) su linijomis

2. **Spauskite "Save" (Išsaugoti)** - viršuje dešinėje
   - Gali paklausti workflow pavadinimo - palikite kaip yra
   - Spauskite "Save"

3. **SVARBU: Aktyvuokite workflow**
   - Viršuje dešinėje yra jungiklis "Active" / "Inactive"
   - **Paspauskite, kad taptų ŽALIAS (Active)**
   - Turėtumėte matyti žinutę "Workflow activated" arba panašiai

4. **Patikrinkite Webhook statusą:**
   - Atidarykite pirmą mazgą "Webhook Trigger"
   - Apačioje turėtų būti parašyta:
     - **Production URL:** `https://juozas.app.n8n.cloud/webhook/pod-designs`
     - **Status:** 🟢 "Listening" (žalia)
   - Jei matote "Inactive" - reikia aktyvuoti workflow (žr. žingsnį 3)

✅ **Pirmas workflow PADARYTA!**

---

### ŽINGSNIS 3: Importuokite Antrą Workflow (Marketing Automation)

**Kartokite tą patį procesą:**

1. **"+" → "Import from file"**
2. **Pasirinkite:** `marketing-automation-agent.json`
3. **"Import"**
4. **"Save"**
5. **Aktyvuokite** (toggle į ŽALIA)
6. **Patikrinkite webhook:** `/webhook/marketing-auto`

✅ **Antras workflow PADARYTA!**

---

### ŽINGSNIS 4: Importuokite Trečią Workflow (Shopify Integration)

**Kartokite procesą:**

1. **"+" → "Import from file"**
2. **Pasirinkite:** `shopify-integration-agent.json`
3. **"Import"**
4. **"Save"**
5. **Aktyvuokite** (toggle į ŽALIA)
6. **Patikrinkite webhook:** `/webhook/shopify-upload`

⚠️ **PASTABA:** Šiame workflow matysite placeholder'ius:
- `CONFIGURE_IN_N8N` - vietoj Shopify rakto
- Tai NORMALU - galime konfigūruoti vėliau
- Workflow vis tiek veiks testuojant

✅ **Trečias workflow PADARYTA!**

---

### ŽINGSNIS 5: Importuokite Ketvirtą Workflow (Complete Pipeline)

**Paskutinis workflow:**

1. **"+" → "Import from file"**
2. **Pasirinkite:** `complete-pod-orchestrator.json`
3. **"Import"**
4. **"Save"**
5. **Aktyvuokite** (toggle į ŽALIA)
6. **Patikrinkite webhook:** `/webhook/pod-complete`

✅ **Ketvirtas workflow PADARYTA!**

---

### ŽINGSNIS 6: Patikrinkite Ar Visi Aktyvūs

1. **Kairėje meniu spauskite "Workflows"**

2. **Turėtumėte matyti 4 workflow'us:**
   - ✅ **POD Design Generator - DALL-E 3** (žalia būsena)
   - ✅ **Marketing Automation Agent - Social Media** (žalia)
   - ✅ **Shopify Integration - Automated Product Upload** (žalia)
   - ✅ **Complete POD Orchestrator - End-to-End Automation** (žalia)

3. **Jei kuris nors RAUDONAS arba PILKAS:**
   - Atidarykite tą workflow
   - Spauskite toggle "Active" viršuje dešinėje
   - Turėtų tapti ŽALIAS

---

## ✅ BAIGTA! Dabar Testuojame

Grįžkite į terminalą ir paleiskite:

```bash
cd /root/Botiaga
./test-activated-workflows.sh
```

**Turėtumėte matyti:**
```
✅ Design Generator: WORKING
✅ Marketing Agent: WORKING
⚠️  Shopify Integration: NEEDS CREDENTIALS (optional)
✅ Complete Pipeline: WORKING
```

---

## 🎨 Sukurkite Pirmą Produktą!

Kai testai praeina, išbandykite pilną sistemą:

```bash
curl -X POST https://juozas.app.n8n.cloud/webhook/pod-complete \
  -H 'Content-Type: application/json' \
  -d '{
    "theme": "linksmas katinas darąs jogą",
    "product_name": "Katino Jogos Marškinėliai",
    "count": 1,
    "price": 29.99
  }'
```

**Kas nutiks (39 sekundės):**
1. ✅ Sugeneruos dizainą su DALL-E 3
2. ✅ Sukurs marketing kampaniją (Instagram, Facebook, Email, Ads)
3. ✅ (Su Shopify) Įkels produktą į Shopify

**Kaina:** $0.07

---

## ❓ Problemos ir Sprendimai

### Problema: "Workflow is not active"

**Sprendimas:**
1. Atidarykite workflow
2. Viršuje dešinėje toggle "Active"
3. Spauskite "Save"

### Problema: "Webhook not found" (404)

**Sprendimas:**
1. Workflow neaktyvuotas - aktyvuokite
2. Arba neteisingai įvestas URL - patikrinkite webhook path

### Problema: "OpenAI API error"

**Sprendimas:**
1. Patikrinkite ar turite OpenAI kreditų: https://platform.openai.com/usage
2. Jei ne - papildykite balansą ($5-10 pakaks mėnesiui)

### Problema: Nematau failo `/tmp/botiaga-activated-workflows/`

**Sprendimas:**
```bash
# Paleiskite iš naujo activation script:
export OPENAI_API_KEY='your-openai-api-key-here'
./activate-workflows.sh
```

---

## 🎯 Kas Po To?

**Šiandien:**
- ✅ Importuokite 4 workflows
- ✅ Paleiskite testus
- ✅ Sukurkite 5-10 dizainų

**Šią savaitę:**
- ⏳ Sugeneruokite 20-30 produktų
- ⏳ Pasirinkite geriausius dizainus
- ⏳ (Opcionaliai) Sukurkite Shopify parduotuvę

**Šį mėnesį:**
- ⏳ Paskelbkite produktus
- ⏳ Paleiskite marketing kampanijas
- ⏳ Pradėkite pardavinėti!

---

## 💡 Patarimai

1. **Pirmą kartą importuojant** - geriau daryti vieną po kito, ne visus iš karto
2. **Visada aktyvuokite** workflow po import'o - kitaip neveiks
3. **Webhook status** turėtų būti "Listening" - jei ne, workflow neaktyvus
4. **OpenAI raktas** jau sukonfigūruotas failuose - nereikia nieko keisti

---

## 📞 Pagalba

Jei kyla problemų importuojant:

1. **Patikrinkite n8n execution logs:**
   - Atidarykite workflow
   - Spauskite "Executions" tab
   - Žiūrėkite ar yra klaidų

2. **Grįžkite čia ir pasakykite kokia klaida** - aš padėsiu išspręsti

3. **Arba tiesiog pasakykite "done"** kai baigsite - aš paleisiu testus

---

**Sėkmės! 🚀**

Kai baigsite importuoti - tiesiog parašykite "done" arba "padaryta" ir aš paleisiu automatinius testus!
