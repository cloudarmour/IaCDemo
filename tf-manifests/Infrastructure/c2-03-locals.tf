locals {
    owner= var.Business_Division
    environment = var.environment
    resource_name_prefix = "${var.resource_group_location}-${var.Business_Division}-${var.environment}"
   
  #You can call this block using local.common_tags in your tf files.
   common_tags = { 
       owner = local.owner,
       environment = local.environment
        ##This is a map. hence key value pairs separated by comma. 
   }

   locals {
  func_app_name = "GetResumeCounter"
  }

  #  agw_inbound_ports_map = {
  #   "100" : "80", # If the key starts with a number, you must use the colon syntax ":" instead of "="
  #   "110" : "443",
  #   "130" : "65200-65535"
  # }


}