locals {
  # policy_groups_csv = csvdecode(file("./data/policy_groups.csv"))
  # policy_services_csv = csvdecode(file("./data/policy_services.csv"))
  #
}


module "nsxt_policy_groups" {
    # for_each = var.policy_groups
    for_each = { for group in var.policy_groups : group.group_name => group }
    source = "../../modules/nsxt_policy_groups"
    display_name = each.value.group_name
    description = each.value.description
    ip_addresses = try(each.value.ip_addresses, []) != [] ? each.value.ip_addresses : null
    tags = try(each.value.tags, {}) != {} ? each.value.tags : null
    # depends_on = [
    #   module.tier1_gateways
    # ]
}

module "nsxt_policy_services" {
    # for_each = var.policy_services
    for_each = { for service in var.policy_services : service.service_name => service }
    source = "../../modules/nsxt_policy_services"
    display_name = each.value.service_name
    description = each.value.description
    l4_protocol = each.value.protocol
    l4_destination_ports = each.value.ports
    tags = try(each.value.tags, {}) != {} ? each.value.tags : null
}

module "nsxt_dfw_security_policy" {
    # for_each = var.policy_services
    for_each = { for service in var.policy_services : service.service_name => service }
    source = "../../modules/nsxt_dfw_security_policy"
    display_name = each.value.dfw_policy_name
    description = each.value.description
    category = each.value.category
    tags = try(each.value.tags, {}) != {} ? each.value.tags : null
    rules = try(each.value.rules, {}) != [] ? each.value.rules : null
    depends_on = [
      module.nsxt_policy_groups,
      module.nsxt_policy_services
    ]
}