Delete(ctx context.Context, session sqlx.Session, {{.lowerStartCamelPrimaryKey}} {{.dataType}}) (sql.Result, error)
DeleteWhere(ctx context.Context, session sqlx.Session, pred interface{}, args ...interface{}) (sql.Result, error)