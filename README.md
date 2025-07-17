# Trabalho Final – Fundamentos de DevOps  
**Aluno:** Gabriel Silveira

---

## 1. Introdução

Este projeto consiste em uma aplicação full stack com os seguintes componentes:

- **Backend:** Django com Django Rest Framework (DRF)  
- **Frontend:** Vue 3 com TypeScript  
- **Banco de Dados:** PostgreSQL

O objetivo é provisionar e configurar um ambiente Kubernetes distribuído em três máquinas virtuais (VMs), utilizando ferramentas de infraestrutura como código e GitOps.

---

## 2. Escolha do Ambiente

Inicialmente, a ideia era utilizar cada VM como um nó Kubernetes independente. No entanto troquei para utilizar terraform com AWS. 

Cada máquina possui os seguintes recursos:

- **2 CPU**
- **4 GB de RAM**

---

## 3. Provisionamento

O provisionamento da infraestrutura foi realizado com o uso das seguinte ferramenta:

- **Terraform:**
```bash
cd terraform/infra
terraform init
terraform apply
```

---

## 4. Cluster Kubernetes

A configuração do cluster Kubernetes foi feita com o **EKS**.

---

## 5. GitOps com ArgoCD

A instalação e configuração do **ArgoCD** também foi automatizada com **Terraform**.

O ArgoCD é responsável por aplicar os manifests de infraestrutura e aplicação a partir dos repositórios Git, seguindo a abordagem GitOps.

---

## 6. Aplicação

A aplicação é composta por três componentes principais:

- **Backend:** API desenvolvida com Django e Django Rest Framework.  
- **Frontend:** Aplicação SPA feita com Vue 3 e TypeScript.  
- **Banco de Dados:** PostgreSQL, instalado diretamente na VM designada para o banco.

---

## 7. Conclusão

Durante o desenvolvimento deste projeto, explorei diferentes abordagens para estruturar a infraestrutura. Inicialmente, planejei isolar cada componente (backend, frontend e banco) em sua própria infraestrutura completa, mas isso se mostrou inviável em termos de consumo de recursos — só o frontend já exigia aumento de RAM para funcionar corretamente.

Como solução, utilizei terraform com aws.

### Principais desafios:

- **Complexidade:** Demorei a entender os arquivos se comportavam e qual sua relevancia.
- **Demora:** Subir e destruir a aplicação levava um tempo consideravel.
- **Leitura de erros:** Alguns erros não tinham muita informação, o que dificultava encontrar uma solução.

---

