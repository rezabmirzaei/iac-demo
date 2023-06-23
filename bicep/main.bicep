targetScope = 'subscription'

var randomString = substring(uniqueString(subscription().id), 0, 3)
param location string = 'NorwayEast'

param resourceTags object = {
  Owner: 'reza.b.mirzaei@outlook.com'
  Env: 'test'
}

resource resourceGroup 'Microsoft.Resources/resourceGroups@2022-09-01' = {
  name: 'rg-iac-demo-bicep-${randomString}'
  //name: 'rg-iac-demo-bicep'
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
