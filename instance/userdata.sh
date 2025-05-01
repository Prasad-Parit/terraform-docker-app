#!/bin/bash


yum update -y
yum install -y docker


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
docker build -t randomstring:v1 . 
docker run -d -p 8081:8081 --name myapp randomstring:v1 



