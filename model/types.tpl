type (
	{{.lowerStartCamelObject}}Model[T any] interface{
		{{.method}}
	}

	default{{.upperStartCamelObject}}Model[T any] struct {
		{{if .withCache}}sqlc.CachedConn{{else}}conn sqlx.SqlConn{{end}}
		table string
		{{.lowerStartCamelObject}}FieldNames []string
        {{.lowerStartCamelObject}}Rows string
        {{.lowerStartCamelObject}}RowsExpectAutoSet string
        {{.lowerStartCamelObject}}RowsWithPlaceHolder string

	}

	{{.upperStartCamelObject}} struct {
		{{.fields}}
	}
)
