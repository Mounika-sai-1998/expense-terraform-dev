module "database" {
  source = "terraform-aws-modules/rds/aws"

  identifier = "${var.project_name}-${var.environment}"

  engine            = "mysql"
  engine_version    = "8.0"
  instance_class    = "db.t3.micro"
  allocated_storage = 5

  db_name  = "transactions"   
  username = "root"
  port     = "3306"

  #iam_database_authentication_enabled = true

  vpc_security_group_ids = [data.aws_ssm_parameter.db_sg_id.value]

#   maintenance_window = "Mon:00:00-Mon:03:00"
#   backup_window      = "03:00-06:00"

#   # Enhanced Monitoring - see example for details on how to create the role
#   # by yourself, in case you don't want to create it automatically
#   monitoring_interval    = "30"
#   monitoring_role_name   = "MyRDSMonitoringRole"
#   create_monitoring_role = true

  
  # DB subnet group
  #create_db_subnet_group = true
  #subnet_ids             = ["subnet-12345678", "subnet-87654321"]
  db_subnet_group_name =  data.aws_ssm_parameter.database_subnet_group_name.value

  # DB parameter group
  family = "mysql8.0"

  # DB option group
  major_engine_version = "8.0"

  # Database Deletion Protection
  #deletion_protection = true

  tags = merge(
    var.common_tags,
    {
        Name = "${var.project_name}-${var.environment}"
    }

  )

  manage_master_user_password = false
  password_wo = "Expense1"
  password_wo_version = 1
  skip_final_snapshot = true
  
  parameters = [
    {
      name  = "character_set_client"
      value = "utf8mb4"
    },
    {
      name  = "character_set_server"
      value = "utf8mb4"
    }
  ]

  options = [
    {
      option_name = "MARIADB_AUDIT_PLUGIN"

      option_settings = [
        {
          name  = "SERVER_AUDIT_EVENTS"
          value = "CONNECT"
        },
        {
          name  = "SERVER_AUDIT_FILE_ROTATIONS"
          value = "37"
        },
      ]
    },
  ]
  

}