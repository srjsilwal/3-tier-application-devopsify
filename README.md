# 🚀 Jerney - Production-Ready DevSecOps Blog Platform

Jerney is a production-ready 3-tier blog platform built using modern DevSecOps practices. The project combines a React frontend, Node.js backend, and PostgreSQL database with cloud-native deployment on AWS using Kubernetes.

This project demonstrates the complete DevSecOps lifecycle including Infrastructure as Code, containerization, CI/CD automation, Kubernetes orchestration, GitOps deployments, and security best practices.

## Tech Stack

### Application Stack

* React (Vite)
* Node.js
* Express.js
* PostgreSQL
* Nginx

### DevOps Stack

* Docker
* Kubernetes
* Amazon EKS
* Terraform
* GitHub Actions
* ArgoCD
* Amazon ECR
* Amazon RDS
* GitHub OIDC Authentication

### Security

* IAM Roles and Policies
* OpenID Connect (OIDC)
* Secret Management using Kubernetes Secrets
* Container Security Scanning
* Health Checks and Readiness Probes
* GitOps-based Deployments

---

## Architecture

```
                           GitHub Repository
                                    |
                                    |
                             GitHub Actions
                                    |
                       ------------------------------
                       |                            |
                  Build Images                 Security Checks
                       |                            |
                       --------------------------------
                                    |
                                    |
                             Push Images to ECR
                                    |
                                    |
                               ArgoCD (GitOps)
                                    |
                                    |
                                 Amazon EKS
                                    |
               ------------------------------------------------
               |                                              |
          Frontend                                        Backend
       (React + Nginx)                               (Node + Express)
            Port 80                                      Port 5000
               |                                              |
               ------------------------------------------------
                                    |
                               Amazon RDS
                                PostgreSQL
                                  5432
                                    |
                                 AWS VPC
```

---

## Project Structure

```text
.
├── argocd/
│   └── application.yaml
│
├── backend/
│   ├── src/
│   ├── Dockerfile
│   └── package.json
│
├── frontend/
│   ├── src/
│   ├── Dockerfile
│   ├── nginx.conf
│   └── package.json
│
├── k8s/
│   ├── backend/
│   ├── frontend/
│   ├── ingress/
│   ├── namespace/
│   ├── secrets/
│   └── kustomization.yaml
│
├── terraform/
│   ├── environments/
│   └── modules/
│       ├── ecr/
│       ├── eks/
│       ├── iam-github-oidc/
│       ├── networking/
│       └── rds/
│
├── docs/
│
├── docker-compose.yml
└── README.md
```

---

## Features

### Application Features

* Create blog posts
* Edit blog posts
* Delete blog posts
* Comment system
* Responsive UI
* Health check endpoints

### DevSecOps Features

* Infrastructure as Code using Terraform
* Kubernetes deployment manifests
* GitOps deployment using ArgoCD
* CI/CD pipelines using GitHub Actions
* Container image storage using Amazon ECR
* PostgreSQL deployment using Amazon RDS
* Kubernetes Horizontal Pod Autoscaling
* Liveness and Readiness probes
* OIDC authentication for GitHub Actions
* Automated image updates
* Automated deployments
* Namespace isolation
* Secret management
* Production-ready architecture

---

## Infrastructure Components

| Component          | Service        |
| ------------------ | -------------- |
| Cloud Provider     | AWS            |
| Container Registry | Amazon ECR     |
| Kubernetes         | Amazon EKS     |
| Database           | Amazon RDS     |
| CI/CD              | GitHub Actions |
| GitOps             | ArgoCD         |
| Infrastructure     | Terraform      |
| Reverse Proxy      | Nginx          |
| Containerization   | Docker         |
| Authentication     | GitHub OIDC    |

---

## Deployment Workflow

```text
Developer
    |
    |
 git push
    |
    |
GitHub Repository
    |
    |
GitHub Actions
    |
    |
----------------------------
|            |              |
Lint         Build         Scan
|             |             |
-------------Docker---------
               |
               |
         Push to ECR
               |
               |
         Update Manifests
               |
               |
            ArgoCD
               |
               |
            Sync
               |
               |
         Deploy to EKS
               |
               |
      ---------------------
      |                   |
   Frontend            Backend
      |                   |
      ---------------------
               |
               |
            Amazon RDS
```

---

## Local Development

### Backend

```bash
cd backend

npm install

npm start
```

Required environment variables:

```bash
DB_HOST=
DB_PORT=5432
DB_USER=
DB_PASSWORD=
DB_NAME=
PORT=5000
```

### Frontend

```bash
cd frontend

npm install

npm run dev
```

---

## Running with Docker

```bash
docker compose up --build
```

---

## Kubernetes Deployment

Apply the manifests:

```bash
kubectl apply -k k8s/
```

Verify the resources:

```bash
kubectl get pods -n jerney

kubectl get svc -n jerney

kubectl get deployment -n jerney

kubectl get ingress -n jerney
```

---

## Terraform Deployment

Initialize Terraform:

```bash
terraform init
```

Create infrastructure:

```bash
terraform apply
```

Terraform provisions:

* VPC
* EKS Cluster
* Amazon RDS
* Amazon ECR
* GitHub OIDC IAM Roles
* Networking Components

---

## ArgoCD Deployment

Deploy the application:

```bash
kubectl apply -f argocd/application.yaml
```

Verify the application:

```bash
kubectl get applications -n argocd

kubectl describe application jerney -n argocd
```

---

## API Endpoints

| Method | Endpoint                   |
| ------ | -------------------------- |
| GET    | /api/health                |
| GET    | /api/posts                 |
| GET    | /api/posts/:id             |
| POST   | /api/posts                 |
| PUT    | /api/posts/:id             |
| DELETE | /api/posts/:id             |
| GET    | /api/comments/post/:postId |
| POST   | /api/comments              |
| DELETE | /api/comments/:id          |

---

## What I Learned

This project provided hands-on experience with:

* Docker
* Kubernetes
* Amazon EKS
* Terraform
* GitHub Actions
* ArgoCD
* GitOps workflows
* Infrastructure as Code
* Amazon RDS
* Amazon ECR
* Kubernetes networking
* Secret management
* Health checks
* Horizontal Pod Autoscaling
* CI/CD pipelines
* OpenID Connect (OIDC)
* Production deployment strategies
* Debugging real-world deployment issues

---

## Acknowledgements

Special thanks to **Abhishek Veeramalla (iam-veeramalla)** for his exceptional DevOps and Cloud learning resources, which provided valuable guidance and inspiration throughout this project's DevSecOps implementation.

The original Jerney application serves as the foundation of this work. The DevSecOps architecture, cloud infrastructure, CI/CD pipelines, Kubernetes deployment strategy, and productionization efforts were implemented as part of this learning project.

---

## Disclaimer

This repository is intended for educational and portfolio purposes. It demonstrates real-world DevSecOps practices including cloud infrastructure provisioning, GitOps workflows, CI/CD automation, Kubernetes deployments, and security-focused development practices.

---

## Author

**Suraj Silwal**

> Building production-ready DevOps and DevSecOps projects one deployment at a time.
