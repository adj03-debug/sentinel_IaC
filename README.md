# Microsoft Sentinel – IaC Basic

Bicep-kod för att deploya en grundläggande Microsoft Sentinel-miljö i Azure. Deploymentet skapar ett tomt Sentinel utan data connectors eller analytic rules – de hanteras separat via [GitHub Repositories](https://learn.microsoft.com/en-us/azure/sentinel/ci-cd).

## Vad som skapas

```
Resource Group
└── Log Analytics Workspace
    └── Microsoft Sentinel (aktiverat)
```

## Förutsättningar

- [Azure CLI](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli) installerat
- Inloggad i rätt Azure-tenant: `az login`
- Behörighet att skapa resource groups och resurser på subscription-nivå

## Deployment

```bash
az deployment sub create \
  --location <region> \
  --template-file main.bicep \
  --name <deployment-namn>
```

Du kommer sedan få fylla i parametrarna interaktivt:

```
Please provide string value for 'rgName': rg-sentinel-prod
Please provide string value for 'location': swedencentral
Please provide string value for 'workspaceName': law-sentinel-prod
Please provide int value for 'retentionInDays' (default: 90):
```

### Exempel

```bash
az deployment sub create \
  --location swedencentral \
  --template-file main.bicep \
  --name deploySentinel
```

## Parametrar

| Parameter | Beskrivning | Obligatorisk | Default |
|---|---|---|---|
| `rgName` | Namn på resource group | Ja | – |
| `location` | Azure-region | Ja | – |
| `workspaceName` | Namn på Log Analytics workspace | Ja | – |
| `retentionInDays` | Datalagringstid i dagar (30–730) | Nej | 90 |

### Tillåtna regioner

- swedencentral
- westeurope
- northeurope
- germanywestcentral
- norwayeast
- uksouth
- eastus
- eastus2

## Filstruktur

```
├── main.bicep       # Huvud-template, skapar resource group
├── sentinel.bicep   # Skapar Log Analytics workspace och aktiverar Sentinel
└── README.md
```

## Analytic Rules & Workbooks

Analytic rules och workbooks hanteras inte av denna IaC-kod utan deployas via ett separat GitHub-repo kopplat till Sentinel Repositories. Se det repot för mer information om hur regler och workbooks deployas och synkas automatiskt.

## Notering

Om du får följande fel vid deployment:

```
The deployment 'MAIN' already exists in location 'westeurope'
```

Använd ett unikt namn med `--name`-flaggan, exempelvis `--name deploySentinel2`.
