package config

import (
    "github.com/zeromicro/go-zero/zrpc"
    "github.com/zeromicro/go-zero/core/stores/redis"
)

type Config struct {
	zrpc.RpcServerConf
	Redis redis.RedisConf
	Mysql struct {
        DataSource string
    }
    Rpc struct {
        // todo 这里添加RPC的配置
        // DemoRpcClientConf zrpc.RpcClientConf
    }
}
