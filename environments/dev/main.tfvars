env = "dev"
dns_record_rg_name      = "project-1"
ip_configuration_subnet_id= "/subscriptions/7d58fd8a-e8be-4f50-b9f6-03616700d9fc/resourceGroups/project-1/providers/Microsoft.Network/virtualNetworks/project-1-network/subnets/default"
zone_name = "apps11.shop"
storage_image_reference_id= "/subscriptions/7d58fd8a-e8be-4f50-b9f6-03616700d9fc/resourceGroups/project-1/providers/Microsoft.Compute/images/local-devops-practice"
network_security_group_id= "/subscriptions/7d58fd8a-e8be-4f50-b9f6-03616700d9fc/resourceGroups/project-1/providers/Microsoft.Network/networkSecurityGroups/project-allow-all"
tools_vnet_resource_id = "/subscriptions/7d58fd8a-e8be-4f50-b9f6-03616700d9fc/resourceGroups/project-1/providers/Microsoft.Network/virtualNetworks/project-1-network"

databases= {
    mongodb  = {
        rgname = "ukwest"
        vnet_prefix   = "main"
        subnet        = "main"
        vm_size       = "Standard_B2s"
        port          = 27017
    }
    rabbitmq = {
        rgname = "ukwest"
        vnet_prefix = "main"
        subnet      = "main"
        vm_size     = "Standard_B2s"
        port        = 5672
    }
    mysql    = {
        rgname = "ukwest"
        vnet_prefix = "main"
        subnet      = "main"
        vm_size     = "Standard_B2s"
        port        = 3306
    }
    redis    = {
        rgname = "ukwest"
        vnet_prefix = "main"
        subnet      = "main"
        vm_size     = "Standard_B2s"
        port        = 6379
    }
  }

applications= {
    catalogue  = {
        rgname = "ukwest"
    }
    user       = {
        rgname = "ukwest"
    }
    cart       = {
        rgname = "ukwest"
    }
    payment    = {
        rgname = "ukwest"
    }
    shipping   = {
        rgname = "ukwest"
    }
    frontend   = {
        rgname = "ukwest"
    }
  }

rg_name       = {
    ukwest = {
        location   = "UK West"
    }
}

aks = {
    main-dev = {
        rgname = "ukwest"
        vnet_prefix = "main"
        subnet      = "main"
        default_node_pool = {
            nodes   = 1
            vm_size = "Standard_D4as_v5"
        }
        app_node_pool = {
            one = {
                max_count            = 10
                min_count            = 2
                vm_size              = "Standard_D4as_v5"
                auto_scaling_enabled = true
                node_labels = {
                    "project/name" = "roboshop"
                }
            }
        }

    }
}

vnets = {
    main-dev = {
        rgname        = "ukwest"
        address_space = ["10.50.0.0/24"]
        subnets = {
            main = {
                address_prefixes = ["10.50.0.0/24"]
            }
        }
    }
}

bastion_nodes = ["10.0.0.101", "10.0.0.11"]

des_keys = {
  devopsb84-tf3 = {
    rgname = "ukwest"
  }
}