Name: {{.serviceName}}.api
Host: {{.host}}
Port: {{.port}}
Mode: dev

Log:
  ServiceName: {{.serviceName}}
  Level: error

Redis:
  Host: 127.0.0.1:6379
  Type: node
  Pass: redispassword
  Key: {{.serviceName}}-api

Mysql:
  DataSource: root:root@tcp(127.0.0.1:3306)/{{.serviceName}}?charset=utf8mb4&parseTime=true&loc=Asia%2FShanghai

Rpc:
  # todo 这里添加RPC的配置，本地直连用Endpoints，远程K8s用Target
  DemoRpcClientConf:
    Endpoints:
      - 127.0.0.1:8080
    NonBlock: true