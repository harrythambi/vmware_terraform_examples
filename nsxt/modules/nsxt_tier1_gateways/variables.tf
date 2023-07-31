variable "t1_gateway_name" {}
variable "services" {
    type = bool
    default = false
}
variable "description" {}
variable "edge_cluster_name" {}
variable "failover_mode" {}
variable "enable_standby_relocation" {
    default = null
}
variable "enable_firewall" {
    type = bool
}
variable "connected_tier0_gw" {}
variable "route_advertisement_types" {}
variable "pool_allocation" {}
variable "tags" {
    type = map
    default = {}
}