@description('Name for the container group')
param containername string 

@description('Location for all resources.')
param location string 

@description('Container image to deploy. Should be of the form repoName/imagename:tag for images stored in public Docker Hub, or a fully qualified URI for other registries. Images from private registries require additional registry credentials.')
param image string 

@description('Port to open on the container and the public IP address.')
param port int 

@description('The number of CPU cores to allocate to the container.')
param cpuCores int

@description('The amount of memory to allocate to the container in gigabytes.')
param memoryInGb int

@description('The behavior of Azure runtime if container has stopped.')
@allowed([
  'Always'
  'Never'
  'OnFailure'
])
param restartPolicy string 

resource containerGroup 'Microsoft.ContainerInstance/containerGroups@2021-09-01' = {
  name: containername
  location: location
  properties: {
    containers: [
      {
        name: containername
        properties: {
          image: image
          ports: [
            {
              port: port
              protocol: 'TCP'
            }
          ]
          resources: {
            requests: {
              cpu: cpuCores
              memoryInGB: memoryInGb
            }
          }
        }
      }
    ]
    osType: 'Linux'
    restartPolicy: restartPolicy
    ipAddress: {
      type: 'Public'
      ports: [
        {
          port: port
          protocol: 'TCP'
        }
      ]
    }
  }
}
