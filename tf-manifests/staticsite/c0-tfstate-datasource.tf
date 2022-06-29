data "terraform_remote_state" "infrastructure" {
    backend = "azurerm"
    config = {
        resource_group_name = "myState"
        storage_account_name = "cloudbardstate01"
        container_name = "tfstate001"
        key            = "terraform.tfstate"
    }
  
}