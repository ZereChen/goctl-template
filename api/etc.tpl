Name: {{.serviceName}}-svc
Host: {{.host}}
Port: {{.port}}
Mode: pro

Log:
  ServiceName: {{.serviceName}}
  Level: error

Redis:
  Host: redis-svc.{namespace}-base:6379
  Type: node
  Pass: redispassword

Mysql:
  DataSource: root:root@tcp(mysql-svc.{namespace}-base:3306)/{{.serviceName}}?charset=utf8mb4&parseTime=true&loc=Asia%2FShanghai

Rpc:
  # todo 这里添加RPC的配置
  DemoRpcClientConf:
    Endpoints:
      - demorpc-svc:8080
    NonBlock: true
