package svc

import {{.imports}}
import (
    "github.com/zeromicro/go-zero/core/stores/sqlx"
    "github.com/zeromicro/go-zero/core/stores/redis"
)

type ServiceContext struct {
	Config config.Config
    RedisClient *redis.Redis
    // todo 这里添加rpc的依赖
    // DemoRpcClient demorpc.DemoRpc

	// todo 这里添加dao层orm的依赖
    // UserModel model.UserModel[model.User]

	// todo 这里添加service的依赖

}

func NewServiceContext(c config.Config) *ServiceContext {
    sqlConn := sqlx.NewMysql(c.Mysql.DataSource)

	return &ServiceContext{
		Config:c,
		RedisClient: redis.New(c.Redis.Host, func(r *redis.Redis) {
            r.Type = c.Redis.Type
            r.Pass = c.Redis.Pass
        }),
        // todo 这里添加RPC的依赖
        // DemoRpcClient: demorpc.NewDemoRpc(zrpc.MustNewClient(c.Rpc.DemoRpcClientConf)),

        // todo 这里初始化dao层orm的依赖
        // UserModel: model.NewUserModel[model.User](sqlConn, model.User{}),

        // todo 这里初始化service的依赖

	}
}
