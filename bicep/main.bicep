targetScope = 'subscription'

var randomString = substring(uniqueString(subscription().id), 0, 3)
param location string = 'NorwayEast'

param resourceTags object = {
  Owner: 'reza.b.mirzaei@outlook.com'
  Env: 'test'
}

resource resourceGroup 'Microsoft.Resources/resourceGroups@2022-09-01' = {
  name: 'rg-iac-demo-bicep-${randomString}'
  location: location
  tags: resourceTags
}
