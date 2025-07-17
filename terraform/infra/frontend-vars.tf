resource "kubernetes_config_map" "frontend_env" {
  metadata {
    name      = "frontend-config"
    namespace = "default"
  }

  data = {
    VITE_API_URL = "http://devops-backend-service.default.svc.cluster.local:8080"
  }

  depends_on = [module.eks]
}
