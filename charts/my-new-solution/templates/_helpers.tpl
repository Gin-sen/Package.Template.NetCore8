{{/*
    GENERAL
*/}}
{{/*
    Expand the name of the chart.
*/}}
{{- define "my-new-solution.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
    Create chart name and version as used by the chart label.
*/}}
{{- define "my-new-solution.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
    API
*/}}

{{/*
    Create a default fully qualified app name.
    We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
    If release name contains chart name it will be used as a full name.
*/}}
{{- define "my-new-solution.fullname-api" -}}
{{- if .Values.fullnameOverride.api }}
{{- .Values.fullnameOverride.api | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride.api }}
{{- if contains $name .Release.Name }}
{{- (printf "%s-api" .Release.Name) | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s-api" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
    Common labels
*/}}
{{- define "my-new-solution.labels-api" -}}
helm.sh/chart: {{ include "my-new-solution.chart" . }}
{{ include "my-new-solution.selectorLabels-api" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "my-new-solution.selectorLabels-api" -}}
app.kubernetes.io/name: {{ include "my-new-solution.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/component: "api"
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "my-new-solution.serviceAccountName-api" -}}
{{- if .Values.serviceAccount.api.create }}
{{- default (include "my-new-solution.fullname-api" .) .Values.serviceAccount.api.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.api.name }}
{{- end }}
{{- end }}

{{/*
    WORKER
*/}}

{{/*
    Create a default fully qualified app name.
    We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
    If release name contains chart name it will be used as a full name.
*/}}
{{- define "my-new-solution.fullname-worker" -}}
{{- if .Values.fullnameOverride.worker }}
{{- .Values.fullnameOverride.worker | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride.worker }}
{{- if contains $name .Release.Name }}
{{- (printf "%s-worker" .Release.Name) | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s-worker" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
    Common labels
*/}}
{{- define "my-new-solution.labels-worker" -}}
helm.sh/chart: {{ include "my-new-solution.chart" . }}
{{ include "my-new-solution.selectorLabels-worker" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "my-new-solution.selectorLabels-worker" -}}
app.kubernetes.io/name: {{ include "my-new-solution.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/component: "worker"
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "my-new-solution.serviceAccountName-worker" -}}
{{- if .Values.serviceAccount.worker.create }}
{{- default (include "my-new-solution.fullname-worker" .) .Values.serviceAccount.worker.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.worker.name }}
{{- end }}
{{- end }}
