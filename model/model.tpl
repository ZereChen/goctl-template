package {{.pkg}}
{{if .withCache}}
import (
	"github.com/zeromicro/go-zero/core/stores/cache"
	"github.com/zeromicro/go-zero/core/stores/sqlx"
	"github.com/zeromicro/go-zero/core/stores/sqlc"
)
{{else}}

import "github.com/zeromicro/go-zero/core/stores/sqlx"
{{end}}

type (
	// {{.upperStartCamelObject}}Model is an interface to be customized, add more methods here,
	// and implement the added methods in custom{{.upperStartCamelObject}}Model.
	{{.upperStartCamelObject}}Model[T any] interface {
		{{.lowerStartCamelObject}}Model[T]
		{{if not .withCache}}withSession(session sqlx.Session) {{.upperStartCamelObject}}Model[T]{{end}}
	}

	custom{{.upperStartCamelObject}}Model[T any] struct {
		*default{{.upperStartCamelObject}}Model[T]
	}
)

// New{{.upperStartCamelObject}}Model returns a model for the database table.
func New{{.upperStartCamelObject}}Model[T any](conn sqlx.SqlConn{{if .withCache}}, c cache.CacheConf, opts ...cache.Option{{end}}) {{.upperStartCamelObject}}Model[T] {
	return &custom{{.upperStartCamelObject}}Model[T]{
		default{{.upperStartCamelObject}}Model: new{{.upperStartCamelObject}}Model[T](conn{{if .withCache}}, c, opts...{{end}}),
	}
}

{{if not .withCache}}
func (m *custom{{.upperStartCamelObject}}Model[T]) withSession(session sqlx.Session) {{.upperStartCamelObject}}Model[T] {
    return New{{.upperStartCamelObject}}Model[T](sqlx.NewSqlConnFromSession(session))
}
{{end}}

