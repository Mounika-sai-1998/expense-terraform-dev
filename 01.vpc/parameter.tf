resource "aws_ssm_parameter" "vpc_id" {
  name  = "/${var.project_name}/${var.environment}/vpc-id"
  type  = "String"
  value = module.vpc.vpc_id
}

#list in terraform ["L1" , "L2"] 
#list in ssm perameter L1,L2
resource "aws_ssm_parameter" "public_subnet_ids" {
  name  = "/${var.project_name}/${var.environment}/public_subnet_id"
  type  = "StringList"
  value = join("," , module.vpc.public_subnet_ids)     #converting from list to string list  
}

resource "aws_ssm_parameter" "private_subnet_ids" {
  name  = "/${var.project_name}/${var.environment}/private_subnet_id"
  type  = "StringList"
  value = join("," , module.vpc.private_subnet_ids)
}

resource "aws_ssm_parameter" "database_subnet_group_name" {
  name  = "/${var.project_name}/${var.environment}/database-subnet-group-name"
  type  = "String"
  value = module.vpc.database_subnet_group_name
}