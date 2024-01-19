resource "sdwan_cli_template_feature_template" "cli_template_feature_template" {
  for_each     = { for t in try(local.edge_feature_templates.cli_templates, {}) : t.name => t }
  name         = each.value.name
  description  = each.value.description
  device_types = [for d in try(each.value.device_types, local.defaults.sdwan.edge_feature_templates.cli_templates.device_types) : try(local.device_type_map[d], "vedge-${d}")]
  cli_config   = each.value.cli_config
}
