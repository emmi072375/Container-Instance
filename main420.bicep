targetScope = 'subscription' 

param myResourceGroup string = 'ZellyTest420-rg'

@description('Name for the container group')
param containername string = 'emrancontainergroup'

@description('Location for all resources.')
param location string = 'swedencentral'

@description('Container image to deploy. Should be of the form repoName/imagename:tag for images stored in public Docker Hub, or a fully qualified URI for other registries. Images from private registries require additional registry credentials.')
param image string = 'mcr.microsoft.com/azuredocs/aci-helloworld'

@description('Port to open on the container and the public IP address.')
param port int = 80

@description('The number of CPU cores to allocate to the container.')
param cpuCores int = 1

@description('The amount of memory to allocate to the container in gigabytes.')
param memoryInGb int = 2

@description('The behavior of Azure runtime if container has stopped.')
@allowed([
  'Always'
  'Never'
  'OnFailure'
])
param restartPolicy string = 'Always'


//Create Resource Group 

resource myRG01 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: myResourceGroup
  location: location

}

module myContainerInstance 'containerinstance.bicep' = {
  name: 'containerInstanceDeployment'
  scope: myRG01
  params: {
    containername: containername
    location: location
    image: image
    port: port
    cpuCores: cpuCores
    memoryInGb: memoryInGb
    restartPolicy: restartPolicy
  }
}




