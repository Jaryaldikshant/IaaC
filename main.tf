module "dev-infra" {
  source = "./infra-app"

  env = "dev"

  blob_name = "infra-app-blob"

  vm_count = 1

  vm_size = "Standard_DS1_v2"

  vm_name = "dev-vm"

  vm_publisher = "Canonical"

  vm_offer = "0001-com-ubuntu-server-focal"

  vm_sku = "20_04-lts" 

  vm_version = "latest"

  username = "Dazure"

  location = "Canada Central"

}


module "prd-infra" {
  source = "./infra-app"

  env = "prd"

  blob_name = "infra-app-blob"

  vm_count = 2

  vm_size = "Standard_DS1_v2"

  vm_name = "prd-vm"

  
  vm_publisher = "Canonical"

  
  vm_offer = "0001-com-ubuntu-server-focal"

  
  vm_sku = "20_04-lts" 

  
  vm_version = "latest"

  username = "Dazure"

  location = "Canada Central"


}


module "stg-infra" {
  source = "./infra-app"

  env = "stg"

  blob_name = "infra-app-blob"

  vm_count = 1

  vm_size = "Standard_B2s"

  vm_name = "stg-vm"

  vm_publisher = "Canonical"

  vm_offer = "0001-com-ubuntu-server-focal"
  
  vm_sku = "20_04-lts" 

  vm_version = "latest"

  username = "azureuser"

  location = "westeurope"


}