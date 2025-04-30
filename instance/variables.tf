variable "ami_id" {
  description = "AMI ID to use for EC2"
}

variable "instance_type" {
  description = "Instance type for the EC2 server"
}

variable "key_name" {
  description = "SSH key name"
}

variable "kms_key_id" {
  description = "KMS Key ID for encrypting volumes"
}


variable "security_group_id" {
  type = string
}
