resource "nsxt_policy_service" "policy_service" {
  display_name        = var.display_name
  description         = var.description

  l4_port_set_entry {
    display_name      = var.l4_protocol
    protocol          = var.l4_protocol
    destination_ports = var.l4_destination_ports
  }

  dynamic "tag" {
    for_each = var.tags != null ? var.tags : {}
    content {
      tag = tag.value.tag
      scope = tag.value.scope
    }
  }

}

