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
variable "overlay_segments" {
    type = map
}
variable "tier1_gateways" {
    type = map
}