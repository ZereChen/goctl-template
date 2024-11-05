func new{{.upperStartCamelObject}}Model[T any](conn sqlx.SqlConn{{if .withCache}}, c cache.CacheConf, opts ...cache.Option{{end}}) *default{{.upperStartCamelObject}}Model[T] {
	return &default{{.upperStartCamelObject}}Model[T]{
		{{if .withCache}}CachedConn: sqlc.NewConn(conn, c, opts...){{else}}conn:conn{{end}},
		table:      {{.table}},
	}
}

