import os

# Lista com os nomes dos arquivos
arquivos = [
    "argocd.tf",
    "auth.tf",
    "backend-vars.tf",
    "ecr.tf",
    "eks.tf",
    "frontend-vars.tf",
    "iam.tf",
    "outputs.tf",
    "provider.tf",
    "rds.tf",
    "terraform.tfvars",
    "variables.tf",
    "versions.tf",
    "vpc.tf",
]

# Loop para percorrer os arquivos e imprimir no formato desejado
for arquivo in arquivos:
    if os.path.exists(arquivo):  # Verifica se o arquivo existe
        with open(arquivo, "r", encoding="utf-8") as f:
            conteudo = f.read()
            print(f"# {arquivo}")
            print(conteudo)
            print("-" * 40)  # Linha separadora para facilitar a leitura
    else:
        print(f"Arquivo {arquivo} não encontrado.")
