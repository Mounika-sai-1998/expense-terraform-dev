variable "project_name" {
    type = string
    default = "expense"
}

variable "environment" {
    type = string
    default = "dev"
}

# # variable "sg_name" {
# #     type = string
    
# }

# variable "description" {
#     type = string
# }

variable "common_tags" {
    type = map
    default = {
        Project_name = "expense"
        Environment = "dev"
        Terraform = true
    }
}

variable "sg_tags" {
    type = map
    default =  {} 
}

# variable "vpc_id" {
#     type = string
# }


 