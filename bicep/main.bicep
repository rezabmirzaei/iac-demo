targetScope = 'subscription'

var randomString = substring(uniqueString(subscription().id), 0, 3)
param location string = 'NorwayEast'
param rgName string // Passed in as parameter

param resourceTags object = {
  Owner: 'reza.b.mirzaei@outlook.com'
  Env: 'test'
}

resource resourceGroup 'Microsoft.Resources/resourceGroups@2022-09-01' = {
  name: '${rgName}-${randomString}'
  location: location
  tags: resourceTags
}

/*
module storageAccount './storage.bicep' = {
  name: 'storageAccount'
  scope: resourceGroup
  params: {
    location: location
  }
}
*/
