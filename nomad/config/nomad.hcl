log_level = "INFO"
data_dir = "{{cfg.server.data_dir}}"

bind_addr = "0.0.0.0"
advertise {
  rpc = "{{svc.me.ip}}:4647"
}

{{~#if cfg.server}}
server {
        enabled = true
        bootstrap_expect = 1
        start_join = ["{{svc.leader.ip}}"]
        retry_join = ["{{svc.leader.ip}}"]
        retry_interval = "15s"
}
{{~/if}}
