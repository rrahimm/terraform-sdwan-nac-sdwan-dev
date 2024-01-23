resource "sdwan_switchport_feature_template" "switchport_feature_template" {
  for_each              = { for t in try(local.edge_feature_templates.switchport_templates, {}) : t.name => t }
  name                  = each.value.name
  description           = each.value.description
  device_types          = [for d in try(each.value.device_types, local.defaults.sdwan.edge_feature_templates.switchport_templates.device_types) : try(local.device_type_map[d], "vedge-${d}")]
  age_out_time          = try(each.value.age_out_time, null)
  age_out_time_variable = try(each.value.age_out_time_variable, null)
  module_type           = try(each.value.module_type, null)
  slot                  = try(each.value.slot, null)
  sub_slot              = try(each.value.sub_slot, null)
  interfaces = [for interface in try(each.value.interfaces, []) : {
    name                                              = try(interface.name, null)
    name_variable                                     = try(interface.name_variable, null)
    switchport_mode                                   = try(interface.mode, local.defaults.sdwan.edge_feature_templates.switchport_templates.interfaces.mode, null)
    switchport_access_vlan                            = try(interface.access_vlan, local.defaults.sdwan.edge_feature_templates.switchport_templates.interfaces.access_vlan, null)
    switchport_access_vlan_variable                   = try(interface.access_vlan_variable, null)
    duplex                                            = try(interface.duplex, local.defaults.sdwan.edge_feature_templates.switchport_templates.interfaces.duplex, null)
    duplex_variable                                   = try(interface.duplex_variable, null)
    optional                                          = try(interface.optional, local.defaults.sdwan.edge_feature_templates.switchport_templates.interfaces.optional, null)
    shutdown                                          = try(interface.shutdown, local.defaults.sdwan.edge_feature_templates.switchport_templates.interfaces.shutdown, null)
    shutdown_variable                                 = try(interface.shutdown_variable, null)
    speed                                             = try(interface.speed, local.defaults.sdwan.edge_feature_templates.switchport_templates.interfaces.speed, null)
    speed_variable                                    = try(interface.speed_variable, null)
    switchport_trunk_allowed_vlans                    = join(" ", concat([for p in try(interface.trunk_allowed_vlans, []) : p], [for r in try(interface.trunk_allowed_vlans_ranges, []) : "${r.from}-${r.to}"]))
    switchport_access_vlans_variable                  = try(interface.trunk_allowed_vlans_variable, null)
    switchport_trunk_native_vlan                      = try(interface.trunk_native_vlan, null)
    switchport_trunk_native_vlan_variable             = try(interface.trunk_native_vlan_variable, null)
    dot1x_control_direction                           = try(interface.dot1x.control_direction, local.defaults.sdwan.edge_feature_templates.switchport_templates.interfaces.dot1x.control_direction, null)
    dot1x_control_direction_variable                  = try(interface.dot1x.control_direction_variable, null)
    dot1x_critical_vlan                               = try(interface.dot1x.critical_vlan, null)
    dot1x_critical_vlan_variable                      = try(interface.dot1x.critical_vlan_variable, null)
    dot1x_enable                                      = try(interface.dot1x.enable, local.defaults.sdwan.edge_feature_templates.switchport_templates.interfaces.dot1x.enable, null)
    dot1x_enable_criticial_voice_vlan                 = try(interface.dot1x.enable_criticial_voice_vlan, null)
    dot1x_enable_criticial_voice_vlan_variable        = try(interface.dot1x.enable_criticial_voice_vlan_variable, null)
    dot1x_pae_enable                                  = try(interface.dot1x.enable_pae, local.defaults.sdwan.edge_feature_templates.switchport_templates.interfaces.dot1x.enable_pae, null)
    dot1x_pae_enable_variable                         = try(interface.dot1x.enable_pae_variable, null)
    dot1x_enable_periodic_reauth                      = try(interface.dot1x.enable_periodic_reauth, null)
    dot1x_enable_periodic_reauth_variable             = try(interface.dot1x.enable_periodic_reauth_variable, null)
    dot1x_guest_vlan                                  = try(interface.dot1x.guest_vlan, null)
    dot1x_guest_vlan_variable                         = try(interface.dot1x.guest_vlan_variable, null)
    dot1x_host_mode                                   = try(interface.dot1x.host_mode, local.defaults.sdwan.edge_feature_templates.switchport_templates.interfaces.dot1x.host_mode, null)
    dot1x_host_mode_variable                          = try(interface.dot1x.host_mode_variable, null)
    dot1x_mac_authentication_bypass                   = try(interface.dot1x.mac_authentication_bypass, null)
    dot1x_mac_authentication_bypass_variable          = try(interface.dot1x.mac_authentication_bypass_variable, null)
    dot1x_periodic_reauth_inactivity_timeout          = try(interface.dot1x.periodic_reauth_inactivity_timeout, null)
    dot1x_periodic_reauth_inactivity_timeout_variable = try(interface.dot1x.periodic_reauth_inactivity_timeout_variable, null)
    dot1x_periodic_reauth_interval                    = try(interface.dot1x.periodic_reauth_interval, null)
    dot1x_periodic_reauth_interval_variable           = try(interface.dot1x.periodic_reauth_interval_variable, null)
    dot1x_port_control                                = try(interface.dot1x.port_control_mode, local.defaults.sdwan.edge_feature_templates.switchport_templates.interfaces.dot1x.port_control_mode, null)
    dot1x_port_control_variable                       = try(interface.dot1x.port_control_mode_variable, null)
    dot1x_restricted_vlan                             = try(interface.dot1x.restricted_vlan, null)
    dot1x_restricted_vlan_variable                    = try(interface.dot1x.restricted_vlan_variable, null)
  }]
  static_mac_addresses = [for sma in try(each.value.static_mac_addresses, []) : {
    if_name              = try(sma.interface_name, null)
    if_name_variable     = try(sma.interface_name_variable, null)
    mac_address          = try(sma.mac_address, null)
    mac_address_variable = try(sma.mac_address_variable, null)
    optional             = try(sma.optional, local.defaults.sdwan.edge_feature_templates.switchport_templates.static_mac_addresses.optional, null)
    vlan                 = try(sma.vlan, null)
    vlan_variable        = try(sma.vlan_variable, null)
  }]
}


resource "sdwan_vpn_interface_svi_feature_template" "vpn_interface_svi_feature_template" {
  for_each                       = { for t in try(local.edge_feature_templates.svi_interface_templates, {}) : t.name => t }
  name                           = each.value.name
  description                    = each.value.description
  device_types                   = [for d in try(each.value.device_types, local.defaults.sdwan.edge_feature_templates.svi_interface_templates.device_types) : try(local.device_type_map[d], "vedge-${d}")]
  arp_timeout                    = try(each.value.arp_timeout, null)
  arp_timeout_variable           = try(each.value.arp_timeout_variable, null)
  if_name                        = try(each.value.interface_name, null)
  if_name_variable               = try(each.value.interface_name_variable, null)
  interface_description          = try(each.value.interface_description, null)
  interface_description_variable = try(each.value.interface_description_variable, null)
  ip_directed_broadcast          = try(each.value.ip_directed_broadcast, null)
  ip_directed_broadcast_variable = try(each.value.ip_directed_broadcast_variable, null)
  ip_mtu                         = try(each.value.ip_mtu, null)
  ip_mtu_variable                = try(each.value.ip_mtu_variable, null)
  ipv4_address                   = try(each.value.ipv4_address, null)
  ipv4_address_variable          = try(each.value.ipv4_address_variable, null)
  ipv4_dhcp_helper               = [try(each.value.ipv4_dhcp_helper, null)]
  ipv4_dhcp_helper_variable      = try(each.value.ipv4_dhcp_helper_variable, null)
  ipv6_address                   = try(each.value.ipv6_address, null)
  ipv6_address_variable          = try(each.value.ipv6_address_variable, null)
  mtu                            = try(each.value.mtu, null)
  mtu_variable                   = try(each.value.mtu_variable, null)
  shutdown                       = try(each.value.shutdown, null)
  shutdown_variable              = try(each.value.shutdown_variable, null)
  tcp_mss_adjust                 = try(each.value.tcp_mss, null)
  tcp_mss_adjust_variable        = try(each.value.tcp_mss_variable, null)
  ipv4_access_lists = flatten([
    try(each.value.ipv4_ingress_access_list, null) == null ? [] : [{
      acl_name  = each.value.ipv4_ingress_access_list
      direction = "in"
    }],
    try(each.value.ipv4_egress_access_list, null) == null ? [] : [{
      acl_name  = each.value.ipv4_egress_access_list
      direction = "out"
    }],
    try(each.value.ipv4_ingress_access_list_variable, null) == null ? [] : [{
      acl_name_variable = each.value.ipv4_ingress_access_list_variable
      direction         = "in"
    }],
    try(each.value.ipv4_egress_access_list_variable, null) == null ? [] : [{
      acl_name_variable = each.value.ipv4_egress_access_list_variable
      direction         = "out"
    }]
  ])
  ipv6_access_lists = flatten([
    try(each.value.ipv6_ingress_access_list, null) == null ? [] : [{
      acl_name  = each.value.ipv6_ingress_access_list
      direction = "in"
    }],
    try(each.value.ipv6_egress_access_list, null) == null ? [] : [{
      acl_name  = each.value.ipv6_egress_access_list
      direction = "out"
    }],
    try(each.value.ipv6_ingress_access_list_variable, null) == null ? [] : [{
      acl_name_variable = each.value.ipv6_ingress_access_list_variable
      direction         = "in"
    }],
    try(each.value.ipv6_egress_access_list_variable, null) == null ? [] : [{
      acl_name_variable = each.value.ipv6_egress_access_list_variable
      direction         = "out"
    }],
  ])
  ipv4_secondary_addresses = concat(
    [for a in try(each.value.ipv4_secondary_addresses, []) : {
      ipv4_address = a
    }],
    [for b in try(each.value.ipv4_secondary_address_variables, []) : {
      ipv4_address_variable = b
    }]
  )
  ipv6_secondary_addresses = concat(
    [for a in try(each.value.ipv6_secondary_addresses, []) : {
      ipv6_address = a
    }],
    [for b in try(each.value.ipv6_secondary_address_variables, []) : {
      ipv6_address_variable = b
    }],
  )
  ipv6_dhcp_helpers = [for h in try(each.value.ipv6_dhcp_helpers, []) : {
    address          = try(h.address, null)
    address_variable = try(h.address_variable, null)
    vpn_id           = try(h.vpn_id, null)
    vpn_id_variable  = try(h.vpn_id_variable, null)
  }]
  static_arp_entries = [for e in try(each.value.static_arps, []) : {
    ipv4_address          = try(e.ip_address, null)
    ipv4_address_variable = try(e.ip_address_variable, null)
    mac_address           = try(e.mac_address, null)
    mac_address_variable  = try(e.mac_address_variable, null)
    optional              = try(e.optional, null)
  }]
  ipv4_vrrps = [for v in try(each.value.ipv4_vrrp_groups, []) : {
    group_id              = try(v.id, null)
    group_id_variable     = try(v.id_variable, null)
    ipv4_address          = try(v.address, null)
    ipv4_address_variable = try(v.address_variable, null)
    ipv4_secondary_addresses = [for sa in try(v.secondary_addresses, []) : {
      ipv4_address          = try(sa.address, null)
      ipv4_address_variable = try(sa.address_variable, null)
    }]
    optional                              = try(v.optional, null)
    priority                              = try(v.priority, null)
    priority_variable                     = try(v.priority_variable, null)
    timer                                 = try(v.timer, null)
    timer_variable                        = try(v.timer_variable, null)
    tloc_preference_change                = try(v.tloc_preference_change, null)
    tloc_preference_change_value          = try(v.tloc_preference_change_value, null)
    tloc_preference_change_value_variable = try(v.tloc_preference_change_value_variable, null)
    track_omp                             = try(v.track_omp, null)
    track_omp_variable                    = try(v.track_omp_variable, null)
    track_prefix_list                     = try(v.track_prefix_list, null)
    track_prefix_list_variable            = try(v.track_prefix_list_variable, null)
    tracking_objects = [for t in try(v.tracking_objects, []) : {
      name                     = try(t.id, null)
      name_variable            = try(t.id_variable, null)
      decrement_value          = try(t.decrement_value, null)
      decrement_value_variable = try(t.decrement_value_variable, null)
      track_action             = try(t.action, null)
      track_action_variable    = try(t.action_variable, null)
    }]
  }]
  ipv6_vrrps = [for v in try(each.value.ipv6_vrrp_groups, []) : {
    group_id          = try(v.id, null)
    group_id_variable = try(v.id_variable, null)
    ipv6_addresses = flatten([
      try(v.global_prefix, null) == null ? [] : [{
        prefix = v.global_prefix
      }],
      try(v.global_prefix_variable, null) == null ? [] : [{
        prefix_variable = v.global_prefix_variable
      }],
      try(v.link_local_address, null) == null ? [] : [{
        link_local_address = v.link_local_address
      }],
      try(v.link_local_address_variable, null) == null ? [] : [{
        link_local_address_variable = v.link_local_address_variable
      }]
    ])
    ipv6_secondary_addresses = [for sa in try(v.secondary_addresses, []) : {
      prefix          = try(sa.address, null)
      prefix_variable = try(sa.address_variable, null)
    }]
    optional                   = try(v.optional, null)
    priority                   = try(v.priority, null)
    priority_variable          = try(v.priority_variable, null)
    timer                      = try(v.timer, null)
    timer_variable             = try(v.timer_variable, null)
    track_omp                  = try(v.track_omp, null)
    track_omp_variable         = try(v.track_omp_variable, null)
    track_prefix_list          = try(v.track_prefix_list, null)
    track_prefix_list_variable = try(v.track_prefix_list_variable, null)
  }]
}

resource "sdwan_cisco_secure_internet_gateway_feature_template" "cisco_secure_internet_gateway_feature_template" {
  for_each                   = { for t in try(local.edge_feature_templates.secure_internet_gateway_templates, {}) : t.name => t }
  name                       = each.value.name
  description                = each.value.description
  device_types               = [for d in try(each.value.device_types, local.defaults.sdwan.edge_feature_templates.secure_internet_gateway_templates.device_types) : try(local.device_type_map[d], "vedge-${d}")]
  tracker_source_ip          = try(each.value.tracker_source_ip, null)
  tracker_source_ip_variable = try(each.value.tracker_source_ip_variable, null)
  trackers = [for tracker in try(each.value.trackers, []) : {
    tracker_type              = "SIG"
    endpoint_api_url          = try(tracker.endpoint_api_url, null)
    endpoint_api_url_variable = try(tracker.endpoint_api_url_variable, null)
    multiplier                = try(tracker.multiplier, null)
    multiplier_variable       = try(tracker.multiplier_variable, null)
    interval                  = try(tracker.interval, null)
    interval_variable         = try(tracker.interval_variable, null)
    name                      = try(tracker.name, null)
    name_variable             = try(tracker.name_variable, null)
    threshold                 = try(tracker.threshold, null)
    threshold_variable        = try(tracker.threshold_variable, null)
  }]
  interfaces = [for interface in try(each.value.interfaces, []) : {
    application                            = "sig"
    description                            = try(interface.description, null)
    description_variable                   = try(interface.description_variable, null)
    dead_peer_detection_interval           = try(interface.dpd_interval, null)
    dead_peer_detection_interval_variable  = try(interface.dpd_interval_variable, null)
    dead_peer_detection_retries            = try(interface.dpd_retries, null)
    dead_peer_detection_retries_variable   = try(interface.dpd_retries_variable, null)
    ike_ciphersuite                        = try(interface.ike_ciphersuite, null)
    ike_ciphersuite_variable               = try(interface.ike_ciphersuite_variable, null)
    ike_group                              = try(interface.ike_group, null)
    ike_group_variable                     = try(interface.ike_group_variable, null)
    ike_pre_shared_key                     = try(interface.ike_pre_shared_key, null)
    ike_pre_shared_key_variable            = try(interface.ike_pre_shared_key_variable, null)
    ike_pre_shared_key_local_id            = try(interface.ike_pre_shared_key_local_id, null)
    ike_pre_shared_key_local_id_variable   = try(interface.ike_pre_shared_key_local_id_variable, null)
    ike_pre_shared_key_remote_id           = try(interface.ike_pre_shared_key_remote_id, null)
    ike_pre_shared_key_remote_id_variable  = try(interface.ike_pre_shared_key_remote_id_variable, null)
    ike_rekey_interval                     = try(interface.ike_rekey_interval, null)
    ike_rekey_interval_variable            = try(interface.ike_rekey_interval_variable, null)
    ipsec_ciphersuite                      = try(interface.ipsec_ciphersuite, null)
    ipsec_ciphersuite_variable             = try(interface.ipsec_ciphersuite_variable, null)
    ipsec_perfect_forward_secrecy          = try(interface.ipsec_perfect_forward_secrecy, null)
    ipsec_perfect_forward_secrecy_variable = try(interface.ipsec_perfect_forward_secrecy_variable, null)
    ipsec_rekey_interval                   = try(interface.ipsec_rekey_interval, null)
    ipsec_rekey_interval_variable          = try(interface.ipsec_rekey_interval_variable, null)
    ipsec_replay_window                    = try(interface.ipsec_replay_window, null)
    ipsec_replay_window_variable           = try(interface.ipsec_replay_window_variable, null)
    mtu                                    = try(interface.mtu, null)
    mtu_variable                           = try(interface.mtu_variable, null)
    name                                   = try(interface.name, null)
    name_variable                          = try(interface.name_variable, null)
    shutdown                               = try(interface.shutdown, null)
    sig_provider                           = try(interface.sig_provider, null)
    tcp_mss                                = try(interface.tcp_mss, null)
    tcp_mss_variable                       = try(interface.tcp_mss_variable, null)
    track_enable                           = try(interface.track, null)
    tunnel_dc_preference                   = try(interface.tunnel_dc_preference, null)
    tunnel_destination                     = try(interface.tunnel_destination, null)
    tunnel_destination_variable            = try(interface.tunnel_destination_variable, null)
    tunnel_source_interface                = try(interface.tunnel_source_interface, null)
    tunnel_source_interface_variable       = try(interface.tunnel_source_interface_variable, null)
  }]
  services = [{
    service_type = (
    try(each.value.umbrella_primary_data_center, each.value.umbrella_primary_data_center_variable, each.value.umbrella_secondary_data_center, each.value.umbrella_secondary_data_center_variable, each.value.zscaler_primary_data_center, each.value.zscaler_primary_data_center_variable, each.value.zscaler_secondary_data_center, each.value.zscaler_secondary_data_center_variable, each.value.zscaler_aup_block_internet_until_accepted, each.value.zscaler_aup_enabled, each.value.zscaler_aup_force_ssl_inspection, each.value.zscaler_aup_timeout, each.value.zscaler_authentication_required, each.value.zscaler_caution_enabled, each.value.zscaler_ips_control_enabled, each.value.zscaler_firewall_enabled, each.value.zscaler_location_name_variable, each.value.zscaler_surrogate_display_time_unit, each.value.zscaler_surrogate_idle_time, each.value.zscaler_surrogate_ip, each.value.zscaler_surrogate_ip_enforce_for_known_browsers, each.value.zscaler_surrogate_refresh_time, each.value.zscaler_surrogate_refresh_time_unit, each.value.zscaler_xff_forward) == null ? null : "sig")
    umbrella_primary_data_center                    = try(each.value.umbrella_primary_data_center, null)
    umbrella_primary_data_center_variable           = try(each.value.umbrella_primary_data_center_variable, null)
    umbrella_secondary_data_center                  = try(each.value.umbrella_secondary_data_center, null)
    umbrella_secondary_data_center_variable         = try(each.value.umbrella_secondary_data_center_variable, null)
    zscaler_aup_block_internet_until_accepted       = try(each.value.zscaler_aup_block_internet_until_accepted, null)
    zscaler_aup_enabled                             = try(each.value.zscaler_aup_enabled, null)
    zscaler_aup_force_ssl_inspection                = try(each.value.zscaler_aup_force_ssl_inspection, null)
    zscaler_aup_timeout                             = try(each.value.zscaler_aup_timeout, null)
    zscaler_authentication_required                 = try(each.value.zscaler_authentication_required, null)
    zscaler_caution_enabled                         = try(each.value.zscaler_caution_enabled, null)
    zscaler_ips_control_enabled                     = try(each.value.zscaler_ips_control_enabled, null)
    zscaler_firewall_enabled                        = try(each.value.zscaler_firewall_enabled, null)
    zscaler_location_name_variable                  = try(each.value.zscaler_location_name_variable, null)
    zscaler_primary_data_center                     = try(each.value.zscaler_primary_data_center, null)
    zscaler_primary_data_center_variable            = try(each.value.zscaler_primary_data_center_variable, null)
    zscaler_secondary_data_center                   = try(each.value.zscaler_secondary_data_center, null)
    zscaler_secondary_data_center_variable          = try(each.value.zscaler_secondary_data_center_variable, null)
    zscaler_surrogate_display_time_unit             = try(each.value.zscaler_surrogate_display_time_unit, null)
    zscaler_surrogate_idle_time                     = try(each.value.zscaler_surrogate_idle_time, null)
    zscaler_surrogate_ip                            = try(each.value.zscaler_surrogate_ip, null)
    zscaler_surrogate_ip_enforce_for_known_browsers = try(each.value.zscaler_surrogate_ip_enforce_for_known_browsers, null)
    zscaler_surrogate_refresh_time                  = try(each.value.zscaler_surrogate_refresh_time, null)
    zscaler_surrogate_refresh_time_unit             = try(each.value.zscaler_surrogate_refresh_time_unit, null)
    zscaler_xff_forward                             = try(each.value.zscaler_xff_forward, null)
    interface_pairs = [for pair in try(each.value.high_availability_interface_pairs, []) : {
      active_interface        = try(pair.active_interface, null)
      active_interface_weight = try(pair.active_interface_weight, null)
      backup_interface        = try(pair.backup_interface, null)
      backup_interface_weight = try(pair.backup_interface_weight, null)
    }]
  }]
}

resource "sdwan_cli_template_feature_template" "cli_template_feature_template" {
  for_each     = { for t in try(local.edge_feature_templates.cli_templates, {}) : t.name => t }
  name         = each.value.name
  description  = each.value.description
  device_types = [for d in try(each.value.device_types, local.defaults.sdwan.edge_feature_templates.cli_templates.device_types) : try(local.device_type_map[d], "vedge-${d}")]
  cli_config   = each.value.cli_config
}

resource "sdwan_cisco_sig_credentials_feature_template" "sig_credentials_feature_template" {
  for_each                          = { for t in try(local.edge_feature_templates.sig_credentials_templates, {}) : t.name => t }
  name                              = each.value.name
  description                       = each.value.description
  device_types                      = [for d in try(each.value.device_types, local.defaults.sdwan.edge_feature_templates.sig_credentials_templates.device_types) : try(local.device_type_map[d], "vedge-${d}")]
  umbrella_api_key                  = try(each.value.umbrella_api_key, null)
  umbrella_api_key_variable         = try(each.value.umbrella_api_key_variable, null)
  umbrella_api_secret               = try(each.value.umbrella_api_secret, null)
  umbrella_api_secret_variable      = try(each.value.umbrella_api_secret_variable, null)
  umbrella_organization_id          = try(each.value.umbrella_organization_id, null)
  umbrella_organization_id_variable = try(each.value.umbrella_organization_id_variable, null)
  zscaler_cloud_name                = try(each.value.scaler_cloud_name, null)
  zscaler_cloud_name_variable       = try(each.value.zscaler_cloud_name_variable, null)
  zscaler_organization              = try(each.value.zscaler_organization, null)
  zscaler_organization_variable     = try(each.value.zscaler_organization_variable, null)
  zscaler_partner_api_key           = try(each.value.zscaler_partner_api_key, null)
  zscaler_partner_api_key_variable  = try(each.value.zscaler_partner_api_key_variable, null)
  zscaler_partner_base_uri          = try(each.value.zscaler_partner_base_uri, null)
  zscaler_partner_base_uri_variable = try(each.value.zscaler_partner_base_uri_variable, null)
  zscaler_partner_password          = try(each.value.zscaler_password, null)
  zscaler_partner_password_variable = try(each.value.zscaler_password_variable, null)
  zscaler_partner_username          = try(each.value.zscaler_username, null)
  zscaler_partner_username_variable = try(each.value.zscaler_username_variable, null)
  zscaler_password                  = try(each.value.zscaler_password, null)
  zscaler_password_variable         = try(each.value.zscaler_password_variable, null)
  zscaler_username                  = try(each.value.zscaler_username, null)
  zscaler_username_variable         = try(each.value.zscaler_username_variable, null)
}