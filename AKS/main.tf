terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.107"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "main" {
  name     = "rg-demo"
  location = "westeurope"
}

# Compte de stockage (Blob Storage)
resource "azurerm_storage_account" "main" {
  name                     = "storagedemotf123" # doit être unique globalement
  resource_group_name      = azurerm_resource_group.main.name
  location                 = azurerm_resource_group.main.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "blob" {
  name                  = "mycontainer"
  storage_account_name  = azurerm_storage_account.main.name
  container_access_type = "private"
}

# Compte Cosmos DB (Table API = équivalent DynamoDB)
resource "azurerm_cosmosdb_account" "main" {
  name                = "cosmosdbdemotf123" # doit être unique globalement
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  offer_type          = "Standard"
  kind                = "GlobalDocumentDB"

  consistency_policy {
    consistency_level = "Session"
  }

  geo_location {
    location          = azurerm_resource_group.main.location
    failover_priority = 0
  }

  capabilities {
    name = "EnableTable"
  }
}

resource "azurerm_cosmosdb_table" "table" {
  name                = "mytable"
  resource_group_name = azurerm_resource_group.main.name
  account_name        = azurerm_cosmosdb_account.main.name
  throughput          = 400
}
