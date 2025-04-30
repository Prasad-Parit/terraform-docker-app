#!/bin/bash

# Execute the logs
exec > /var/log/user-data.log 2>&1
set -x

# Update and install Docker on Amazon Linux 2
yum update -y
yum install -y docker

# Start and enable Docker service
systemctl enable docker
systemctl start docker

# Add ec2-user to docker group for Docker permission
usermod -aG docker ec2-user

# Sleep to ensure Docker is fully initialized
sleep 20

# Create app directory
mkdir -p /app

# Flask app creation
cat > /app/app.py <<'EOPY'
from flask import Flask
import random

app = Flask(__name__)

@app.route('/api/v1')
def get_random_string():
    return random.choice(["Investments", "Smallcase", "Stocks", "buy-the-dip", "TickerTape"])

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=8081)
EOPY

# Dockerfile creation
cat > /app/Dockerfile <<'EOFY'
FROM python:3.11

WORKDIR /app

COPY app.py .

RUN pip install flask

EXPOSE 8081

CMD ["python", "app.py"]
EOFY

# Build and run Docker container and copy in logfiles
cd /app
docker build -t randomstring:v1 . >> /var/log/docker_build.log 2>&1
docker run -d -p 8081:8081 --name myapp randomstring:v1 >> /var/log/docker_run.log 2>&1

# Print logs 
cat /var/log/docker_build.log
cat /var/log/docker_run.log
