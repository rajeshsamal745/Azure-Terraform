terraform {
  required_version = ">= 1.8.0, < 2.0.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "~> 3.6"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "random_pet" "suffix" {
  length    = 2
  separator = "-"
}

resource "azurerm_resource_group" "lab" {
  name     = "rg-tf-Day-01-${random_pet.suffix.id}"
  location = "indiasouthcentral"

  tags = {
    environment = "learning"
    managed_by  = "terraform"
    project     = "Day-01"
    owner       = "platform-engineering"
  }
}

output "resource_group_name" {
  description = "Name of the resource group created by Terraform."
  value       = azurerm_resource_group.lab.name
}

output "resource_group_location" {
  description = "Azure region containing the resource group."
  value       = azurerm_resource_group.lab.location
}
