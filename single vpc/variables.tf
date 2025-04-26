variable "private_subnet_cidrs" {
  type    = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "public_subnet_cidrs" {
  type    = list(string)
  default = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
}


variable "private_subnet_names" {
  type    = list(string)
  default = ["private_subnet_1", "private_subnet_2", "private_subnet_3"]

}

variable "public_subnet_names" {
  type    = list(string)
  default = ["public_subnet_1", "public_subnet_2", "public_subnet_3"]

}

variable "ssh_port" {
  default = 22 
}

variable "http_port" {
  default = 80
}

variable "azs" {
 type        = list(string)
 description = "Availability Zones"
 default     = ["us-east-1a", "us-east-1b", "us-east-1c"]
}