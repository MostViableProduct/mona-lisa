---
description: "Show MoVP connection and configuration status"
---
Read the MoVP effective config by accessing the `movp://movp/config` MCP resource, then present a clean status summary.

Format the output as follows:

```
[MoVP] Status

Connection
  Workdesk:  <WORKDESK_SERVICE_URL or "not configured">
  Tenant:    <tenant ID from WORKDESK_TENANT or "not configured">

Review Config
  Enabled:        <yes/no>
  Auto-review:    plan files=<yes/no>  code output=<yes/no>
  Max rounds:     <max_rounds>
  Cost cap/day:   $<cost_cap_daily_usd>

Categories (<N> configured, all weights equal / weights vary)
  <name> (weight: <w>)
  ...

Control Plane
  Health check interval:  <N>s
  Show cost:              <yes/no>
  Show recommendations:   <yes/no>
```

If the config resource returns an error, show the error and note that the user should run `npx @movp/cli init` to configure MoVP.

If WORKDESK_SERVICE_URL or WORKDESK_TENANT environment variables are not set, note that the MCP server is not fully configured.

Do not call any other tools. Only read the `movp://movp/config` resource.
