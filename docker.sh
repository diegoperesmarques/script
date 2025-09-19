#!/bin/bash

# Este script instala o Docker Engine em sistemas baseados em Debian/Ubuntu.
# Ele deve ser executado com privilégios de superusuário (sudo).

# Garante que o script pare em caso de erro
set -e

echo ">>> Iniciando a instalação do Docker..."

# 1. Atualiza a lista de pacotes e instala pré-requisitos
echo ">>> Passo 1/5: Atualizando pacotes e instalando dependências..."
sudo apt-get update
sudo apt-get install -y ca-certificates curl

# 2. Adiciona a chave GPG oficial do Docker
echo ">>> Passo 2/5: Adicionando a chave GPG do Docker..."
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# 3. Adiciona o repositório do Docker às fontes do Apt
echo ">>> Passo 3/5: Configurando o repositório do Docker..."
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# 4. Atualiza a lista de pacotes novamente com o novo repositório
echo ">>> Passo 4/5: Atualizando a base de dados de pacotes..."
sudo apt-get update

# 5. Instala a versão mais recente do Docker Engine
echo ">>> Passo 5/5: Instalando o Docker Engine..."
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

echo ">>> Instalação do Docker concluída com sucesso!"
echo ">>> Para executar o Docker sem 'sudo', adicione seu usuário ao grupo 'docker':"
echo ">>> sudo usermod -aG docker \$USER"
echo ">>> Lembre-se de fazer logout e login para que a alteração tenha efeito."
