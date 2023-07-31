resource "nsxt_policy_group" "policy_group" {
  display_name        = "group1"
  description         = "group1"

  criteria {
    ipaddress_expression {
      ip_addresses = ["8.8.8.8/32","8.8.4.4/32"]
    }
  }
}

resource "nsxt_policy_service" "policy_service" {
  display_name        = "service01"
  description         = "service01"

  l4_port_set_entry {
    display_name      = "TCP"
    protocol          = "TCP"
    destination_ports = ["8080","4440"]
  }

}

resource "nsxt_policy_security_policy" "security_policy" {
  display_name = "policy01"
  description  = "policy01"

  category   = "Application"
  locked     = false
  stateful   = true
  tcp_strict = false

  rule {
    display_name = "rule01"
    description = "rule01"
    destination_groups = [nsxt_policy_group.policy_group.path]
    source_groups = [nsxt_policy_group.policy_group.path]
    services = [nsxt_policy_service.policy_service.path]
    action = "ALLOW"
    logged = false
    disabled = true
 
  }
}
