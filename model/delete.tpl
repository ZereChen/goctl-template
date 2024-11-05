func (m *default{{.upperStartCamelObject}}Model[T]) Delete(ctx context.Context, session sqlx.Session, {{.lowerStartCamelPrimaryKey}} {{.dataType}}) (sql.Result, error) {
	{{if .withCache}}{{if .containsIndexCache}}data, err:=m.FindOne(ctx, {{.lowerStartCamelPrimaryKey}})
	if err!=nil{
		return err
	}

{{end}}	{{.keys}}
    _, err {{if .containsIndexCache}}={{else}}:={{end}} m.ExecCtx(ctx, func(ctx context.Context, conn sqlx.SqlConn) (result sql.Result, err error) {
		query := fmt.Sprintf("delete from %s where {{.originalPrimaryKey}} = {{if .postgreSql}}$1{{else}}?{{end}}", m.table)
		return conn.ExecCtx(ctx, query, {{.lowerStartCamelPrimaryKey}})
	}, {{.keyValues}}){{else}}query := fmt.Sprintf("delete from %s where {{.originalPrimaryKey}} = {{if .postgreSql}}$1{{else}}?{{end}}", m.table)
	    if session != nil {
            return session.ExecCtx(ctx, query, {{.lowerStartCamelPrimaryKey}})
        } else {
            return m.conn.ExecCtx(ctx, query, {{.lowerStartCamelPrimaryKey}})
        }{{end}}
}

func (m *default{{.upperStartCamelObject}}Model[T]) DeleteWhere(ctx context.Context, session sqlx.Session, pred interface{}, args ...interface{}) (sql.Result, error) {
    builder := squirrel.Delete(m.table)
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