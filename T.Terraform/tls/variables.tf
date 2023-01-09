variable "app" {
  type = string
}

variable "domain" {
  type = string
}

variable "location" {
  description = "Azure location"
  default     = "Canada Central"
  type        = string
}

variable "email_address" {
  description = "Registrant Email Address"
  type        = string
}
