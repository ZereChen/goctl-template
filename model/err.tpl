package {{.pkg}}

import "github.com/zeromicro/go-zero/core/stores/sqlx"

const (
	SelectBuilderTypeNormal string = "NORMAL"
	SelectBuilderTypeSum    string = "SUM"
	SelectBuilderTypeCount  string = "COUNT"
)

var ErrNotFound = sqlx.ErrNotFound
