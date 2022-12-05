
variable "region" {
  type = string
}

variable "cluster_name" {
  type = string
}

variable "aws_account" {
  type = string
}

variable "oidc_provider_id" {
  type = string
  default = "EXAMPLED539D4633E53DE1B71EXAMPLE" # Replace with output of the OIDC provider URL oidc.eks.region-code.amazonaws.com/id/EXAMPLED539D4633E53DE1B71EXAMPLE
}

# variable "labels" {
#   type = object({
#     environment = string
#     region      = string
#   })
# }
