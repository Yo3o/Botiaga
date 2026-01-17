# 📋 IMPORTAVIMAS PER COPY-PASTE (PAPRASČIAUSIAS BŪDAS)

Kadangi failų parsisiuntimas neveikia, naudosime **copy-paste** metodą.

## 🎯 KĄ DARYTI:

### WORKFLOW #1: POD Design Generator

1. **Eikite į n8n:** https://juozas.app.n8n.cloud
2. **Spauskite:** Create workflow → Import from URL (arba Import)
3. **Jei reikia failo turinio** - terminalas išspausdinkite:

```bash
cat /tmp/botiaga-activated-workflows/pod-design-generator.json
```

4. **Nukopijuokite visą JSON** (nuo { iki })
5. **n8n:** Paste content arba Upload file
6. **Save** ir **Aktyvuoti** (toggle)

### WORKFLOW #2: Marketing Automation

```bash
cat /tmp/botiaga-activated-workflows/marketing-automation-agent.json
```

Pakartokite tą patį procesą.

### WORKFLOW #3: Shopify Integration

```bash
cat /tmp/botiaga-activated-workflows/shopify-integration-agent.json
```

### WORKFLOW #4: Complete Orchestrator

```bash
cat /tmp/botiaga-activated-workflows/complete-pod-orchestrator.json
```

---

## ⚡ GREIČIAUSIAS BŪDAS - n8n API

Jei turite n8n API raktą, galiu importuoti automatiškai per API.

Arba naudokite **Import from URL** n8n'e ir įkelkite failus tiesiogiai iš terminalo.

