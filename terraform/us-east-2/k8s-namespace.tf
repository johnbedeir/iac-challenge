resource "kubernetes_namespace" "commons" {
  metadata {
    name = "commons"
  }

  depends_on = [module.eks.cluster_id]
}

resource "kubernetes_namespace" "tools" {
  metadata {
    name = "tools"
  }

  depends_on = [module.eks.cluster_id]
}

resource "kubernetes_namespace" "development" {
  metadata {
    name = "development"
  }

  depends_on = [module.eks.cluster_id]
}
