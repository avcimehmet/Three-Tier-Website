variable "aws_region" {
  description = "Region in which AWS resources to be created"
  type        = string
  default     = "us-east-1"
}

variable "availability_zones" {
  description = "List of desired availability zones"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b", "us-east-1c", "us-east-1d"]
}

variable "profile" {
  description = "AWS Credentials Profile configured on your local desktop terminal  $HOME/.aws/credentials"
  default     = "default"
}

variable "infrastructure_version" {
  default = "1"
}

variable "Subnet_count" { #(up to 4 subnets)
  description = "Number of subnets in infrastructure"
  type        = number
  default     = 2
}

variable "Instance_count_per_subnet" {
  description = "Number of subnets in infrastructure"
  type        = number
  default     = 1
}

variable "instance_type" {
  description = "EC2 Instance Type"
  type        = string
  default     = "t2.micro"
}

variable "App_instance_count" {
  description = "Number of instances in green environment"
  type        = number
  default     = 2
}