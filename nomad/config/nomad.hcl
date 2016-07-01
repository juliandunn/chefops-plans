log_level = "INFO"
data_dir = "{{cfg.data_dir}}"

bind_addr = "0.0.0.0"
advertise {
  http = "{{svc.me.ip}}:4646"
  serf = "{{svc.me.ip}}:4648"
  rpc = "{{svc.me.ip}}:4647"
}

{{~#if cfg.server.enabled}}
server {
        enabled = true
        bootstrap_expect = {{cfg.server.bootstrap_expect}}
        retry_join = ["{{svc.leader.ip}}"]
        retry_interval = "15s"
}
{{~else}}
client {
  enabled = true
  servers = ["{{svc.leader.ip}}"]
}
{{~/if}}
