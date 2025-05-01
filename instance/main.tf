resource "aws_instance" "terrafromDockerApp" {
  ami                         = data.aws_ami.amazon_linux.id
  instance_type               = var.instance_type
  key_name                    = var.key_name
  vpc_security_group_ids      = [var.security_group_id]

  user_data                   = file("${path.module}/userdata.sh")

  tags = {
    Name = "MyPythonApp"
  }
}


data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-*-gp2"] 
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

