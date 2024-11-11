package config

import "github.com/zeromicro/go-zero/zrpc"

type Config struct {
	zrpc.RpcServerConf
	Mysql struct {
        DataSource string
    }
    Rpc struct {
        // todo 这里添加RPC的配置
        // DemoRpcClientConf zrpc.RpcClientConf
    }
}
