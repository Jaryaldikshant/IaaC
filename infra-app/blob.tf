resource "azurerm_resource_group" "state" {
  name     = "${var.env}-resource-group"
  location = var.location

  tags = {
        name = "${var.env}-infra-app-blob"
        environment = var.env
    }
}

resource "random_string" "storage_name" {
  length  = 6
  special = false
  upper   = false
}


resource "azurerm_storage_account" "state" {
    
  name                     = "${var.env}${random_string.storage_name.result}"  // should be different

  resource_group_name      = azurerm_resource_group.state.name

  location                 = azurerm_resource_group.state.location

  account_tier             = "Standard"

  account_replication_type = "LRS"
}



resource "azurerm_storage_container" "state" {
  name                  = "${var.env}-container"

  storage_account_id = azurerm_storage_account.state.id

  container_access_type = "blob"

}


// Output of the storage account name
output "storage_account_name" {
  value = azurerm_storage_account.state.name
}

// Output of the container name
output "container_name" {
    value = azurerm_storage_container.state.name 
}




