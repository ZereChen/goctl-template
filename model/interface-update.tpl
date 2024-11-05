Update(ctx context.Context, session sqlx.Session, {{if .containsIndexCache}}newData{{else}}data{{end}} *{{.upperStartCamelObject}}) (sql.Result, error)
UpdateSome(ctx context.Context, session sqlx.Session, setContent map[string]interface{}, pred interface{}, args ...interface{}) (sql.Result, error)
