variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "prefix" {
  type    = string
  default = "nwong"
}

variable "aws_dev_role_arn" {
  description = "Amazon Resource Name of the dev role to be assumed (this was created in the producer workspace)"
}
