
variable "ip_configuration_subnet_id" {}
variable "zone_name" {}
variable "storage_image_reference_id" {}
variable "network_security_group_id" {}
variable "databases" {}
variable "applications" {}
variable "rg_name" {}
variable "env" {}
variable "dns_record_rg_name" {}
variable "token" {}































# variable "ip_configuration_subnet_id" {
#   default = "/subscriptions/7d58fd8a-e8be-4f50-b9f6-03616700d9fc/resourceGroups/project-1/providers/Microsoft.Network/virtualNetworks/project-1-network/subnets/default"
# }
#
# variable "zone_name" {
#   default = "apps11.shop"
# }

#since it is declared in data.tf
# variable "location" {
# #   default = "UK West"
# # }
#
# # variable "rg_name" {
# #   default = "project-1"
# # }
#
# variable "storage_image_reference_id" {
#   default = "/subscriptions/7d58fd8a-e8be-4f50-b9f6-03616700d9fc/resourceGroups/project-1/providers/Microsoft.Compute/images/local-devops-practice"
# }
#
# variable "network_security_group_id" {
#   default = "/subscriptions/7d58fd8a-e8be-4f50-b9f6-03616700d9fc/resourceGroups/project-1/providers/Microsoft.Network/networkSecurityGroups/project-allow-all"
# }
#
# variable "databases" {
#   default = {
#     mongodb  = {}
#     rabbitmq = {}
#     mysql    = {}
#     redis    = {}
#   }
# }
#
# variable "applications" {
#   default = {
#     catalogue  = {}
#     user       = {}
#     cart       = {}
#     payment    = {}
#     shipping   = {}
#     frontend   = {}
#   }
# }

# variable "rg_name" {}
# variable "rg_location" {}
