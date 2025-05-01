module "ec2_instance" {
  source        = "./instance" 
  instance_type = var.instance_type
  key_name      = var.key_name
  security_group_id = module.security_group.security_group_id

}


module "security_group"{
  source            = "./security_group"

}


module "ebs_volume" {
  source            = "./ebs_volume"
  instance_id       = module.ec2_instance.instance_id
  availability_zone = module.ec2_instance.availability_zone
}



