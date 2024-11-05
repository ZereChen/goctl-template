func (m *default{{.upperStartCamelObject}}Model[T]) Init(data T) {
	m.userFieldNames = builder.RawFieldNames(data)
	m.userRows = strings.Join(m.userFieldNames, ",")
	m.userRowsExpectAutoSet = strings.Join(stringx.Remove(m.userFieldNames, "`id`", "`create_time`", "`update_time`"), ",")
	m.userRowsWithPlaceHolder = strings.Join(stringx.Remove(m.userFieldNames, "`id`", "`create_time`", "`update_time`"), "=?,") + "=?"
}

func (m *default{{.upperStartCamelObject}}Model[T]) Trans(ctx context.Context, fn func(context context.Context, session sqlx.Session) error) error {
    return m.conn.TransactCtx(ctx, func(ctx context.Context, session sqlx.Session) error {
        return fn(ctx, session)
    })
}

func (m *default{{.upperStartCamelObject}}Model[T]) SelectBuilder(opType string, field interface{}) squirrel.SelectBuilder {
    if opType == "SUM" {
        if field != "" {
            return squirrel.Select("IFNULL(SUM(" + field.(string) + "),0)").From(m.table)
        } else {
            return squirrel.Select("IFNULL(SUM(id),0)").From(m.table)
        }
    }
    if opType == "COUNT" {
        if field != "" {
            return squirrel.Select("COUNT(" + field.(string) + ")").From(m.table)
        } else {
            return squirrel.Select("COUNT(*)").From(m.table)
        }
    }
    if field != nil {
        userfieldNameTmp := builder.RawFieldNames(field)
        return squirrel.Select(userfieldNameTmp...).From(m.table)
    } else {
        return squirrel.Select(m.userFieldNames...).From(m.table)
    }
}

func (m *default{{.upperStartCamelObject}}Model[T]) Insert(ctx context.Context, session sqlx.Session, data *{{.upperStartCamelObject}}) (sql.Result,error) {
	{{if .withCache}}{{.keys}}
    ret, err := m.ExecCtx(ctx, func(ctx context.Context, conn sqlx.SqlConn) (result sql.Result, err error) {
		query := fmt.Sprintf("insert into %s (%s) values ({{.expression}})", m.table, m.{{.lowerStartCamelObject}}RowsExpectAutoSet)
		return conn.ExecCtx(ctx, query, {{.expressionValues}})
	}, {{.keyValues}}){{else}}query := fmt.Sprintf("insert into %s (%s) values ({{.expression}})", m.table, m.{{.lowerStartCamelObject}}RowsExpectAutoSet)
    if session != nil {
        return session.ExecCtx(ctx, query, {{.expressionValues}})
    } else {
        return m.conn.ExecCtx(ctx, query, {{.expressionValues}})
    }{{end}}
}
