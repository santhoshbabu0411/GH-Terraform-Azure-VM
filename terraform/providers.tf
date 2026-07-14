terraform {
  required_version = ">= 1.8.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }

    time = {
      source  = "hashicorp/time"
      version = "~> 0.13"
    }
  }

  backend "azurerm" {}
}

provider "azurerm" {
  subscription_id = var.subscription_id

  features {}
}