variable "vpc_cidr" {
    type = list 
    description = "Please provide VPC CIDR"
}


variable "project_name" {
    type = string 
  
}

variable "environment" {
    type = string 
  
}

variable "vpc_tags" {
    type = map 
    default = {}
  
}

