####### -------------------- IAM variables ----------------------- #######


########################### AWS credentials ###############################
variable "AWS_ACCESS_KEY_ID" {
  description = "AWS access key"
}

variable "AWS_SECRET_ACCESS_KEY" {
  description = "AWS secret access key"
}

variable "AWS_REGION" {
  description = "AWS region"
  default     = "eu-west-1"
}

variable "apigw_log_retention" {
  description = "api gwy log retention in days"
  type        = number
  default     = 7
}

