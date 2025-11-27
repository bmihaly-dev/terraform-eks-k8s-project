# Terraform EKS K8s Project

<p align="center">
  <img src="https://img.shields.io/badge/AWS-EKS-orange?logo=amazonaws" />
  <img src="https://img.shields.io/badge/Terraform-IaC-7B42BC?logo=terraform" />
  <img src="https://img.shields.io/badge/Kubernetes-Production_Ready-326CE5?logo=kubernetes" />
  <img src="https://img.shields.io/badge/GitHub_Actions-CI/CD-black?logo=githubactions" />
  <img src="https://img.shields.io/badge/AWS-ECR-blue?logo=amazonaws" />
</p>

<p align="center">
  Fully automated AWS EKS infrastructure using Terraform, GitHub OIDC authentication, ECR-based image builds, rolling Kubernetes deployments, HPA autoscaling, and ALB ingress routing.
</p>

---

## 📘 Overview
This project provisions a production-grade Kubernetes environment on AWS using Terraform and deploys a Dockerized NGINX-based application through GitHub Actions CI/CD. It demonstrates Infrastructure as Code, secure OIDC authentication, autoscaling, ingress routing, and full cloud-native DevOps workflow.

---

## 🧱 Architecture Overview

### AWS Components
- VPC with public + private subnets
- Internet Gateway + NAT Gateway
- Amazon EKS cluster + managed nodegroup
- Amazon ECR repository (`eks-k8s-dev-app`)
- Application Load Balancer (ALB) created via Kubernetes Ingress

### Kubernetes Components
- Namespace: `eks-k8s-dev-app`
- Deployment (NGINX-based)
- Service (ClusterIP)
- Ingress (ALB)
- Metrics Server
- Horizontal Pod Autoscaler (2→5 replicas)

### CI/CD
- Trigger: push to `main`
- Build Docker image from `app/reactflow-app`
- Tag as `latest` + `<SHORT_SHA>`
- GitHub OIDC → AWS IAM authentication
- Push to ECR
- Patch Deployment image
- Rolling update via `kubectl rollout status`

### Terraform Stacks
- `terraform-bootstrap/` → S3 backend + DynamoDB lock
- `terraform/` → EKS infra + networking + Helm addons
- `terraform-ci-iam/` → GitHub OIDC IAM role

---

## 📂 Repository Structure

```
terraform-bootstrap/          → Backend (S3 + DynamoDB)
terraform/                    → VPC, EKS, nodegroup, Ingress, Metrics Server
app/reactflow-app/            → Application source + Dockerfile
terraform-ci-iam/             → GitHub OIDC IAM role
.github/workflows/app-ci.yml  → CI/CD workflow
```

---

## 🏁 Getting Started

### 1. Bootstrap Backend
```
cd terraform-bootstrap
terraform init
terraform apply
```

### 2. Deploy EKS Infrastructure
```
cd terraform
terraform init
terraform plan
terraform apply
```

### 3. Configure kubectl
```
aws eks update-kubeconfig --name eks-k8s-dev-cluster --region eu-central-1
kubectl get nodes
kubectl get pods -A
```

### 4. (Optional) Apply App Manifests
```
kubectl apply -f namespace.yml
kubectl apply -f deployment.yml
kubectl apply -f service.yml
kubectl apply -f hpa.yml
```

---

## 🔄 CI/CD with GitHub Actions
- Builds and pushes Docker image to ECR using GitHub OIDC
- Patches Deployment image to SHA-tagged version
- Performs rolling update
- Waits for rollout success

Workflow: `.github/workflows/app-ci.yml`

---

## 🌐 Accessing the Application
Retrieve the ALB Ingress DNS:

```
kubectl get ingress -n eks-k8s-dev-app
```

Open in browser:

```
http://<ALB-DNS>/
```

---

## 📉 Autoscaling (HPA)
HPA scales pods from 2→5 replicas based on CPU.

Check scaling:
```
kubectl get hpa -n eks-k8s-dev-app
```

---

## 🧹 Safe Destroy

### 1. Destroy EKS Infra
```
cd terraform
terraform destroy
```

### 2. Destroy CI IAM Role
```
cd terraform-ci-iam
terraform destroy
```

### 3. Destroy Backend (last)
```
cd terraform-bootstrap
terraform destroy
```

---

## 📞 Contact
GitHub: https://github.com/bmihaly-dev
