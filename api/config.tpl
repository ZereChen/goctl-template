package config

import {{.authImport}}
import (
    "github.com/zeromicro/go-zero/zrpc"
    "github.com/zeromicro/go-zero/core/stores/redis"
)

type Config struct {
	rest.RestConf
	Redis redis.RedisConf
	Mysql struct {
        DataSource string
    }
    Rpc struct {
        // todo 这里添加RPC的配置
        ThinkDemoRpcClientConf zrpc.RpcClientConf
    }
	{{.auth}}
	{{.jwtTrans}}
}
