# locals {
#   segment_name = var.segment_name
#   description = var.description
#   cidr = var.cidr
#   transport_zone_name = var.transport_zone_name
#   connected_tier1_gw = var.connected_tier1_gw

# }

data "nsxt_policy_transport_zone" "overlay_tz" {
  display_name        = var.transport_zone_name
}

data "nsxt_policy_tier1_gateway" "tier1_gateway" {
  display_name        = var.connected_tier1_gw
}

resource "nsxt_policy_segment" "overlay_segment" {
  display_name        = var.segment_name
  description         = var.description
  transport_zone_path = data.nsxt_policy_transport_zone.overlay_tz.path
  connectivity_path   = data.nsxt_policy_tier1_gateway.tier1_gateway.path

  subnet {
    cidr = var.cidr
  }
}
