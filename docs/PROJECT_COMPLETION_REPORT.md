# Jerney - 3 Tier DevSecOps Project

## Project Overview

Jerney is a production-style 3-tier application that implements modern DevOps and GitOps practices using AWS and Kubernetes.

### Architecture

```text
                 Github Repository
                         |
                         |
                  Github Actions
                         |
                         |
                     CI Pipeline
                         |
                         |
                   Docker Build
                         |
                         |
                   Trivy Scan
                         |
                         |
                    Amazon ECR
                         |
                         |
                Kubernetes Manifest Update
                         |
                         |
                      ArgoCD
                         |
                         |
                    Amazon EKS
                         |
              ------------------------
              |                      |
         Frontend Pods            Backend Pods
              |                      |
              --------Service---------
                         |
                      Ingress
                         |
                    Application
                         |
                    PostgreSQL
                     Amazon RDS
```

---

## Technology Stack

### Frontend

* React
* Vite
* Nginx

### Backend

* Node.js
* Express.js
* PostgreSQL

### DevOps

* Docker
* Kubernetes
* Terraform
* GitHub Actions
* ArgoCD
* GitOps
* Trivy
* Horizontal Pod Autoscaling

### AWS Services

* Amazon EKS
* Amazon ECR
* Amazon RDS
* IAM
* VPC
* Security Groups
* Load Balancers

---

## Infrastructure Provisioned

Terraform provisions the following infrastructure:

* EKS Cluster
* ECR repositories
* RDS PostgreSQL instance
* IAM roles
* GitHub OIDC authentication
* Networking resources
* Security Groups
* Database subnet groups

---

## Kubernetes Resources

The application deploys the following resources:

```text
Namespace
   |
Secrets
   |
Deployments
   |
Services
   |
Horizontal Pod Autoscalers
   |
Ingress
   |
Frontend Pods
Backend Pods
```

Implemented resources:

* Namespace
* Deployments
* Services
* Secrets
* HPAs
* Ingress
* Health probes

---

## CI/CD Workflow

### Backend Pipeline

Implemented:

* Checkout source code
* Install dependencies
* Docker image build
* Trivy vulnerability scanning
* Authenticate with AWS
* Push image to ECR
* Update Kubernetes manifests
* Commit manifest changes
* Push changes to GitHub
* Automatic ArgoCD synchronization

### Frontend Pipeline

Implemented:

* Checkout source code
* Install dependencies
* Docker image build
* Trivy image scanning
* Push image to ECR
* Update image tags
* Automatic deployment through ArgoCD

---

## Major Problems Solved

### Problem 1

#### Database Connection Refused

```text
ECONNREFUSED
```

#### Cause

Backend attempted to connect to:

```text
localhost:5432
```

instead of:

```text
Amazon RDS Endpoint
```

#### Solution

Updated the database host configuration to use the RDS endpoint.

---

### Problem 2

#### Environment Variable Mismatch

```text
Deployment

↓

DB_USERNAME

↓

Backend

↓

DB_USER
```

#### Solution

Standardized the environment variables.

```text
DB_HOST
DB_PORT
DB_NAME
DB_USER
DB_PASSWORD
```

---

### Problem 3

#### SSL Encryption Failure

```text
no pg_hba.conf entry

no encryption
```

#### Cause

Amazon RDS required SSL connections.

#### Solution

Added SSL configuration.

```javascript
ssl:{
    rejectUnauthorized:false
}
```

---

### Problem 4

#### Password Authentication Failure

```text
password authentication failed
```

#### Cause

Kubernetes Secret contained placeholder values instead of actual credentials.

```text
${db_password}
```

#### Solution

Patched the Kubernetes Secret using the correct values for:

```text
DB_HOST
DB_PORT
DB_NAME
DB_USER
DB_PASSWORD
```

---

### Problem 5

#### ArgoCD Secret Synchronization

#### Cause

ArgoCD auto-sync continuously reapplied the placeholder values stored inside Git.

#### Solution

Temporarily patched the live Secret.

Future improvements include:

* External Secrets Operator
* AWS Secrets Manager
* Sealed Secrets
* ArgoCD ignoreDifferences configuration

---

### Problem 6

#### Health Probe Failure

#### Cause

Incorrect probe configuration.

```text
Configured:

/health


Actual:

/api/health
```

#### Solution

Updated:

```text
Liveness Probe

and

Readiness Probe
```

to:

```text
/api/health
```

Backend pods successfully became healthy.

---

## Current Project Features

### Infrastructure

* Infrastructure as Code
* GitOps deployment
* CI/CD automation
* Container orchestration
* Horizontal scaling
* Vulnerability scanning

### Security

* IAM roles
* GitHub OIDC authentication
* Kubernetes Secrets
* Docker image scanning using Trivy
* SSL encrypted PostgreSQL connections

### Deployment

Implemented:

```text
Github
   |
Github Actions
   |
Docker
   |
Trivy
   |
Amazon ECR
   |
Manifest Updates
   |
ArgoCD
   |
Amazon EKS
   |
Kubernetes
   |
Pods
   |
Services
   |
Application
   |
Amazon RDS
```

---

## Lessons Learned

This project provided practical experience with:

* Kubernetes troubleshooting
* Pod debugging
* PostgreSQL connectivity issues
* SSL configuration
* Health probes
* GitOps workflows
* Infrastructure provisioning
* Secret management
* CI/CD pipelines
* Docker image management
* Horizontal Pod Autoscaling
* ArgoCD synchronization issues
* AWS networking and security groups

---

## Future Improvements

Planned enhancements include:

* AWS Secrets Manager integration
* External Secrets Operator
* Prometheus monitoring
* Grafana dashboards
* TLS certificates
* Domain configuration
* Blue-Green deployments
* Canary deployments
* Production-grade observability

---

## Final Architecture

```text
                 Github Repository
                         |
                  Github Actions
                         |
                     Docker
                         |
                   Trivy Scan
                         |
                    Amazon ECR
                         |
                  Manifest Updates
                         |
                      ArgoCD
                         |
                    Amazon EKS
                         |
                 Kubernetes Cluster
                         |
              ------------------------
              |                      |
         Frontend Pods            Backend Pods
              |                      |
       Frontend Service        Backend Service
              |                      |
              --------Ingress---------
                         |
                    Application
                         |
                  PostgreSQL
                     Amazon RDS
```

## Project Status

```text
PROJECT COMPLETED

Terraform
     ✓
EKS
     ✓
ECR
     ✓
RDS
     ✓
Docker
     ✓
GitHub Actions
     ✓
ArgoCD
     ✓
GitOps
     ✓
Kubernetes
     ✓
Horizontal Pod Autoscaling
     ✓
Trivy Scanning
     ✓
3-Tier Architecture
     ✓
CI/CD Pipeline
     ✓
```

This project demonstrates an end-to-end DevSecOps implementation using AWS, Kubernetes, GitHub Actions, and GitOps principles while addressing real-world deployment and infrastructure challenges.
