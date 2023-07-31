## NSX-T
variable "nsx_manager" {
    type = string
}
variable "nsx_username" {
    type = string
}
variable "nsx_password" {
    type = string
}
variable "policy_groups" {
    type = list
}
variable "policy_services" {
    type = list
}