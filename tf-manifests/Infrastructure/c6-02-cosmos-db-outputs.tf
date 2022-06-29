#place holder file

output "cosmos_db_connection_string" {
  
  value = azurerm_cosmosdb_account.mycosmosdbaccount.connection_strings
  sensitive = true
  
}