output "on_call_team_routing_rules_id" {
  description = "Map of id values across all on_call_team_routing_rules, keyed the same as var.on_call_team_routing_rules except keys with no id are omitted"
  value       = { for k, v in datadog_on_call_team_routing_rules.on_call_team_routing_rules : k => v.id if v.id != null && length(v.id) > 0 }
}
output "on_call_team_routing_rules_rule" {
  description = "Map of rule values across all on_call_team_routing_rules, keyed the same as var.on_call_team_routing_rules except keys with no rule are omitted"
  value       = { for k, v in datadog_on_call_team_routing_rules.on_call_team_routing_rules : k => v.rule if v.rule != null && length(v.rule) > 0 }
}

