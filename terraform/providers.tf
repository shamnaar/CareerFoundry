terraform {
  required_version = ">=0.12"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
    azuread = {
     source  = "hashicorp/azuread"
     version = "2.30.0"
    }
  }
}
provider "azurerm" {
  features {}
  
}