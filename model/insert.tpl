func (m *default{{.upperStartCamelObject}}Model[T]) Init(data T) {
	m.{{.lowerStartCamelObject}}FieldNames = builder.RawFieldNames(data)
	m.{{.lowerStartCamelObject}}Rows = strings.Join(m.{{.lowerStartCamelObject}}FieldNames, ",")
	m.{{.lowerStartCamelObject}}RowsExpectAutoSet = strings.Join(stringx.Remove(m.{{.lowerStartCamelObject}}FieldNames, "`id`", "`create_at`", "`update_at`"), ",")
	m.{{.lowerStartCamelObject}}RowsWithPlaceHolder = strings.Join(stringx.Remove(m.{{.lowerStartCamelObject}}FieldNames, "`id`", "`create_at`", "`update_at`"), "=?,") + "=?"
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
        return squirrel.Select(m.{{.lowerStartCamelObject}}FieldNames...).From(m.table)
    }
}

func (m *default{{.upperStartCamelObject}}Model[T]) Insert(ctx context.Context, session sqlx.Session, data *{{.upperStartCamelObject}}) (sql.Result,error) {
    data.Uuid = uuid.New().String()
    data.DeleteAt = time.Unix(0, 0)
	data.State = globalkey.DelStateNo
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
