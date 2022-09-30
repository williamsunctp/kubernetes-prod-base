variable "repository" {
  default = "443561852337.dkr.ecr.us-east-1.amazonaws.com/devcts-repo"
}

variable "tag" {
  default = "devcts-repo3"
}

variable "namespace" {
  type        = string
  default     = "devcts-app"
  description = "Namespace to deploy the image into"
}

variable "fullnameOverride" {
  type        = string
  default     = "devcts-app"
  description = "Chart name"
}