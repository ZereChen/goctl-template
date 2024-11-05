func (m *default{{.upperStartCamelObject}}Model[T]) Update(ctx context.Context, session sqlx.Session, {{if .containsIndexCache}}newData{{else}}data{{end}} *{{.upperStartCamelObject}}) (sql.Result, error) {
	{{if .withCache}}{{if .containsIndexCache}}data, err:=m.FindOne(ctx, newData.{{.upperStartCamelPrimaryKey}})
	if err!=nil{
		return err
	}

{{end}}	{{.keys}}
    _, {{if .containsIndexCache}}err{{else}}err:{{end}}= m.ExecCtx(ctx, func(ctx context.Context, conn sqlx.SqlConn) (result sql.Result, err error) {
		query := fmt.Sprintf("update %s set %s where {{.originalPrimaryKey}} = {{if .postgreSql}}$1{{else}}?{{end}}", m.table, m.{{.lowerStartCamelObject}}RowsWithPlaceHolder)
		return conn.ExecCtx(ctx, query, {{.expressionValues}})
	}, {{.keyValues}}){{else}}query := fmt.Sprintf("update %s set %s where {{.originalPrimaryKey}} = {{if .postgreSql}}$1{{else}}?{{end}}", m.table, m.{{.lowerStartCamelObject}}RowsWithPlaceHolder)
    if session != nil {
        return session.ExecCtx(ctx, query, {{.expressionValues}})
    } else {
        return m.conn.ExecCtx(ctx, query, {{.expressionValues}})
    }{{end}}
}


func (m *default{{.upperStartCamelObject}}Model[T]) UpdateSome(ctx context.Context, session sqlx.Session, setContent map[string]interface{}, pred interface{}, args ...interface{}) (sql.Result, error) {
    builder := squirrel.Update(m.table)
    for k, v := range setContent {
        builder = builder.Set(k, v)
    }
    if pred != nil {
        builder = builder.Where(pred, args)
    }
    toSql, param, err := builder.ToSql()
    if err != nil {
        return nil, err
    }
    if session != nil {
        return session.ExecCtx(ctx, toSql, param...)
    } else {
        return m.conn.ExecCtx(ctx, toSql, param...)
    }
}