variable "aws_region" {
  default = "us-east-2"
}

variable "cluster_name" {
  default = "devops-cluster"
}

variable "eks_admin_user_arn" {
  description = "ARN do usuário IAM que terá acesso administrador ao cluster EKS"
  type        = string
}

variable "db_username" {
  description = "Usuário do banco"
  type        = string
}

variable "db_password" {
  description = "Senha do banco"
  type        = string
  sensitive   = true
}

variable "db_name" {
  description = "Nome do banco"
  type        = string
}


variable "secret_key" {
  description = "Application secret key"
  type        = string
  sensitive   = true
}
