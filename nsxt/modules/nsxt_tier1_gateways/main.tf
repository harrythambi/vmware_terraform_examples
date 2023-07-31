# locals {
#   t1_gateway_name = var.t1_gateway_name
#   services = var.services
#   description = var.description
#   edge_cluster_name = var.edge_cluster_name
#   failover_mode = var.failover_mode
#   enable_firewall = var.enable_firewall
#   enable_standby_relocation = var.enable_standby_relocation
#   connected_tier0_gw = var.connected_tier0_gw
#   route_advertisement_types = var.route_advertisement_types
#   pool_allocation = var.pool_allocation
#   tags = var.tags
# }

data "nsxt_policy_edge_cluster" "edge_cluster" {
  count               = var.services ? 1 : 0
  display_name        = var.edge_cluster_name
}

data "nsxt_policy_tier0_gateway" "tier0_gateway" {
  count               = length(var.connected_tier0_gw) >= 1 ? 1 : 0
  display_name        = var.connected_tier0_gw
}

resource "nsxt_policy_tier1_gateway" "tier1_gateway" {
  display_name              = var.t1_gateway_name
  description               = var.description
  edge_cluster_path         = var.services ? data.nsxt_policy_edge_cluster.edge_cluster[0].path : null
  tier0_path                = length(var.connected_tier0_gw) >= 1 ? data.nsxt_policy_tier0_gateway.tier0_gateway[0].path : null
  failover_mode             = var.failover_mode 
  enable_firewall           = var.enable_firewall
  pool_allocation           = var.services ? var.pool_allocation : null
  # dhcp_config_path          = local.dhcp_config_path
  route_advertisement_types = var.route_advertisement_types

  dynamic "tag" {
    for_each = var.tags != null ? var.tags : {}
    content {
      tag = tag.value.tag
      scope = tag.value.scope
    }
  }

}
