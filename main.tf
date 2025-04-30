module "ec2_instance" {
  source        = "./instance" 
  instance_type = var.instance_type
  key_name      = var.key_name
  kms_key_id    = module.ebs_volume.kms_key_id
  ami_id        = data.aws_ami.amazon_linux.id

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


data "aws_ami" "amazon_linux" {
  most_recent = true

  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"] 
  }

  filter {
    name   = "architecture"
    values = ["x86_64"] 
    
}

}


