resource "helm_release" "argocd" {
  name       = "argocd"
  namespace  = "argocd"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = "6.7.15" # ou última estável

  create_namespace = true

  depends_on = [module.eks]

}

resource "kubectl_manifest" "argocd_apps" {
  for_each   = fileset("${path.module}/../../manifests/argocd", "*.yaml")
  yaml_body  = file("${path.module}/../../manifests/argocd/${each.value}")
  depends_on = [helm_release.argocd]
}