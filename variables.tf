variable "aws_region" {
  description = "Region in which AWS resources to be created"
  type        = string
  default     = "us-east-1"
}

variable "profile" {
  description = "AWS Credentials Profile configured on your local desktop terminal  $HOME/.aws/credentials"
  default     = "default"
}

variable "infrastructure_version" {
  default = "1"
}

variable "enable_blue_env" {
  description = "Enable blue environment"
  type        = bool
  default     = true
}

variable "blue_instance_count" {
  description = "Number of instances in blue environment"
  type        = number
  default     = 2
}

variable "instance_type" {
  description = "EC2 Instance Type"
  type        = string
  default     = "t2.micro"
}

variable "enable_green_env" {
  description = "Enable green environment"
  type        = bool
  default     = false
}

variable "green_instance_count" {
  description = "Number of instances in green environment"
  type        = number
  default     = 2
}

#variable "traffic_distribution" {
#  description = "Levels of traffic distribution"
#  type        = string
#}