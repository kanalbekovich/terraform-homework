variable vpc {
    type = list(object({
        cidr_block = string
        enable_dns_support   = bool
        enable_dns_hostnames = bool
    }))
    
    default [
        {
            cidr_block           = "10.0.0.0/16"
            enable_dns_support   = true
            enable_dns_hostnames = true
        }
        ]
}