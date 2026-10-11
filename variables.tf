variable "on_call_team_routing_rules" {
  description = <<EOT
Map of on_call_team_routing_rules, attributes below
Required:
    - id
Optional:
    - rule (block):
        - action (optional, block):
            - escalation_policy (optional, block):
                - ack_timeout_minutes (optional)
                - policy_id (optional)
                - support_hours (optional, block):
                    - restriction (optional, block):
                        - end_day (optional)
                        - end_time (optional)
                        - start_day (optional)
                        - start_time (optional)
                    - time_zone (optional)
                - urgency (optional)
            - send_slack_message (optional, block):
                - channel (optional)
                - workspace (optional)
            - send_teams_message (optional, block):
                - channel (optional)
                - team (optional)
                - tenant (optional)
            - trigger_workflow_automation (optional, block):
                - handle (optional)
        - escalation_policy (optional)
        - query (optional)
        - time_restrictions (optional, block):
            - restriction (optional, block):
                - end_day (optional)
                - end_time (optional)
                - start_day (optional)
                - start_time (optional)
            - time_zone (optional)
        - urgency (optional)
EOT

  type = map(object({
    id = string
    rule = optional(list(object({
      action = optional(list(object({
        escalation_policy = optional(list(object({
          ack_timeout_minutes = optional(number)
          policy_id           = optional(string)
          support_hours = optional(list(object({
            restriction = optional(list(object({
              end_day    = optional(string)
              end_time   = optional(string)
              start_day  = optional(string)
              start_time = optional(string)
            })))
            time_zone = optional(string)
          })))
          urgency = optional(string)
        })))
        send_slack_message = optional(list(object({
          channel   = optional(string)
          workspace = optional(string)
        })))
        send_teams_message = optional(list(object({
          channel = optional(string)
          team    = optional(string)
          tenant  = optional(string)
        })))
        trigger_workflow_automation = optional(list(object({
          handle = optional(string)
        })))
      })))
      escalation_policy = optional(string)
      query             = optional(string)
      time_restrictions = optional(list(object({
        restriction = optional(list(object({
          end_day    = optional(string)
          end_time   = optional(string)
          start_day  = optional(string)
          start_time = optional(string)
        })))
        time_zone = optional(string)
      })))
      urgency = optional(string)
    })))
  }))
}

