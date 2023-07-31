module "overlay_segments" {
    for_each = var.overlay_segments
    source = "../../modules/nsxt_overlay_segments"
    segment_name = each.value.segment_name
    description = each.value.description
    cidr = each.value.cidr
    transport_zone_name = each.value.transport_zone_name
    connected_tier1_gw = each.value.connected_tier1_gw

    depends_on = [
      module.tier1_gateways
    ]
}

module "tier1_gateways" {
    for_each = var.tier1_gateways
    source = "../../modules/nsxt_tier1_gateways"
    t1_gateway_name = each.value.t1_gateway_name
    services = each.value.services
    description = each.value.description
    edge_cluster_name = each.value.edge_cluster_name
    failover_mode = each.value.failover_mode
    enable_firewall = each.value.enable_firewall
    connected_tier0_gw = each.value.connected_tier0_gw
    route_advertisement_types = each.value.route_advertisement_types
    pool_allocation = each.value.pool_allocation
    # tags = each.value.tags 
    tags = try(each.value.tags, {}) != {} ? each.value.tags : null
}