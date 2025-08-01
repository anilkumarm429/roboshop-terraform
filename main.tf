module "resource-group" {
  for_each = var.rg_name
  source   = "./modules/resource-group"
  name     = "${each.key}-${var.env}"
  location = each.value["location"]
}

module "vnet" {
  for_each            = var.vnets
  source              = "./modules/vnet"
  address_space       = each.value["address_space"]
  location            = module.resource-group[each.value["rgname"]].location
  name                = each.key
  resource_group_name = module.resource-group[each.value["rgname"]].name
  subnets             = each.value["subnets"]
  env                 = var.env
  tools_vnet_resource_id    = var.tools_vnet_resource_id
}

output "subnet_ids" {
  value = module.vnet["main-dev"].subnet_id["main"].address_prefixes
}

module "databases" {
  for_each                   = var.databases
  source                     = "./modules/vm"
  ip_configuration_subnet_id = module.vnet["${each.value["vnet_prefix"]}-${var.env}"].subnet_id[each.value["subnet"]].id
  name                       = each.key
  rg_name                    = module.resource-group[each.value["rgname"]].name
  rg_location                = module.resource-group[each.value["rgname"]].location
  storage_image_reference_id = var.storage_image_reference_id
  zone_name                  = var.zone_name
  dns_record_rg_name         = var.dns_record_rg_name
  token                      = var.token
  type                       = "db"
  vm_size                    = each.value["vm_size"]
}

# module "applications" {
#   depends_on                 = [module.databases]
#   for_each                   = var.applications
#   source                     = "./modules/vm"
#   ip_configuration_subnet_id = var.ip_configuration_subnet_id
#   name                       = each.key
#   rg_name                    = module.resource-group[each.value["rgname"]].name
#   rg_location                = module.resource-group[each.value["rgname"]].location
#   storage_image_reference_id = var.storage_image_reference_id
#   zone_name                  = var.zone_name
#   network_security_group_id  = var.network_security_group_id
#   dns_record_rg_name         = var.dns_record_rg_name
#   token                      = var.token
#   type                       = "app"
# }

# output "rg" {
#   value = "module.resource-group"
# }
#
# module "aks" {
#   for_each    = var.aks
#   source      = "./modules/aks"
#   name        = each.key
#   rg_name     = module.resource-group[each.value["rgname"]].name
#   rg_location = module.resource-group[each.value["rgname"]].location
#   env         = var.env
#   token       = var.token
#   default_node_pool = each.value["default_node_pool"]
#   app_node_pool     = each.value["app_node_pool"]
#   vnet_subnet_id    = var.ip_configuration_subnet_id
# }


# module "databases" {
#   for_each                   = var.databases
#   source                     = "modules/vm"
#   ip_configuration_subnet_id = var.ip_configuration_subnet_id
#   # location                   = var.location since it is declared in data.tf
#   name                       = each.key
#   rg_name                    = var.rg_name
#   storage_image_reference_id = var.storage_image_reference_id
#   zone_name                  = var.zone_name
#   network_security_group_id  = var.network_security_group_id
# }
#
# module "applications" {
#   depends_on                 = [module.databases]
#   for_each                   = var.applications
#   source                     = "modules/vm"
#   ip_configuration_subnet_id = var.ip_configuration_subnet_id
#   # location                   = var.location since it is declared in data.tf
#   name                       = each.key
#   rg_name                    = var.rg_name
#   storage_image_reference_id = var.storage_image_reference_id
#   zone_name                  = var.zone_name
#   network_security_group_id  = var.network_security_group_id
# }













# module "mongodb" {
#   source                     = "./component"
#   ip_configuration_subnet_id = var.ip_configuration_subnet_id
#   location                   = var.location
#   name                       = "mongodb"
#   rg_name                    = var.rg_name
#   storage_image_reference_id = var.storage_image_reference_id
#   zone_name                  = var.zone_name
#   network_security_group_id  = var.network_security_group_id
# }

# module "catalogue" {
#   source                     = "./component"
#   ip_configuration_subnet_id = var.ip_configuration_subnet_id
#   location                   = var.location
#   name                       = "catalogue"
#   rg_name                    = var.rg_name
#   storage_image_reference_id = var.storage_image_reference_id
#   zone_name                  = var.zone_name
#   network_security_group_id  = var.network_security_group_id
# }

# module "user" {
#   source                     = "./component"
#   ip_configuration_subnet_id = var.ip_configuration_subnet_id
#   location                   = var.location
#   name                       = "user"
#   rg_name                    = var.rg_name
#   storage_image_reference_id = var.storage_image_reference_id
#   zone_name                  = var.zone_name
#   network_security_group_id  = var.network_security_group_id
# }
#
# module "redis" {
#   source                     = "./component"
#   ip_configuration_subnet_id = var.ip_configuration_subnet_id
#   location                   = var.location
#   name                       = "redis"
#   rg_name                    = var.rg_name
#   storage_image_reference_id = var.storage_image_reference_id
#   zone_name                  = var.zone_name
#   network_security_group_id  = var.network_security_group_id
# }
# module "cart" {
#   source                     = "./component"
#   ip_configuration_subnet_id = var.ip_configuration_subnet_id
#   location                   = var.location
#   name                       = "cart"
#   rg_name                    = var.rg_name
#   storage_image_reference_id = var.storage_image_reference_id
#   zone_name                  = var.zone_name
#   network_security_group_id  = var.network_security_group_id
# }
# module "mysql" {
#   source                     = "./component"
#   ip_configuration_subnet_id = var.ip_configuration_subnet_id
#   location                   = var.location
#   name                       = "mysql"
#   rg_name                    = var.rg_name
#   storage_image_reference_id = var.storage_image_reference_id
#   zone_name                  = var.zone_name
#   network_security_group_id  = var.network_security_group_id
# }
# module "shipping" {
#   source                     = "./component"
#   ip_configuration_subnet_id = var.ip_configuration_subnet_id
#   location                   = var.location
#   name                       = "shipping"
#   rg_name                    = var.rg_name
#   storage_image_reference_id = var.storage_image_reference_id
#   zone_name                  = var.zone_name
#   network_security_group_id  = var.network_security_group_id
# }
# module "payment" {
#   source                     = "./component"
#   ip_configuration_subnet_id = var.ip_configuration_subnet_id
#   location                   = var.location
#   name                       = "payment"
#   rg_name                    = var.rg_name
#   storage_image_reference_id = var.storage_image_reference_id
#   zone_name                  = var.zone_name
#   network_security_group_id  = var.network_security_group_id
# }
# module "rabbitmq" {
#   source                     = "./component"
#   ip_configuration_subnet_id = var.ip_configuration_subnet_id
#   location                   = var.location
#   name                       = "rabbitmq"
#   rg_name                    = var.rg_name
#   storage_image_reference_id = var.storage_image_reference_id
#   zone_name                  = var.zone_name
#   network_security_group_id  = var.network_security_group_id
# }
































#
# resource "azurerm_public_ip" "frontend" {
#   name                = "frontend"
#   location            = "UK West"
#   resource_group_name = "project-1"
#   allocation_method   = "Static"
# }
#
# data "azurerm_network_security_group" "project_allow_all" {
#   name                = "project-allow-all"
#   resource_group_name = "project-1"
# }
#
#
# resource "azurerm_network_interface" "frontend" {
#   name                = "frontend"
#   location            = "UK West"
#   resource_group_name = "project-1"
#
#   ip_configuration {
#     name                          = "frontend"
#     subnet_id                     = "/subscriptions/7d58fd8a-e8be-4f50-b9f6-03616700d9fc/resourceGroups/project-1/providers/Microsoft.Network/virtualNetworks/project-1-network/subnets/default"
#     private_ip_address_allocation = "Dynamic"
#     public_ip_address_id          = azurerm_public_ip.frontend.id
#   }
# }
#
# resource "azurerm_network_interface_security_group_association" "frontend_nsg_assoc" {
#   network_interface_id      = azurerm_network_interface.frontend.id
#   network_security_group_id = data.azurerm_network_security_group.project_allow_all.id
# }
#
#
# resource "azurerm_virtual_machine" "frontend" {
#   name                  = "frontend"
#   location              = "UK West"
#   resource_group_name   = "project-1"
#   network_interface_ids = [azurerm_network_interface.frontend.id]
#   vm_size               = "Standard_B2s"
#
#   delete_os_disk_on_termination = true
#
#   storage_image_reference {
#     id = "/subscriptions/7d58fd8a-e8be-4f50-b9f6-03616700d9fc/resourceGroups/project-1/providers/Microsoft.Compute/images/local-devops-practice"
#   }
#   storage_os_disk {
#     name              = "frontend-disk"
#     caching           = "ReadWrite"
#     create_option     = "FromImage"
#     managed_disk_type = "Standard_LRS"
#   }
#   os_profile {
#     computer_name  = "frontend"
#     admin_username = "azuser"
#     admin_password = "Devops@12345"
#   }
#   os_profile_linux_config {
#     disable_password_authentication = false
#   }
# }
#
#
#
# resource "azurerm_public_ip" "mongodb" {
#   name                = "mongodb"
#   location            = "UK West"
#   resource_group_name = "project-1"
#   allocation_method   = "Static"
# }
#
# resource "azurerm_network_interface" "mongodb" {
#   name                = "mongodb"
#   location            = "UK West"
#   resource_group_name = "project-1"
#
#   ip_configuration {
#     name                          = "mongodb"
#     subnet_id                     = "/subscriptions/7d58fd8a-e8be-4f50-b9f6-03616700d9fc/resourceGroups/project-1/providers/Microsoft.Network/virtualNetworks/project-1-network/subnets/default"
#     private_ip_address_allocation = "Dynamic"
#     public_ip_address_id          = azurerm_public_ip.mongodb.id
#   }
# }
#
# resource "azurerm_virtual_machine" "mongodb" {
#   name                  = "mongodb"
#   location              = "UK West"
#   resource_group_name   = "project-1"
#   network_interface_ids = [azurerm_network_interface.mongodb.id]
#   vm_size               = "Standard_B2s"
#
#   delete_os_disk_on_termination = true
#
#   storage_image_reference {
#     id = "/subscriptions/7d58fd8a-e8be-4f50-b9f6-03616700d9fc/resourceGroups/project-1/providers/Microsoft.Compute/images/local-devops-practice"
#   }
#   storage_os_disk {
#     name              = "mongodb-disk"
#     caching           = "ReadWrite"
#     create_option     = "FromImage"
#     managed_disk_type = "Standard_LRS"
#   }
#   os_profile {
#     computer_name  = "mongodb"
#     admin_username = "azuser"
#     admin_password = "Devops@12345"
#   }
#   os_profile_linux_config {
#     disable_password_authentication = false
#   }
# }
#
#
# resource "azurerm_public_ip" "catalogue" {
#   name                = "catalogue"
#   location            = "UK West"
#   resource_group_name = "project-1"
#   allocation_method   = "Static"
# }
#
# resource "azurerm_network_interface" "catalogue" {
#   name                = "catalogue"
#   location            = "UK West"
#   resource_group_name = "project-1"
#
#   ip_configuration {
#     name                          = "catalogue"
#     subnet_id                     = "/subscriptions/7d58fd8a-e8be-4f50-b9f6-03616700d9fc/resourceGroups/project-1/providers/Microsoft.Network/virtualNetworks/project-1-network/subnets/default"
#     private_ip_address_allocation = "Dynamic"
#     public_ip_address_id          = azurerm_public_ip.catalogue.id
#   }
# }
#
# resource "azurerm_virtual_machine" "catalogue" {
#   name                  = "catalogue"
#   location              = "UK West"
#   resource_group_name   = "project-1"
#   network_interface_ids = [azurerm_network_interface.catalogue.id]
#   vm_size               = "Standard_B2s"
#
#   delete_os_disk_on_termination = true
#
#   storage_image_reference {
#     id = "/subscriptions/7d58fd8a-e8be-4f50-b9f6-03616700d9fc/resourceGroups/project-1/providers/Microsoft.Compute/images/local-devops-practice"
#   }
#   storage_os_disk {
#     name              = "catalogue-disk"
#     caching           = "ReadWrite"
#     create_option     = "FromImage"
#     managed_disk_type = "Standard_LRS"
#   }
#   os_profile {
#     computer_name  = "catalogue"
#     admin_username = "azuser"
#     admin_password = "Devops@12345"
#   }
#   os_profile_linux_config {
#     disable_password_authentication = false
#   }
# }
#
#
# resource "azurerm_public_ip" "redis" {
#   name                = "redis"
#   location            = "UK West"
#   resource_group_name = "project-1"
#   allocation_method   = "Static"
# }
#
# resource "azurerm_network_interface" "redis" {
#   name                = "redis"
#   location            = "UK West"
#   resource_group_name = "project-1"
#
#   ip_configuration {
#     name                          = "redis"
#     subnet_id                     = "/subscriptions/7d58fd8a-e8be-4f50-b9f6-03616700d9fc/resourceGroups/project-1/providers/Microsoft.Network/virtualNetworks/project-1-network/subnets/default"
#     private_ip_address_allocation = "Dynamic"
#     public_ip_address_id          = azurerm_public_ip.redis.id
#   }
# }
#
# resource "azurerm_virtual_machine" "redis" {
#   name                  = "redis"
#   location              = "UK West"
#   resource_group_name   = "project-1"
#   network_interface_ids = [azurerm_network_interface.redis.id]
#   vm_size               = "Standard_B2s"
#
#   delete_os_disk_on_termination = true
#
#   storage_image_reference {
#     id = "/subscriptions/7d58fd8a-e8be-4f50-b9f6-03616700d9fc/resourceGroups/project-1/providers/Microsoft.Compute/images/local-devops-practice"
#   }
#   storage_os_disk {
#     name              = "redis-disk"
#     caching           = "ReadWrite"
#     create_option     = "FromImage"
#     managed_disk_type = "Standard_LRS"
#   }
#   os_profile {
#     computer_name  = "redis"
#     admin_username = "azuser"
#     admin_password = "Devops@12345"
#   }
#   os_profile_linux_config {
#     disable_password_authentication = false
#   }
# }
#
# resource "azurerm_public_ip" "user" {
#   name                = "user"
#   location            = "UK West"
#   resource_group_name = "project-1"
#   allocation_method   = "Static"
# }
#
# resource "azurerm_network_interface" "user" {
#   name                = "user"
#   location            = "UK West"
#   resource_group_name = "project-1"
#
#   ip_configuration {
#     name                          = "user"
#     subnet_id                     = "/subscriptions/7d58fd8a-e8be-4f50-b9f6-03616700d9fc/resourceGroups/project-1/providers/Microsoft.Network/virtualNetworks/project-1-network/subnets/default"
#     private_ip_address_allocation = "Dynamic"
#     public_ip_address_id          = azurerm_public_ip.user.id
#   }
# }
#
# resource "azurerm_virtual_machine" "user" {
#   name                  = "user"
#   location              = "UK West"
#   resource_group_name   = "project-1"
#   network_interface_ids = [azurerm_network_interface.user.id]
#   vm_size               = "Standard_B2s"
#
#   delete_os_disk_on_termination = true
#
#   storage_image_reference {
#     id = "/subscriptions/7d58fd8a-e8be-4f50-b9f6-03616700d9fc/resourceGroups/project-1/providers/Microsoft.Compute/images/local-devops-practice"
#   }
#   storage_os_disk {
#     name              = "user-disk"
#     caching           = "ReadWrite"
#     create_option     = "FromImage"
#     managed_disk_type = "Standard_LRS"
#   }
#   os_profile {
#     computer_name  = "user"
#     admin_username = "azuser"
#     admin_password = "Devops@12345"
#   }
#   os_profile_linux_config {
#     disable_password_authentication = false
#   }
# }
#
# resource "azurerm_public_ip" "cart" {
#   name                = "cart"
#   location            = "UK West"
#   resource_group_name = "project-1"
#   allocation_method   = "Static"
# }
#
# resource "azurerm_network_interface" "cart" {
#   name                = "cart"
#   location            = "UK West"
#   resource_group_name = "project-1"
#
#   ip_configuration {
#     name                          = "cart"
#     subnet_id                     = "/subscriptions/7d58fd8a-e8be-4f50-b9f6-03616700d9fc/resourceGroups/project-1/providers/Microsoft.Network/virtualNetworks/project-1-network/subnets/default"
#     private_ip_address_allocation = "Dynamic"
#     public_ip_address_id          = azurerm_public_ip.cart.id
#   }
# }
#
# resource "azurerm_virtual_machine" "cart" {
#   name                  = "cart"
#   location              = "UK West"
#   resource_group_name   = "project-1"
#   network_interface_ids = [azurerm_network_interface.cart.id]
#   vm_size               = "Standard_B2s"
#
#   delete_os_disk_on_termination = true
#
#   storage_image_reference {
#     id = "/subscriptions/7d58fd8a-e8be-4f50-b9f6-03616700d9fc/resourceGroups/project-1/providers/Microsoft.Compute/images/local-devops-practice"
#   }
#   storage_os_disk {
#     name              = "cart-disk"
#     caching           = "ReadWrite"
#     create_option     = "FromImage"
#     managed_disk_type = "Standard_LRS"
#   }
#   os_profile {
#     computer_name  = "cart"
#     admin_username = "azuser"
#     admin_password = "Devops@12345"
#   }
#   os_profile_linux_config {
#     disable_password_authentication = false
#   }
# }
#
# resource "azurerm_public_ip" "mysql" {
#   name                = "mysql"
#   location            = "UK West"
#   resource_group_name = "project-1"
#   allocation_method   = "Static"
# }
#
# resource "azurerm_network_interface" "mysql" {
#   name                = "mysql"
#   location            = "UK West"
#   resource_group_name = "project-1"
#
#   ip_configuration {
#     name                          = "mysql"
#     subnet_id                     = "/subscriptions/7d58fd8a-e8be-4f50-b9f6-03616700d9fc/resourceGroups/project-1/providers/Microsoft.Network/virtualNetworks/project-1-network/subnets/default"
#     private_ip_address_allocation = "Dynamic"
#     public_ip_address_id          = azurerm_public_ip.mysql.id
#   }
# }
#
# resource "azurerm_virtual_machine" "mysql" {
#   name                  = "mysql"
#   location              = "UK West"
#   resource_group_name   = "project-1"
#   network_interface_ids = [azurerm_network_interface.mysql.id]
#   vm_size               = "Standard_B2s"
#
#   delete_os_disk_on_termination = true
#
#   storage_image_reference {
#     id = "/subscriptions/7d58fd8a-e8be-4f50-b9f6-03616700d9fc/resourceGroups/project-1/providers/Microsoft.Compute/images/local-devops-practice"
#   }
#   storage_os_disk {
#     name              = "mysql-disk"
#     caching           = "ReadWrite"
#     create_option     = "FromImage"
#     managed_disk_type = "Standard_LRS"
#   }
#   os_profile {
#     computer_name  = "mysql"
#     admin_username = "azuser"
#     admin_password = "Devops@12345"
#   }
#   os_profile_linux_config {
#     disable_password_authentication = false
#   }
# }
#
# resource "azurerm_public_ip" "shipping" {
#   name                = "shipping"
#   location            = "UK West"
#   resource_group_name = "project-1"
#   allocation_method   = "Static"
# }
#
# resource "azurerm_network_interface" "shipping" {
#   name                = "shipping"
#   location            = "UK West"
#   resource_group_name = "project-1"
#
#   ip_configuration {
#     name                          = "shipping"
#     subnet_id                     = "/subscriptions/7d58fd8a-e8be-4f50-b9f6-03616700d9fc/resourceGroups/project-1/providers/Microsoft.Network/virtualNetworks/project-1-network/subnets/default"
#     private_ip_address_allocation = "Dynamic"
#     public_ip_address_id          = azurerm_public_ip.shipping.id
#   }
# }
#
# resource "azurerm_virtual_machine" "shipping" {
#   name                  = "shipping"
#   location              = "UK West"
#   resource_group_name   = "project-1"
#   network_interface_ids = [azurerm_network_interface.shipping.id]
#   vm_size               = "Standard_B2s"
#
#   delete_os_disk_on_termination = true
#
#   storage_image_reference {
#     id = "/subscriptions/7d58fd8a-e8be-4f50-b9f6-03616700d9fc/resourceGroups/project-1/providers/Microsoft.Compute/images/local-devops-practice"
#   }
#   storage_os_disk {
#     name              = "shipping-disk"
#     caching           = "ReadWrite"
#     create_option     = "FromImage"
#     managed_disk_type = "Standard_LRS"
#   }
#   os_profile {
#     computer_name  = "shipping"
#     admin_username = "azuser"
#     admin_password = "Devops@12345"
#   }
#   os_profile_linux_config {
#     disable_password_authentication = false
#   }
# }
#
# resource "azurerm_public_ip" "rabbitmq" {
#   name                = "rabbitmq"
#   location            = "UK West"
#   resource_group_name = "project-1"
#   allocation_method   = "Static"
# }
#
# resource "azurerm_network_interface" "rabbitmq" {
#   name                = "rabbitmq"
#   location            = "UK West"
#   resource_group_name = "project-1"
#
#   ip_configuration {
#     name                          = "rabbitmq"
#     subnet_id                     = "/subscriptions/7d58fd8a-e8be-4f50-b9f6-03616700d9fc/resourceGroups/project-1/providers/Microsoft.Network/virtualNetworks/project-1-network/subnets/default"
#     private_ip_address_allocation = "Dynamic"
#     public_ip_address_id          = azurerm_public_ip.rabbitmq.id
#   }
# }
#
# resource "azurerm_virtual_machine" "rabbitmq" {
#   name                  = "rabbitmq"
#   location              = "UK West"
#   resource_group_name   = "project-1"
#   network_interface_ids = [azurerm_network_interface.rabbitmq.id]
#   vm_size               = "Standard_B2s"
#
#   delete_os_disk_on_termination = true
#
#   storage_image_reference {
#     id = "/subscriptions/7d58fd8a-e8be-4f50-b9f6-03616700d9fc/resourceGroups/project-1/providers/Microsoft.Compute/images/local-devops-practice"
#   }
#   storage_os_disk {
#     name              = "rabbitmq-disk"
#     caching           = "ReadWrite"
#     create_option     = "FromImage"
#     managed_disk_type = "Standard_LRS"
#   }
#   os_profile {
#     computer_name  = "rabbitmq"
#     admin_username = "azuser"
#     admin_password = "Devops@12345"
#   }
#   os_profile_linux_config {
#     disable_password_authentication = false
#   }
# }
#
# resource "azurerm_public_ip" "payment" {
#   name                = "payment"
#   location            = "UK West"
#   resource_group_name = "project-1"
#   allocation_method   = "Static"
# }
#
# resource "azurerm_network_interface" "payment" {
#   name                = "payment"
#   location            = "UK West"
#   resource_group_name = "project-1"
#
#   ip_configuration {
#     name                          = "payment"
#     subnet_id                     = "/subscriptions/7d58fd8a-e8be-4f50-b9f6-03616700d9fc/resourceGroups/project-1/providers/Microsoft.Network/virtualNetworks/project-1-network/subnets/default"
#     private_ip_address_allocation = "Dynamic"
#     public_ip_address_id          = azurerm_public_ip.payment.id
#   }
# }
#
# resource "azurerm_virtual_machine" "payment" {
#   name                  = "payment"
#   location              = "UK West"
#   resource_group_name   = "project-1"
#   network_interface_ids = [azurerm_network_interface.payment.id]
#   vm_size               = "Standard_B2s"
#
#   delete_os_disk_on_termination = true
#
#   storage_image_reference {
#     id = "/subscriptions/7d58fd8a-e8be-4f50-b9f6-03616700d9fc/resourceGroups/project-1/providers/Microsoft.Compute/images/local-devops-practice"
#   }
#   storage_os_disk {
#     name              = "payment-disk"
#     caching           = "ReadWrite"
#     create_option     = "FromImage"
#     managed_disk_type = "Standard_LRS"
#   }
#   os_profile {
#     computer_name  = "payment"
#     admin_username = "azuser"
#     admin_password = "Devops@12345"
#   }
#   os_profile_linux_config {
#     disable_password_authentication = false
#   }
# }
#
# resource "azurerm_public_ip" "dispatch" {
#   name                = "dispatch"
#   location            = "UK West"
#   resource_group_name = "project-1"
#   allocation_method   = "Static"
# }
#
# resource "azurerm_network_interface" "dispatch" {
#   name                = "dispatch"
#   location            = "UK West"
#   resource_group_name = "project-1"
#
#   ip_configuration {
#     name                          = "dispatch"
#     subnet_id                     = "/subscriptions/7d58fd8a-e8be-4f50-b9f6-03616700d9fc/resourceGroups/project-1/providers/Microsoft.Network/virtualNetworks/project-1-network/subnets/default"
#     private_ip_address_allocation = "Dynamic"
#     public_ip_address_id          = azurerm_public_ip.dispatch.id
#   }
# }
#
# resource "azurerm_virtual_machine" "dispatch" {
#   name                  = "dispatch"
#   location              = "UK West"
#   resource_group_name   = "project-1"
#   network_interface_ids = [azurerm_network_interface.dispatch.id]
#   vm_size               = "Standard_B2s"
#
#   delete_os_disk_on_termination = true
#
#   storage_image_reference {
#     id = "/subscriptions/7d58fd8a-e8be-4f50-b9f6-03616700d9fc/resourceGroups/project-1/providers/Microsoft.Compute/images/local-devops-practice"
#   }
#   storage_os_disk {
#     name              = "dispatch-disk"
#     caching           = "ReadWrite"
#     create_option     = "FromImage"
#     managed_disk_type = "Standard_LRS"
#   }
#   os_profile {
#     computer_name  = "dispatch"
#     admin_username = "azuser"
#     admin_password = "Devops@12345"
#   }
#   os_profile_linux_config {
#     disable_password_authentication = false
#   }
# }
#
# resource "azurerm_dns_a_record" "frontend" {
#   name                = "frontend-dev"
#   zone_name           = "apps11.shop"
#   resource_group_name = "project-1"
#   ttl                 = 3
#   records             = [azurerm_network_interface.frontend.private_ip_address]
# }
#
# resource "azurerm_dns_a_record" "catalogue" {
#   name                = "catalogue-dev"
#   zone_name           = "apps11.shop"
#   resource_group_name = "project-1"
#   ttl                 = 3
#   records             = [azurerm_network_interface.catalogue.private_ip_address]
# }
#
# resource "azurerm_dns_a_record" "mongodb" {
#   name                = "mongodb-dev"
#   zone_name           = "apps11.shop"
#   resource_group_name = "project-1"
#   ttl                 = 3
#   records             = [azurerm_network_interface.mongodb.private_ip_address]
# }
#
# resource "azurerm_dns_a_record" "redis" {
#   name                = "redis-dev"
#   zone_name           = "apps11.shop"
#   resource_group_name = "project-1"
#   ttl                 = 3
#   records             = [azurerm_network_interface.redis.private_ip_address]
# }
#
#
# resource "azurerm_dns_a_record" "rabbitmq" {
#   name                = "rabbitmq-dev"
#   zone_name           = "apps11.shop"
#   resource_group_name = "project-1"
#   ttl                 = 3
#   records             = [azurerm_network_interface.rabbitmq.private_ip_address]
# }
#
#
# resource "azurerm_dns_a_record" "mysql" {
#   name                = "mysql-dev"
#   zone_name           = "apps11.shop"
#   resource_group_name = "project-1"
#   ttl                 = 3
#   records             = [azurerm_network_interface.mysql.private_ip_address]
# }
#
#
# resource "azurerm_dns_a_record" "user" {
#   name                = "user-dev"
#   zone_name           = "apps11.shop"
#   resource_group_name = "project-1"
#   ttl                 = 3
#   records             = [azurerm_network_interface.user.private_ip_address]
# }
#
#
# resource "azurerm_dns_a_record" "cart" {
#   name                = "cart-dev"
#   zone_name           = "apps11.shop"
#   resource_group_name = "project-1"
#   ttl                 = 3
#   records             = [azurerm_network_interface.cart.private_ip_address]
# }
#
#
# resource "azurerm_dns_a_record" "shipping" {
#   name                = "shipping-dev"
#   zone_name           = "apps11.shop"
#   resource_group_name = "project-1"
#   ttl                 = 3
#   records             = [azurerm_network_interface.shipping.private_ip_address]
# }
#
#
# resource "azurerm_dns_a_record" "payment" {
#   name                = "payment-dev"
#   zone_name           = "apps11.shop"
#   resource_group_name = "project-1"
#   ttl                 = 3
#   records             = [azurerm_network_interface.payment.private_ip_address]
# }
#
# resource "azurerm_dns_a_record" "dispatch" {
#   name                = "dispatch-dev"
#   zone_name           = "apps11.shop"
#   resource_group_name = "project-1"
#   ttl                 = 3
#   records             = [azurerm_network_interface.dispatch.private_ip_address]
# }
#
