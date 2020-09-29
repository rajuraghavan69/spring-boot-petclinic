provider "azurerm" {
  version = "= 2.20.0"
  features {}
}

resource "azurerm_resource_group" "rg_mqk" {
  name     = var.resource_group_name
  location = var.location
}

