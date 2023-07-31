data "nsxt_policy_group" "destination_groups" {
    for_each = var.destination_groups

    name = each.value
}

data "nsxt_policy_group" "source_groups" {
    for_each = var.source_groups

    name = each.value
}

data "nsxt_policy_service" "services" {
    for_each = var.source_groups

    name = each.value
}


resource "nsxt_policy_security_policy" "security_policy" {
  display_name = var.display_name
  description  = var.description

  category   = var.category
  locked     = false
  stateful   = true
  tcp_strict = false

  dynamic "tag" {
    for_each = var.tags != null ? var.tags : {}
    content {
      tag = tag.value.tag
      scope = tag.value.scope
    }
  }

  # dynamic rule
  dynamic "rule" {
    for_each = var.rules != null ? var.rules : {}
    content {
      display_name = rule.value.rule_name
      description = rule.value.description
      destination_groups = [for group in data.nsxt_policy_group.destination_groups : group.path] # can concat two lists concat(list,list) should be used for ips which are not in groups.
      source_groups = [for group in data.nsxt_policy_group.source_groups : group.path] # can concat two lists concat(list,list) should be used for ips which are not in groups.
      services = [for service in data.nsxt_policy_service.services : service.path]
      action = rule.value.action
      logged = false
      disabled = true
    }
  }
}