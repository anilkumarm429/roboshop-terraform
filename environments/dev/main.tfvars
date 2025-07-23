env = "dev"


dns_record_rg_name      = "project-1"
ip_configuration_subnet_id= "/subscriptions/7d58fd8a-e8be-4f50-b9f6-03616700d9fc/resourceGroups/project-1/providers/Microsoft.Network/virtualNetworks/project-1-network/subnets/default"
zone_name = "apps11.shop"
storage_image_reference_id= "/subscriptions/7d58fd8a-e8be-4f50-b9f6-03616700d9fc/resourceGroups/project-1/providers/Microsoft.Compute/images/local-devops-practice"
network_security_group_id= "/subscriptions/7d58fd8a-e8be-4f50-b9f6-03616700d9fc/resourceGroups/project-1/providers/Microsoft.Network/networkSecurityGroups/project-allow-all"

databases= {
    mongodb  = {
        rgname = "ukwest"
    }
    rabbitmq = {
        rgname = "ukwest"
    }
    mysql    = {
        rgname = "ukwest"
    }
    redis    = {
        rgname = "ukwest"
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
        default_node_pool = {
            nodes   = 1
            vm_size = "Standard_B2as_v2"
        }
        app_node_pool = {
            one = {
                max_count            = 10
                min_count            = 3
                vm_size              = "Standard_B2as_v2"
                auto_scaling_enabled = true
                node_labels = {
                    "project/name" = "roboshop"
                }
            }
        }

    }
}