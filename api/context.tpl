package svc

import (
	{{.configImport}}
)
import "github.com/zeromicro/go-zero/core/stores/sqlx"

type ServiceContext struct {
	Config {{.config}}
	{{.middleware}}
	// todo 这里添加dao层orm的依赖

    // todo 这里添加service的依赖
}

func NewServiceContext(c {{.config}}) *ServiceContext {
    sqlConn := sqlx.NewMysql(c.DB.DataSource)

	return &ServiceContext{
		Config: c,
		// todo 这里初始化dao层orm的依赖

        // todo 这里初始化service的依赖

		{{.middlewareAssignment}}
	}
}
