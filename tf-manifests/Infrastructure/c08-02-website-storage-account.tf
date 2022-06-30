#Resource 1 - Create Storage Account
resource "azurerm_storage_account" "resume_static_storage" {
    
    name = "${var.storage_account_name}${random_string.myrandom.result}"
    resource_group_name = azurerm_resource_group.myResumeRG.name
    #resource_group_name = data.terraform_remote_state.infrastructure.outputs.resource_group_name
    location = azurerm_resource_group.myResumeRG.location
    #location = var.resource_group_location
    account_kind = var.storage_account_kind
    account_tier = var.storage_account_tier
    account_replication_type = var.storage_account_replication_type
    

    static_website {
        index_document     = var.static_website_index_document
        error_404_document = var.static_website_error_404_document
    }

}

#Resource 2 - Create Container for httpd files. This is not required if you are using static website container($web) itself

/* resource "azurerm_storage_container" "httpd_files_container" {
    name                  = "httpd-files-container"
    storage_account_name  = azurerm_storage_account.web_static_storage.name
    container_access_type = "private"
  
} */

# Locals Block for Static html files for Azure Application Gateway 
/* locals {
  pages = ["index.html", "error.html", "502.html", "403.html"]
} 
*/


# Resource-2: Add Static html files to blob storage
  /* resource "azurerm_storage_blob" "static_container_blob" {
    //for_each = toset(local.pages) # toset([])
    #name                   = each.value
    name                    = "frontend"
    storage_account_name   = azurerm_storage_account.resume_static_storage.name
    #storage_container_name = azurerm_storage_container.httpd_files_container.name
    storage_container_name = "$web"
    type                   = "Block"
    #content_type = "text/html"
    #source = "${path.cwd}/custom-error-pages/${each.value}"
    
    
  } 
  data "azurerm_storage_account_blob_container_sas" "website_blob_container_sas" {
  connection_string = azurerm_storage_account.resume_static_storage.primary_connection_string
  container_name    = "$web"

  
  start = "2022-01-01T00:00:00Z"
  expiry = "2023-01-01T00:00:00Z"

  permissions {
    read   = true
    add    = true
    create = true
    write  = true
    delete = false
    list   = true
    
  }

  }

  data "azurerm_storage_account_sas" "storage_account_sas"{

    connection_string = azurerm_storage_account.resume_static_storage.primary_connection_string

    resource_types {
      service = true
      container = true
      object = true
    }

    services {
      blob = true
      queue = false
      table = false
      file = false
    }
    start = "2022-01-01T00:00:00Z"
    expiry = "2023-01-01T00:00:00Z"

  permissions {
    read   = true
    add    = true
    create = true
    write  = true
    delete = false
    list   = true
    update = false
    process = false
  }


    
  }

#azcopy cp --from-to=LocalBlob "../../code/frontend" "https://${azurerm_storage_account.resume_static_storage.name}.blob.core.windows.net/$web${data.azurerm_storage_account_sas.storage_account_sas.sas}" --recursive 
#azcopy cp --from-to=LocalBlob "../../code/frontend" "https://${azurerm_storage_account.resume_static_storage.name}.blob.core.windows.net/$web${data.azurerm_storage_account_blob_container_sas.website_blob_container_sas.sas}" --recursive
#azcopy cp --from-to=LocalBlob "../../code/frontend/images/*" "https://${azurerm_storage_account.resume_static_storage.name}.blob.core.windows.net/web/images${data.azurerm_storage_account_blob_container_sas.website_blob_container_sas.sas}"  --recursive

  resource "null_resource" "frontend_files"{

    # depends_on = [data.azurerm_storage_account_blob_container_sas.website_blob_container_sas, 
    #               azurerm_storage_account.resume_static_storage,
    #               data.azurerm_storage_account_sas.storage_account_sas]

      triggers = {
        always_run = timestamp()
      }

      provisioner "local-exec" {
      interpreter = ["/bin/bash", "-c"]
      command = <<EOT
       
       echo " CWD -- > ${path.cwd}"
       azcopy cp  ../../code/frontend/ https://${azurerm_storage_account.resume_static_storage.name}.blob.core.windows.net/$web${data.azurerm_storage_account_sas.storage_account_sas.sas}
      
      
      
      EOT
      }

  }
   */


