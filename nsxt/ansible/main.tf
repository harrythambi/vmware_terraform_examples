resource "nsxt_policy_group" "group01" {
  display_name        = "group01"
  description         = "group01"

  criteria {
    ipaddress_expression {
      ip_addresses = ["8.8.8.8/32", "8.8.4.4/32"]
    }
  }
}
resource "nsxt_policy_group" "group02" {
  display_name        = "group02"
  description         = "group02"

  criteria {
    ipaddress_expression {
      ip_addresses = ["8.8.8.8/32", "8.8.4.4/32"]
    }
  }
}

resource "nsxt_policy_service" "service01" {
  display_name        = "service01"
  description         = "service01"

  l4_port_set_entry {
    display_name      = "TCP"
    protocol          = "TCP"
    destination_ports = ["8080", "4440"]
  }

}
resource "nsxt_policy_service" "service02" {
  display_name        = "service02"
  description         = "service02"

  l4_port_set_entry {
    display_name      = "TCP"
    protocol          = "TCP"
    destination_ports = ["8080", "4440"]
  }

}
resource "nsxt_policy_service" "service03" {
  display_name        = "service03"
  description         = "service03"

  l4_port_set_entry {
    display_name      = "TCP"
    protocol          = "TCP"
    destination_ports = ["8080", "4440"]
  }

}

resource "nsxt_policy_security_policy" "policy01" {
  display_name = "policy01"
  description  = "policy01"

  category   = "Application"
  locked     = false
  stateful   = true
  tcp_strict = false






  rule {
    display_name = "rule01"
    description = "rule01"
    destination_groups = [nsxt_policy_group.group01.path, nsxt_policy_group.group02.path]
    source_groups = [nsxt_policy_group.group01.path]
    services = [nsxt_policy_service.service01.path]
    action = "ALLOW"
    logged = false
    disabled = true
  }





  rule {
    display_name = "rule02"
    description = "rule02"
    destination_groups = [nsxt_policy_group.group01.path, nsxt_policy_group.group02.path]
    source_groups = [nsxt_policy_group.group01.path]
    services = [nsxt_policy_service.service01.path]
    action = "ALLOW"
    logged = false
    disabled = true
  }
}
resource "nsxt_policy_security_policy" "policy02" {
  display_name = "policy02"
  description  = "policy02"

  category   = "Application"
  locked     = false
  stateful   = true
  tcp_strict = false






  rule {
    display_name = "rule01"
    description = "rule01"
    destination_groups = [nsxt_policy_group.group01.path, nsxt_policy_group.group02.path]
    source_groups = [nsxt_policy_group.group01.path]
    services = [nsxt_policy_service.service01.path]
    action = "ALLOW"
    logged = false
    disabled = true
  }





  rule {
    display_name = "rule02"
    description = "rule02"
    destination_groups = [nsxt_policy_group.group01.path, nsxt_policy_group.group02.path]
    source_groups = [nsxt_policy_group.group01.path]
    services = [nsxt_policy_service.service01.path]
    action = "ALLOW"
    logged = false
    disabled = true
  }
}
