package {{.PkgName}}

import (
    "github.com/go-playground/validator/v10"
	"net/http"

	"github.com/zeromicro/go-zero/rest/httpx"
	"x-think-backend/common/result"
	{{.ImportPackages}}
)

{{if .HasDoc}}{{.Doc}}{{end}}
func {{.HandlerName}}(svcCtx *svc.ServiceContext) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		{{if .HasRequest}}var req types.{{.RequestType}}
		if err := httpx.Parse(r, &req); err != nil {
			result.ParamErrorResult(r, w, err)
			return
		}
        if err := validator.New().StructCtx(r.Context(), req); err != nil {
            result.ParamErrorResult(r, w, err)
            return
        }
		// todo 这里添加对Request参数校验逻辑

		{{end}}l := {{.LogicName}}.New{{.LogicType}}(r.Context(), svcCtx)

		{{if .HasResp}}resp, {{end}}err := l.{{.Call}}({{if .HasRequest}}&req{{end}})
		result.HttpResult(r, w, resp, err)
	}
}
