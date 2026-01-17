# 📥 n8n Import Instrukcija - TIKSLŪS ŽINGSNIAI

## 🎯 KUR RASTI "IMPORT" n8n EKRANE

### Pagal Jūsų Screenshot'ą:

```
┌─────────────────────────────────────────────────────────┐
│  Personal                    [Create workflow ▼]        │  ← ČIA!
│  Workflows, credentials...                              │
└─────────────────────────────────────────────────────────┘
```

## ŽINGSNIS PO ŽINGSNIO:

### 1. Spauskite RODYKLĘ ŠALIA "Create workflow"

Jūsų ekrane matosi:
```
Create workflow ▼
```

**Spauskite tą mažą rodyklę (▼)** arba visą mygtuką.

### 2. Turėtų Atsirasti Dropdown Meniu:

```
┌─────────────────────────┐
│ • New workflow          │
│ • Import from file      │  ← ŠIS REIKIA!
│ • Import from URL       │
└─────────────────────────┘
```

**PASIRINKITE:** "Import from file"

### 3. Kas Jei Nematote "Import from file"?

Tuomet n8n turi kitokią versiją. Bandykite:

#### VARIANTAS A: Per "New workflow" + Paste

1. Spauskite "Create workflow" → "New workflow"
2. Atsidarys tuščias workflow canvas
3. **Klaviatūra:** Ctrl+V (Windows) arba Cmd+V (Mac)
4. n8n kartais priima JSON paste'ą tiesiai į canvas

#### VARIANTAS B: Per Menu (3 taškų) Mygtukus

Jei workflow canvas'e matote **"⋮"** (3 taškų mygtuką):

1. Spauskite **⋮** (top right arba menu)
2. Ieškokite "Import" opcijos
3. Pasirinkite

#### VARIANTAS C: Per Settings

1. Kairėje meniu apačioje ieškokite **Settings** arba **⚙️**
2. Workflows → Import
3. Pasirinkite failą

## 🎯 KAI RASITE "IMPORT FROM FILE":

### Kas Vyksta Toliau:

1. **Atsidarys Failo Pasirinkimo Langas** (jūsų kompiuterio)

2. **PROBLEMA:** Failai yra serveryje, ne jūsų kompiuteryje!

### SPRENDIMAS - 2 Būdai:

---

## ✅ BŪDAS 1: NUKOPIJUOTI FAILUS IŠ SERVERIO (GREIČIAUSIAS)

### Per SSH/SCP Klientą:

#### Windows: WinSCP
1. Atsisiųskite WinSCP: https://winscp.net/
2. Prisijunkite:
   - Host: `116.203.239.150`
   - User: `root`
   - Password: (jūsų root password)
3. Eikite į: `/tmp/botiaga-activated-workflows/`
4. Nukopijuokite 4 failus į Downloads

#### Mac/Linux: Terminale
```bash
# Jūsų kompiuteryje (ne serveryje):
scp root@116.203.239.150:/tmp/botiaga-activated-workflows/*.json ~/Downloads/
```

Tada n8n galėsite pasirinkti iš Downloads!

---

## ✅ BŪDAS 2: PER COPY-PASTE (JOKIŲ PAPILDOMŲ PROGRAMŲ)

### n8n Variantas su "Import from URL":

Jei matote **"Import from URL"** vietoj "Import from file":

1. Man serveryje reikia paleisti web serverį su failais
2. Duosiu jums URL
3. Paste'insite URL į n8n

**Norite šio būdo?** Pasakykite - aš setup'insiu.

---

## ✅ BŪDAS 3: TIESIOGINĖ PASTE (BE IMPORT MYGTUKO)

### Jei n8n leidžia paste'inti workflow data:

1. **Terminalas (serveris):**
   ```bash
   cat /tmp/botiaga-activated-workflows/pod-design-generator.json
   ```

2. **Nukopijuokite VISĄ JSON tekstą** (nuo pirmo `{` iki paskutinio `}`)

3. **n8n:**
   - Atidarykite "New workflow"
   - Dešiniu pelės klavišu ant canvas → "Paste"
   - ARBA tiesiog Ctrl+V (Cmd+V)

4. **Jei pavyko** - workflow nodes turėtų atsirasti!

5. **Save + Aktyvuoti**

---

## 🎯 KURIS BŪDAS JUMS PATOGIAUSIAS?

Parašykite:
- **"1"** - Naudosiu WinSCP/SCP nukopijuoti failus
- **"2"** - Duok URL, naudosiu "Import from URL"
- **"3"** - Bandysiu paste'inti JSON tiesiai

Ir aš padėsiu su tuo konkrečiu būdu! 🚀

---

## 📸 JŪSŲ EKRANO PAAIŠKINIMAS:

Matau jūsų ekrane:
```
┌──────────────────────────────────────────────────────┐
│  POD Design Generator - DALL-E 3         [✓] [⋮]     │
│  POD Master - Print-on-Demand Orchestrator [✓] [⋮]   │
│  CEO Agent - Business Factory            [✓] [⋮]     │
│  Get Business Plan by ID                 [✓] [⋮]     │
└──────────────────────────────────────────────────────┘
```

Tai reiškia:
- ✅ **Jau turite 4 workflows!**
- ✅ Visi aktyvūs (žali varnelės)

**KLAUSIMAS:** Gal **jau turite POD workflows importuotus**?

Patikrinkite ar viename iš jų yra:
- "POD Design Generator - DALL-E 3" ← ŠIS!
- "POD Master - Print-on-Demand Orchestrator" ← IR ŠIS!

**Jei taip - jie jau importuoti!** Tereikia aktyvuoti ir testuoti!
