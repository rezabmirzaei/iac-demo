@allowed([
  'Standard_LRS'
  'Standard_GRS'
  'Standard_RAGRS'
  'Standard_ZRS'
  'Premium_LRS'
  'Premium_ZRS'
  'Standard_GZRS'
  'Standard_RAGZRS'
])
param storageSKU string = 'Standard_LRS'
param location string = resourceGroup().location
param resourceTags object = {
  Owner: 'reza.b.mirzaei@outlook.com'
  Env: 'test'
}

resource storageAccount 'Microsoft.Storage/storageAccounts@2022-09-01' = {
  name: 'stiacdemobicep001'
  location: location
  sku: {
    name: storageSKU
  }
  kind: 'StorageV2'
  properties: {
    supportsHttpsTrafficOnly: true
  }
  tags: resourceTags
}
