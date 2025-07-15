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

Inicialmente, a ideia era utilizar cada VM como um nó Kubernetes independente. No entanto, o ambiente começou a consumir muitos recursos, então a estratégia foi modificada: cada VM passou a utilizar o **Kind (Kubernetes in Docker)**, permitindo simular nós de forma mais leve.

Cada VM possui os seguintes recursos:

- **2 CPU**
- **2 GB de RAM**

---

## 3. Provisionamento

O provisionamento da infraestrutura foi realizado com o uso das seguintes ferramentas:

- **Packer:** Responsável por gerar a imagem `.box` utilizada pelas VMs.  
```bash
packer init .
packer plugin install github.com/hashicorp/virtualbox
packer plugin install github.com/hashicorp/vagrant
packer build debian.json
mv debian12.box vagrant/
```
- **Vagrant:** Utilizado para levantar as três máquinas virtuais.  
```bash
cd vagrant
vagrant box add debian12 debian12.box
vagrant up
sh ./add_ssh_figerprints.sh
```
- **Ansible:** Automatiza a configuração de cada máquina, como instalação de pacotes e setup do ambiente.  
```bash
cd ansible
ansible-playbook -i inventory/hosts.ini playbooks/main.yaml
```


---

## 4. Cluster Kubernetes

A configuração do cluster Kubernetes foi feita com o **Ansible**, que instala e configura o **Kind** em cada VM.

### Topologia do cluster:

- **1 nó Control Plane**
- **2 nós Workers**

Cada nó está hospedado dentro de uma VM distinta, totalizando três máquinas.

---

## 5. GitOps com ArgoCD

A instalação e configuração do **ArgoCD** também foi automatizada com **Ansible**.

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

Como solução, criei um repositório específico para a infraestrutura, contendo:

- Configuração para levantar as 3 VMs
- Instalação do Kind em cada uma
- Setup automatizado do ArgoCD
- Instalação do PostgreSQL na VM do banco de dados

### Principais desafios:

- **Playbooks grandes:** À medida que o projeto cresceu, os playbooks do Ansible ficaram extensos, e precisei começar a testá-los separadamente para economizar tempo de execução.
- **Variáveis de ambiente:** Trabalhar com variáveis de ambiente no Ansible foi um ponto de dificuldade, especialmente na organização e reutilização.

---

