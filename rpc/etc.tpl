Name: {{.serviceName}}.rpc
ListenOn: 0.0.0.0:8080
Mode: dev

# 远程配置要解开注释
#Etcd:
#  Hosts:
#  - 127.0.0.1:2379
#  Key: {{.serviceName}}.rpc

Redis:
  Host: 127.0.0.1:6379
  Type: node
  Pass: redispassword
  Key: {{.serviceName}}-rpc

Mysql:
  DataSource: root:root@tcp(127.0.0.1:33069)/x_think_{{.serviceName}}?charset=utf8mb4&parseTime=true&loc=Asia%2FShanghai

