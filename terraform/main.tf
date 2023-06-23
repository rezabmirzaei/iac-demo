terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.2"
    }
  }
  required_version = ">= 1.1.0"
}

provider "azurerm" {
  features {}
}

resource "random_string" "random_suffix" {
  length  = 3
  special = false
  upper   = false
}

resource "azurerm_resource_group" "rg" {
  name     = "rg-iac-demo-terraform-${random_string.random_suffix.result}"
  location = "NorwayEast"
  tags = {
    "Owner" = "reza.b.mirzaei"
    "Env"   = "test"
  }
}
