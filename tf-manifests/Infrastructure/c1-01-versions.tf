terraform {
  required_version = ">= 1.0.0"
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = ">= 2.0" #for devtest purpose
      #version = "~>2.89" #for production, 2.89, 2.90, 2.91 etc will be supported thisway
    }    
  }

  backend "azurerm" {
      resource_group_name = "myState"
      storage_account_name = "cloudbardstate01"
      container_name = "tfstate001"
      key            = "terraform.tfstate"
  }
}

provider "random" {
  
}

provider "azurerm" {
  features {}
}