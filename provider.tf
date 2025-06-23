provider "azurerm" {
  features {}
  subscription_id = "7d58fd8a-e8be-4f50-b9f6-03616700d9fc"
}


terraform {
  backend "azurerm" {}
}

provider "vault" {
  address = "http://vault-int.apps11.shop:8200"
  token = var.token
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}