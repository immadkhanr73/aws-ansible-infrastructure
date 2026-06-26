# 1. Base Image
FROM python:3.12-slim

# 2. Working Directory
WORKDIR /app

# 3. System Requirements
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    openssh-client \
    && rm -rf /var/lib/apt/lists/*

# 4. Python Dependencies
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir ansible boto3 botocore

# 5. Ansible AWS Collections
RUN ansible-galaxy collection install amazon.aws community.aws

# 6. Copy Project Files
COPY . .

# 7. Default Execution Command
CMD ["ansible-playbook", "main.yml"]
