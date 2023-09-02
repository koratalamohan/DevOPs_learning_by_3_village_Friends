variable "access_key" {
  description = "access key for my aws account"
  default     = "AKIAXIZOWS3XAOG3S52V"
  type        = string
}

variable "password" {
  description = "password for my aws account"
  type        = string
  default     = "D5JPPmqWwQLbU/MxfSIBsufsQluQ84Ja6qZYZI4K"
}

variable "region" {
  description = "region where aws resources created"
  type        = string
  default     = "eu-west-1"
}

variable "ami" {
  description = " amazon image is used to launch a ec2 instance"
  type       = string
  default     = "ami-01dd271720c1ba44f"
}

variable "instance_type" {
  description = "choose the type/sze of an ec2 instance"
  type        = string
  default     = "t2.micro"
}

variable "server_port" {
  description = "The port server will use for http requests"
  type        = number
  default     = 8080
}

variable "protocol" {
  description = "protocal used by server"
  type        = string
  default     = "tcp"
}
