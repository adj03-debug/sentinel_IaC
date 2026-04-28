@description('Azure region for all resources')
param location string

@description('Name of the Log Analytics workspace')
param workspaceName string

@description('Number of days to retain data in Log Analytics (30-730)')
@minValue(30)
@maxValue(730)
param retentionInDays int = 90

resource logAnalytics 'Microsoft.OperationalInsights/workspaces@2021-06-01' = {
  name: workspaceName
  location: location
  properties: {
    sku: {
      name: 'PerGB2018'
    }
    retentionInDays: retentionInDays
  }
}

resource sentinel 'Microsoft.SecurityInsights/onboardingStates@2024-03-01' = {
  name: 'default'
  scope: logAnalytics
}
