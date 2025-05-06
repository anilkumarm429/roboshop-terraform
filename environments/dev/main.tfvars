env = "dev"



ip_configuration_subnet_id= "/subscriptions/7d58fd8a-e8be-4f50-b9f6-03616700d9fc/resourceGroups/project-1/providers/Microsoft.Network/virtualNetworks/project-1-network/subnets/default"
zone_name = "apps11.shop"
storage_image_reference_id= "/subscriptions/7d58fd8a-e8be-4f50-b9f6-03616700d9fc/resourceGroups/project-1/providers/Microsoft.Compute/images/local-devops-practice"
network_security_group_id= "/subscriptions/7d58fd8a-e8be-4f50-b9f6-03616700d9fc/resourceGroups/project-1/providers/Microsoft.Network/networkSecurityGroups/project-allow-all"

databases= {
    mongodb  = {
        rgname = "ukwest-dev"
    }
    rabbitmq = {
        rgname = "ukwest-dev"
    }
    mysql    = {
        rgname = "ukwest-dev"
    }
    redis    = {
        rgname = "ukwest-dev"
    }
  }

applications= {
    catalogue  = {}
    user       = {}
    cart       = {}
    payment    = {}
    shipping   = {}
    frontend   = {}
  }

rg_name       = {
    main = {
        rg_location   = "UK West"
    }
}