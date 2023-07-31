variable "display_name" {}
variable "description" {}
variable "ip_addresses" {}
variable "tags" {
    type = map
    default = {}
}
