resource "azurerm_resource_group" "myResumeRG" {
    #name = "${local.resource_name_prefix}-${var.resource_group_name}" to avoid name conflicts due to caching in azure
    name= "${local.resource_name_prefix}-${var.resource_group_name}-${random_string.myrandom.result}" #myrandom.id is also valid
    location = var.resource_group_location
    tags = local.common_tags
  
}