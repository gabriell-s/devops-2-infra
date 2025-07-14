ANSIBLE_DIR=ansible
INVENTORY=$(ANSIBLE_DIR)/inventory/hosts.ini
PLAYBOOK_DIR=$(ANSIBLE_DIR)/playbooks
EXTRA_VARS="pg_user=devops pg_password=devops pg_database=devops_db"

.PHONY: setup postgres argocd backend frontend all

## Roda tudo (setup + postgres + argocd + apps)
all: setup postgres argocd backend frontend

## Prepara as VMs com kind + kubeconfig
setup:
	ansible-playbook -i $(INVENTORY) $(PLAYBOOK_DIR)/setup_kind.yaml --ask-become-pass

## Instala e configura o PostgreSQL
postgres:
	ansible-playbook -i $(INVENTORY) $(PLAYBOOK_DIR)/install_postgres.yaml --extra-vars $(EXTRA_VARS) --ask-become-pass

## Instala o ArgoCD nos clusters
argocd:
	ansible-playbook -i $(INVENTORY) $(PLAYBOOK_DIR)/install_argocd.yaml --ask-become-pass

## Configura o backend no ArgoCD
backend:
	ansible-playbook -i $(INVENTORY) $(PLAYBOOK_DIR)/configure_backend.yaml --ask-become-pass

## Configura o frontend no ArgoCD
frontend:
	ansible-playbook -i $(INVENTORY) $(PLAYBOOK_DIR)/configure_frontend.yaml --ask-become-pass
