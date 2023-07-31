variable "destination_groups" {}
variable "source_groups" {}
variable "display_name" {}
variable "description" {}
variable "tags" {
    type = map
    default = {}
}
variable "rules" {
    type = list
    default = []
}
