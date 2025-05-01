
variable "instance_type" {
  description = "Instance type for the EC2 server"
}

variable "key_name" {
  description = "SSH key name"
}


variable "security_group_id" {
  type = string
}

