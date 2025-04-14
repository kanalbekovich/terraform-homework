variable "vpc" {
  type = list(object({
    cidr_block           = string
    enable_dns_support   = bool
    enable_dns_hostnames = bool
  }))

  default = [
    {
      cidr_block           = "10.0.0.0/16"
      enable_dns_support   = true
      enable_dns_hostnames = true
    },
  ]
}

variable "subnets" {
  type = list(object({
    cidr_block              = string
    azs                     = string
    map_public_ip_on_launch = bool
    name                    = string
  }))

  default = [
    {
      cidr_block              = "10.0.1.0/24"
      azs                     = "us-west-2a"
      map_public_ip_on_launch = true
      name                    = "public1"

    },
    {
      cidr_block              = "10.0.2.0/24"
      azs                     = "us-west-2b"
      map_public_ip_on_launch = true
      name                    = "public2"
    },
    {
      cidr_block = "10.0.3.0/24"
      azs        = "us-west-2c"
      map_public_ip_on_launch = false
      name       = "private3"
    },
    {
      cidr_block = "10.0.4.0/24"
      azs        = "us-west-2d"
      map_public_ip_on_launch = false
      name       = "private2"
    }
  ]


}

variable "igw" {
  type    = string
  default = "homework4-igw"
}

variable "route_tables" {
  type    = list(string)
  default = ["public-rt", "private-rt"]
}

variable "sg" {
  type    = list(number)
  default = [22, 80, 443, 3306]
}

variable "ec2" {
  type = list(map(string))
  default = [
    {
      ami  = "ami-087f352c165340ea1"
      type = "t2.micro"

    },
    {
      ami  = "ami-03f8acd418785369b"
      type = "t2.micro"

    }
  ]


}

variable "key_pair" {
  type    = string
  default = "oregon-key"
}


