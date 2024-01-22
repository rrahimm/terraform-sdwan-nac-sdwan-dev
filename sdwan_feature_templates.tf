resource "sdwan_cisco_sig_credentials_feature_template" "sig_credentials_feature_template" {
  for_each                 = { for t in try(local.edge_feature_templates.sig_credentials_templates, {}) : t.name => t }
  name                     = each.value.name
  description              = each.value.description
  device_types = [for d in try(each.value.device_types, local.defaults.sdwan.edge_feature_templates.sig_credentials_templates.device_types) : try(local.device_type_map[d], "vedge-${d}")]
  umbrella_api_key = try(each.value.umbrella_api_key, null)
  umbrella_api_key_variable = try(each.value.umbrella_api_key_variable, null)
  umbrella_api_secret = try(each.value.umbrella_api_secret, null)
  umbrella_api_secret_variable = try(each.value.umbrella_api_secret_variable, null)
  umbrella_organization_id = try(each.value.umbrella_organization_id, null)
  umbrella_organization_id_variable = try(each.value.umbrella_organization_id_variable, null)
  zscaler_cloud_name = try(each.value.scaler_cloud_name, null)
  zscaler_cloud_name_variable = try(each.value.zscaler_cloud_name_variable, null)
  zscaler_organization = try(each.value.zscaler_organization, null)
  zscaler_organization_variable = try(each.value.zscaler_organization_variable, null)
  zscaler_partner_api_key = try(each.value.zscaler_partner_api_key, null)
  zscaler_partner_api_key_variable = try(each.value.zscaler_partner_api_key_variable, null)
  zscaler_partner_base_uri = try(each.value.zscaler_partner_base_uri, null)
  zscaler_partner_base_uri_variable = try(each.value.zscaler_partner_base_uri_variable, null)
  zscaler_partner_password = try(each.value.zscaler_password, null)
  zscaler_partner_password_variable = try(each.value.zscaler_password_variable, null)
  zscaler_partner_username = try(each.value.zscaler_username, null)
  zscaler_partner_username_variable = try(each.value.zscaler_username_variable, null)
  zscaler_password = try(each.value.zscaler_password, null)
  zscaler_password_variable = try(each.value.zscaler_password_variable, null)
  zscaler_username = try(each.value.zscaler_username, null)
  zscaler_username_variable = try(each.value.zscaler_username_variable, null)
}