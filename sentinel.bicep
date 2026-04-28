targetScope = 'subscription'

@description('Name of the resource group')
param rgName string

@description('Azure region for all resources')
@allowed([
  'swedencentral'
  'westeurope'
  'northeurope'
  'germanywestcentral'
  'norwayeast'
  'uksouth'
  'eastus'
  'eastus2'
])
param location string

@description('Name of the Log Analytics workspace')
param workspaceName string

@description('Number of days to retain data in Log Analytics (30-730)')
@minValue(30)
@maxValue(730)
param retentionInDays int = 90

resource rg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: rgName
  location: location
}

module sentinel './sentinel.bicep' = {
  name: 'deploySentinel'
  scope: rg
  params: {
    location: location
    workspaceName: workspaceName
    retentionInDays: retentionInDays
  }
}
