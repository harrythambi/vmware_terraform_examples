variable "display_name" {}
variable "description" {}
variable "l4_protocol" {}
variable "l4_destination_ports" {}
variable "tags" {
    type = map
    default = {}
}
