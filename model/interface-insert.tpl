Init(T)
tableName() string
Trans(ctx context.Context, fn func(context context.Context, session sqlx.Session) error) error
SelectBuilder(opType string, data interface{}) squirrel.SelectBuilder

Insert(ctx context.Context, session sqlx.Session, data *{{.upperStartCamelObject}}) (sql.Result,error)