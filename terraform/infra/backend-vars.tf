resource "kubernetes_secret" "backend_env" {
  metadata {
    name      = "backend-secret"
    namespace = "default"
  }

  data = {
    DEBUG        = "False"
    DATABASE_URL = "postgres://${var.db_username}:${var.db_password}@${aws_db_instance.devops.endpoint}/${var.db_name}"
    SECRET_KEY   = var.secret_key
  }

  type = "Opaque"

  depends_on = [module.eks]
}
