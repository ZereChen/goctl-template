
{{if .hasComment}}{{.comment}}{{end}}
func (s *{{.server}}Server) {{.method}} ({{if .notStream}}ctx context.Context,{{if .hasReq}} in {{.request}}{{end}}{{else}}{{if .hasReq}} in {{.request}},{{end}}stream {{.streamBody}}{{end}}) ({{if .notStream}}{{.response}},{{end}}error) {
	// todo 这里添加对in参数校验逻辑

	l := {{.logicPkg}}.New{{.logicName}}({{if .notStream}}ctx,{{else}}stream.Context(),{{end}}s.svcCtx)
	return l.{{.method}}({{if .hasReq}}in{{if .stream}} ,stream{{end}}{{else}}{{if .stream}}stream{{end}}{{end}})
}
