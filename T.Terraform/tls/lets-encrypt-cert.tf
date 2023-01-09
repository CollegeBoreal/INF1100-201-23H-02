resource "tls_private_key" "private_key" {
  algorithm = "RSA"
}

resource "acme_registration" "registration" {
  account_key_pem = tls_private_key.private_key.private_key_pem
  email_address   = var.email_address
}

resource "acme_certificate" "certificate" {
  account_key_pem           = acme_registration.registration.account_key_pem
  common_name               = resource.azurerm_dns_zone.base_domain.name

  dns_challenge {
    provider = "azure"

  }

  depends_on = [acme_registration.registration]
}
