data "template_file" "nginx_ingress_values" {
  template = <<EOF
controller:
  kind: Deployment
  podAnnotations:
    prometheus.io/path: "/metrics"
    prometheus.io/port: "10254"
    prometheus.io/scrape: "true"
  stats:
    enabled: true
  metrics:
    enabled: true
  publishService:
    enabled: true
    publishServicePath: "$(POD_NAMESPACE)/nginx-ingress-controller"
  service:
    enableHttp: "true"
    enableHttps: "true"
    externalTrafficPolicy: Local
    type: LoadBalancer
  autoscaling:
    enabled: true
    maxReplicas: 4
    minReplicas: 1
    targetCPUUtilizationPercentage: 85
  resources:
    requests:
      cpu: 150m
      memory: 128Mi
    limits:
      cpu: 1
      memory: 512Mi
  updateStrategy:
    type: RollingUpdate
    rollingUpdate:
      maxSurge: 1
      maxUnavailable: 0
rbac:
  create: true
defaultBackend:
  enabled: false
EOF
}

resource "helm_release" "nginx_ingress" {
  name            = "nginx-ingress"
  repository      = "https://kubernetes.github.io/ingress-nginx"
  chart           = "ingress-nginx"
  version         = "3.34.0"
  cleanup_on_fail = true
  namespace       = "commons"

  values          = [data.template_file.nginx_ingress_values.rendered]
  depends_on      = [module.eks.cluster_id, kubernetes_namespace.commons]
}
