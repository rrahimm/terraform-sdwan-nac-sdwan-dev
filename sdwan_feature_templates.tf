locals {
  device_types = [
    "C8000V",
    "C8300-1N1S-4T2X",
    "C8300-1N1S-6T",
    "C8300-2N2S-6T",
    "C8300-2N2S-4T2X",
    "C8500-12X4QC",
    "C8500-12X",
    "C8500-20X6C",
    "C8500L-8S4X",
    "C8200-1N-4T",
    "C8200L-1N-4T"
  ]
  thousand_eyes_device_types = [
    "C8300-1N1S-4T2X",
    "C8300-1N1S-6T",
    "C8300-2N2S-6T",
    "C8300-2N2S-4T2X",
    "C8200-1N-4T",
    "C8200L-1N-4T"
  ]
}

resource "sdwan_switchport_feature_template" "switchport_feature_template" {
  for_each       = { for t in try(local.edge_feature_templates.switchport_templates, {}) : t.name => t }
  name           = each.value.name
  description    = each.value.description
  device_types    = [for d in try(each.value.device_types, local.device_types) : try(local.device_type_map[d], "vedge-${d}")]
  age_out_time  = try(each.value.age_out_time, null)
  age_out_time_variable = try(each.value.age_out_time_variable, null)
  module_type    = try(each.value.module_type, null)
  slot           = try(each.value.slot, null)
  sub_slot       = try(each.value.sub_slot, null)
  interfaces = [for interface in try(each.value.interfaces, []) : {
    name = try(interface.name, null)
    name_variable = try(interface.name_variable, null)
    switchport_mode = try(interface.mode, null)
    switchport_access_vlan = try(interface.access_vlan, null)
    switchport_access_vlan_variable = try(interface.access_vlan_variable, null)
    duplex = try(interface.duplex, null)
    duplex_variable = try(interface.duplex_variable, null)
    optional = try(interface.optional, null)
    shutdown = try(interface.shutdown, null)
    shutdown_variable = try(interface.shutdown_variable, null)
    speed = try(interface.speed, null)
    speed_variable = try(interface.speed_variable, null)
    switchport_trunk_allowed_vlans = join(" ", concat([for p in try(interface.trunk_allowed_vlans, []) : p], [for r in try(interface.trunk_allowed_vlans_ranges, []) : "${r.from}-${r.to}"]))
    switchport_access_vlans_variable = try(interface.trunk_allowed_vlans_variable, null)
    switchport_trunk_native_vlan = try(interface.trunk_native_vlan, null)
    switchport_trunk_native_vlan_variable = try(interface.trunk_native_vlan_variable, null)
    dot1x_control_direction = try(interface.dot1x.control_direction, null)
    dot1x_control_direction_variable = try(interface.dot1x.control_direction_variable, null)
    dot1x_critical_vlan = try(interface.dot1x.critical_vlan, null)
    dot1x_critical_vlan_variable = try(interface.dot1x.critical_vlan_variable, null)
    dot1x_enable = try(interface.dot1x.enable, null)
    dot1x_enable_criticial_voice_vlan = try(interface.dot1x.enable_criticial_voice_vlan, null)
    dot1x_enable_criticial_voice_vlan_variable = try(interface.dot1x.enable_criticial_voice_vlan_variable, null)
    dot1x_pae_enable = try(interface.dot1x.enable_pae, null)
    dot1x_pae_enable_variable = try(interface.dot1x.enable_pae_variable, null)
    dot1x_enable_periodic_reauth = try(interface.dot1x.enable_periodic_reauth, null)
    dot1x_enable_periodic_reauth_variable = try(interface.dot1x.enable_periodic_reauth_variable, null)
    dot1x_guest_vlan = try(interface.dot1x.guest_vlan, null)
    dot1x_guest_vlan_variable = try(interface.dot1x.guest_vlan_variable, null)
    dot1x_host_mode = try(interface.dot1x.host_mode, null)
    dot1x_host_mode_variable = try(interface.dot1x.host_mode_variable, null)
    dot1x_mac_authentication_bypass = try(interface.dot1x.mac_authentication_bypass, null)
    dot1x_mac_authentication_bypass_variable = try(interface.dot1x.mac_authentication_bypass_variable, null)
    dot1x_periodic_reauth_inactivity_timeout = try(interface.dot1x.periodic_reauth_inactivity_timeout, null)
    dot1x_periodic_reauth_inactivity_timeout_variable = try(interface.dot1x.periodic_reauth_inactivity_timeout_variable, null)
    dot1x_periodic_reauth_interval = try(interface.dot1x.periodic_reauth_interval, null)
    dot1x_periodic_reauth_interval_variable = try(interface.dot1x.periodic_reauth_interval_variable, null)
    dot1x_port_control = try(interface.dot1x.port_control_mode, null)
    dot1x_port_control_variable = try(interface.dot1x.port_control_mode_variable, null)
    dot1x_restricted_vlan = try(interface.dot1x.restricted_vlan, null)
    dot1x_restricted_vlan_variable = try(interface.dot1x.restricted_vlan_variable, null)
  }]
  # static_mac_addresses = [for sma in try(each.value.static_mac_addresses, []) : {
  #   if_name = try(sma.interface_name, null)
  #   if_name_variable = try(sma.interface_name_variable, null)
  #   mac_address = try(sma.mac_address, null)
  #   mac_address_variable = try(sma.mac_address_variable, null)
  #   optional = try(sma.optional, null)
  #   vlan = try(sma.vlan, null)
  #   vlan_variable = try(sma.vlan_variable, null)
  # }]
  static_mac_addresses = [
    {
      mac_address = "0000.0000.0000"
      if_name     = "GigabitEthernet0/0/0"
      vlan        = 1000
    }
  ]
}