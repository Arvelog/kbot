{{/*
Return the fully qualified name of the helm chart.
*/}}
{{- define "helm.fullname" -}}
{{- printf "%s-%s" .Release.Name .Chart.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Return the name of the helm chart.
*/}}
{{- define "helm.name" -}}
{{- .Chart.Name -}}
{{- end -}}

{{/*
Return the labels for the deployment.
*/}}
{{- define "helm.labels" -}}
helm.sh/chart: {{ include "helm.name" . }}-{{ .Chart.Version | replace "+" "_" }}
{{ include "helm.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*
Return the selector labels for the deployment.
*/}}
{{- define "helm.selectorLabels" -}}
app.kubernetes.io/name: {{ include "helm.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}
