package svc

import (
	{{.configImport}}
)
import (
    "github.com/zeromicro/go-zero/core/stores/sqlx"
    "github.com/zeromicro/go-zero/core/stores/redis"
    "github.com/zeromicro/go-zero/zrpc"
    "x-think-backend/app/demo/cmd/rpc/client/thinkdemorpc"
)


type ServiceContext struct {
	Config {{.config}}
	RedisClient *redis.Redis
	{{.middleware}}
    // todo 这里添加rpc的依赖
    thinkdemorpc.ThinkDemoRpc

	// todo 这里添加dao层orm的依赖
    // UserModel model.UserModel[model.User]

    // todo 这里添加service的依赖

}

func NewServiceContext(c {{.config}}) *ServiceContext {
    sqlConn := sqlx.NewMysql(c.Mysql.DataSource)

	return &ServiceContext{
		Config: c,
		RedisClient: redis.MustNewRedis(c.Redis),
		{{.middlewareAssignment}}
        // todo 这里添加RPC的依赖
        ThinkDemoRpc: thinkdemorpc.NewThinkDemoRpc(zrpc.MustNewClient(c.Rpc.ThinkDemoRpcClientConf)),

		// todo 这里初始化dao层orm的依赖
        // UserModel: model.NewUserModel[model.User](sqlConn, model.User{}),

        // todo 这里初始化service的依赖

	}
}
