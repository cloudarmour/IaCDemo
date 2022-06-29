resource "azurerm_cosmosdb_account" "mycosmosdbaccount" {
  name                = "mycosmosdbazureresume"
  location            = azurerm_resource_group.myResumeRG.location
  resource_group_name = azurerm_resource_group.myResumeRG.name
  offer_type          = "Standard"
  ##kind                = "MongoDB" Defaults to GlobalDocumentDb

  #enable_automatic_failover = true

  capabilities {
    #name = "EnableAggregationPipeline"
    name= "EnableServerless"
  }


  consistency_policy {
    consistency_level       = "BoundedStaleness"
    max_interval_in_seconds = 300
    max_staleness_prefix    = 100000
  }

 /*  geo_location {
    location          = var.failover_location
    failover_priority = 1
  }
 */
  geo_location {
    location          = azurerm_resource_group.myResumeRG.location
    failover_priority = 0
  }
}

resource "azurerm_cosmosdb_sql_database" "mycosmossqldb" {
  name                = "AzureResume"
  resource_group_name = azurerm_resource_group.myResumeRG.name
  account_name        = azurerm_cosmosdb_account.mycosmosdbaccount.name
  ##throughput          = 400 "Shared throughput database creation is not supported for serverless accounts"
}



resource "azurerm_cosmosdb_sql_container" "mycosmoscontainer" {
  name                  = "Counter"
  resource_group_name   = azurerm_resource_group.myResumeRG.name
  account_name          = azurerm_cosmosdb_account.mycosmosdbaccount.name
  database_name         = azurerm_cosmosdb_sql_database.mycosmossqldb.name
  #partition_key_path    = "/definition/id"
  partition_key_path    = "/id"
  ##partition_key_version = 1
  ##throughput            = 400

}