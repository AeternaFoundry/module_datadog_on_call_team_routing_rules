resource "datadog_on_call_team_routing_rules" "on_call_team_routing_rules" {
  for_each = var.on_call_team_routing_rules

  id = each.value.id

  dynamic "rule" {
    for_each = each.value.rule != null ? each.value.rule : []
    content {
      dynamic "action" {
        for_each = rule.value.action != null ? rule.value.action : []
        content {
          dynamic "escalation_policy" {
            for_each = action.value.escalation_policy != null ? action.value.escalation_policy : []
            content {
              ack_timeout_minutes = escalation_policy.value.ack_timeout_minutes
              policy_id           = escalation_policy.value.policy_id
              dynamic "support_hours" {
                for_each = escalation_policy.value.support_hours != null ? escalation_policy.value.support_hours : []
                content {
                  dynamic "restriction" {
                    for_each = support_hours.value.restriction != null ? support_hours.value.restriction : []
                    content {
                      end_day    = restriction.value.end_day
                      end_time   = restriction.value.end_time
                      start_day  = restriction.value.start_day
                      start_time = restriction.value.start_time
                    }
                  }
                  time_zone = support_hours.value.time_zone
                }
              }
              urgency = escalation_policy.value.urgency
            }
          }
          dynamic "send_slack_message" {
            for_each = action.value.send_slack_message != null ? action.value.send_slack_message : []
            content {
              channel   = send_slack_message.value.channel
              workspace = send_slack_message.value.workspace
            }
          }
          dynamic "send_teams_message" {
            for_each = action.value.send_teams_message != null ? action.value.send_teams_message : []
            content {
              channel = send_teams_message.value.channel
              team    = send_teams_message.value.team
              tenant  = send_teams_message.value.tenant
            }
          }
          dynamic "trigger_workflow_automation" {
            for_each = action.value.trigger_workflow_automation != null ? action.value.trigger_workflow_automation : []
            content {
              handle = trigger_workflow_automation.value.handle
            }
          }
        }
      }
      escalation_policy = rule.value.escalation_policy
      query             = rule.value.query
      dynamic "time_restrictions" {
        for_each = rule.value.time_restrictions != null ? rule.value.time_restrictions : []
        content {
          dynamic "restriction" {
            for_each = time_restrictions.value.restriction != null ? time_restrictions.value.restriction : []
            content {
              end_day    = restriction.value.end_day
              end_time   = restriction.value.end_time
              start_day  = restriction.value.start_day
              start_time = restriction.value.start_time
            }
          }
          time_zone = time_restrictions.value.time_zone
        }
      }
      urgency = rule.value.urgency
    }
  }
}

