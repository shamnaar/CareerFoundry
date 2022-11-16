variable "dns_prefix" {
    default = "dev-aks"
}

variable clustername {
    type = string
}

variable locationk8s {
    default = "East US 2"
}

variable resource_group {
    type = string
}
