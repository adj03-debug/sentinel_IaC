targetScope = 'subscription'

param rgName string = 'rg-sentinel-test'
param location string = 'swedencentral'

resource rg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: rgName
  location: location
}

module sentinel './sentinel.bicep' = {
  name: 'deploySentinel'
  scope: rg
}
