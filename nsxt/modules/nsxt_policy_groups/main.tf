resource "nsxt_policy_group" "policy_group" {
  display_name        = var.display_name
  description         = var.description

  criteria {
    ipaddress_expression {
      ip_addresses = var.ip_addresses
    }
  }
  dynamic "tag" {
    for_each = var.tags != null ? var.tags : {}
    content {
      tag = tag.value.tag
      scope = tag.value.scope
    }
  }

}

