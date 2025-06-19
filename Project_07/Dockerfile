FROM ubuntu:22.04

# Avoid interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Update and install Ansible and Python
RUN apt-get update && \
    apt-get install -y software-properties-common && \
    apt-add-repository --yes --update ppa:ansible/ansible && \
    apt-get install -y ansible python3 python3-pip ssh && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Default command (optional)
CMD ["/bin/bash"]
