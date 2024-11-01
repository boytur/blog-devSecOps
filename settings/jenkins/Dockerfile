FROM jenkins/jenkins:lts

USER root

# ติดตั้ง Docker
RUN apt-get update && apt-get install -y \
    docker.io \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

# ติดตั้ง Docker Compose
RUN curl -L "https://github.com/docker/compose/releases/download/$(curl -s https://api.github.com/repos/docker/compose/releases/latest | grep 'tag_name' | cut -d\" -f4)/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose \
    && chmod +x /usr/local/bin/docker-compose

# ติดตั้ง Jenkins X CLI
RUN curl -L https://github.com/jenkins-x/jx/releases/latest/download/jx-linux-amd64.tar.gz | tar xz -C /usr/local/bin jx

# ติดตั้ง Kubernetes CLI
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl \
    && chmod +x kubectl \
    && mv kubectl /usr/local/bin/

# ติดตั้ง Helm
RUN curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

# ติดตั้ง Node.js และ npm
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
    && apt-get install -y nodejs

# เพิ่ม Jenkins ไปยังกลุ่ม Docker
RUN usermod -aG docker jenkins