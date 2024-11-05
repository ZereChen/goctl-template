func (m *default{{.upperStartCamelObject}}Model[T]) FindOneBy{{.upperField}}(ctx context.Context, {{.in}}) (*T, error) {
	{{if .withCache}}{{.cacheKey}}
	var resp T
	err := m.QueryRowIndexCtx(ctx, &resp, {{.cacheKeyVariable}}, m.formatPrimary, func(ctx context.Context, conn sqlx.SqlConn, v any) (i any, e error) {
		query := fmt.Sprintf("select %s from %s where {{.originalField}} limit 1", m.{{.lowerStartCamelObject}}Rows, m.table)
		if err := conn.QueryRowCtx(ctx, &resp, query, {{.lowerStartCamelField}}); err != nil {
			return nil, err
		}
		return resp.{{.upperStartCamelPrimaryKey}}, nil
	}, m.queryPrimary)
	switch err {
	case nil:
		return &resp, nil
	case sqlc.ErrNotFound:
		return nil, ErrNotFound
	default:
		return nil, err
	}
}{{else}}var resp T
	query := fmt.Sprintf("select %s from %s where {{.originalField}} limit 1", m.{{.lowerStartCamelObject}}Rows, m.table )
	err := m.conn.QueryRowCtx(ctx, &resp, query, {{.lowerStartCamelField}})
	switch err {
	case nil:
		return &resp, nil
	case sqlx.ErrNotFound:
		return nil, ErrNotFound
	default:
		return nil, err
	}
}{{end}}

func (m *default{{.upperStartCamelObject}}Model[T]) FindList(ctx context.Context, builder squirrel.SelectBuilder, limit int64, offset int64, orderBy []string, pred interface{}, args ...interface{}) ([]*T, error) {
    if pred != nil {
        builder = builder.Where(pred, args)
    }
    if limit >= 0 {
        builder = builder.Limit(uint64(limit))
    }
    if offset >= 0 {
        builder = builder.Offset(uint64(offset))
    }
    if len(orderBy) == 0 {
        builder = builder.OrderBy("id DESC")
    } else {
        builder = builder.OrderBy(orderBy...)
    }
    query, values, err := builder.ToSql()
    if err != nil {
        return nil, err
    }
    var resp []*T
    err = m.conn.QueryRowsCtx(ctx, &resp, query, values...)
    switch err {
    case nil:
        return resp, nil
    default:
        return nil, err
    }
}

func (m *default{{.upperStartCamelObject}}Model[T]) FindListCustom(ctx context.Context, builder squirrel.SelectBuilder) ([]*T, error) {
    query, values, err := builder.ToSql()
	if err != nil {
		return nil, err
	}
	var resp []*T
	err = m.conn.QueryRowsCtx(ctx, &resp, query, values...)
	switch err {
	case nil:
		return resp, nil
	default:
		return nil, err
	}
}

func (m *default{{.upperStartCamelObject}}Model[T]) FindPageList(ctx context.Context, builder squirrel.SelectBuilder, page int64, pageSize int64, orderBy []string, pred interface{}, args ...interface{}) ([]*T, error) {
    if pred != nil {
        builder = builder.Where(pred, args)
    }
    if page < 1 {
        page = 1
    }
    offset := (page - 1) * pageSize
    builder = builder.Offset(uint64(offset)).Limit(uint64(pageSize))
    if len(orderBy) == 0 {
        builder = builder.OrderBy("id DESC")
    } else {
        builder = builder.OrderBy(orderBy...)
    }
    query, values, err := builder.ToSql()
    if err != nil {
        return nil, err
    }
    var resp []*T
    err = m.conn.QueryRowsCtx(ctx, &resp, query, values...)
    switch err {
    case nil:
        return resp, nil
    default:
        return nil, err
    }
}

func (m *default{{.upperStartCamelObject}}Model[T]) FindPageListWithTotal(ctx context.Context, builder squirrel.SelectBuilder, page int64, pageSize int64, orderBy []string, pred interface{}, args ...interface{}) ([]*T, int64, error) {
    countBuilder := m.SelectBuilder("COUNT", "id")
    total, err := m.FindCount(ctx, countBuilder, orderBy, pred)
    if err != nil {
        return nil, 0, err
    }
    var resp []*T
    resp, err = m.FindPageList(ctx, builder, page, pageSize, orderBy, pred, args)
    switch err {
    case nil:
        return resp, total, nil
    default:
        return nil, total, err
    }
}

func (m *default{{.upperStartCamelObject}}Model[T]) FindCount(ctx context.Context, builder squirrel.SelectBuilder, orderBy []string, pred interface{}, args ...interface{}) (int64, error) {
    if pred != nil {
        builder = builder.Where(pred, args)
    }
    if len(orderBy) == 0 {
        builder = builder.OrderBy("id DESC")
    } else {
        builder = builder.OrderBy(orderBy...)
    }
    query, values, err := builder.ToSql()
    if err != nil {
        return 0, err
    }
    var resp int64
    err = m.conn.QueryRowPartialCtx(ctx, &resp, query, values...)
    switch err {
    case nil:
        return resp, nil
    default:
        return 0, err
    }
}

func (m *default{{.upperStartCamelObject}}Model[T]) FindSum(ctx context.Context, builder squirrel.SelectBuilder, orderBy []string, pred interface{}, args ...interface{}) (float64, error) {
    if pred != nil {
        builder = builder.Where(pred, args)
    }
    if len(orderBy) == 0 {
        builder = builder.OrderBy("id DESC")
    } else {
        builder = builder.OrderBy(orderBy...)
    }
    query, values, err := builder.ToSql()
    if err != nil {
        return 0, err
    }
    var resp float64
    err = m.conn.QueryRowPartialCtx(ctx, &resp, query, values...)
    switch err {
    case nil:
        return resp, nil
    default:
        return 0, err
    }
}
