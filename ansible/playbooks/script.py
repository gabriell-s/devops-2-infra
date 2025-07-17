import os

# Lista com os nomes dos arquivos
arquivos = [
    "apply_secret.yaml",
    "configure_frontend.yaml",
    "install_postgres.yaml",
    "configure_backend.yaml",
    "install_argocd.yaml",
    "main.yaml",
    "setup_kind.yaml",
]
#
# percorrer os arquivos e imprimir no formato desejado
for arquivo in arquivos:
    if os.path.exists(arquivo):  # Verifica se o arquivo existe
        with open(arquivo, "r", encoding="utf-8") as f:
            conteudo = f.read()
            print(f"# {arquivo}")
            print(conteudo)
            print("-" * 40)  # Linha separadora para facilitar a leitura
    else:
        print(f"Arquivo {arquivo} não encontrado.")
