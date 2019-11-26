variable "origin_tag" {
  description = "Tag to let aws console users to know what created the aws resources"
  default = "dev-in-a-box"
}

variable "instance_type" {
  description = "Which instance type to launch"
  default = "t2.2xlarge"
}

variable "public_key_path" {
  default = "/home/nicholas/.ssh/id_rsa.pub"
  description = "SSH Key to be used to log into launched instance."
}
