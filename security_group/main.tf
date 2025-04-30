data "aws_vpc" "default" {
  default = true
}

resource "aws_security_group" "allow_port_8081" {
  name   = "allow-8081"
  vpc_id = data.aws_vpc.default.id

  ingress {
    from_port   = 8081
    to_port     = 8081
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"                
    cidr_blocks = ["0.0.0.0/0"]       
  }

  tags = {
    Name = "allow_ssh_and_8081"
  }
}
