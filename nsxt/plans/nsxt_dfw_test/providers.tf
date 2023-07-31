provider "nsxt"{
  host = var.nsx_manager
  username = var.nsx_username
  password = var.nsx_password
  allow_unverified_ssl = true
}