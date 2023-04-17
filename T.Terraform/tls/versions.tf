terraform {
  required_version = "~> 1.1.0"

  required_providers {
    acme = {
      source  = "vancluever/acme"
      version = "~> 2.5.3"
    }
  }
}
