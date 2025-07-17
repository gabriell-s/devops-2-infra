resource "kubectl_manifest" "aws_auth" {
  yaml_body = <<YAML
apiVersion: v1
kind: ConfigMap
metadata:
  name: aws-auth
  namespace: kube-system
data:
  mapUsers: |
    - userarn: ${var.eks_admin_user_arn}
      username: admin
      groups:
        - system:masters
YAML

  depends_on = [module.eks]
}
