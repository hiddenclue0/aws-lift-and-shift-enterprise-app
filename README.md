# Lift and Shift Application Workload on AWS

## Related Projects

- [Multi-Tier WebApp Vagrant Setup (Manual)](https://github.com/hiddenclue0/Multi-Tier-WebApp-Vagrant-Setup-Manually-.git)  
- [Spring Multi-Tier Enterprise Application](https://github.com/hiddenclue0/spring-multi-tier-enterprise-app.git)

---

## Project Overview

This project involves migrating a multi-tier enterprise application (`spring-multi-tier-enterprise-app`) from an on-premises data center to Amazon Web Services (AWS) cloud using a **Lift and Shift** strategy. The goal is to replicate the existing architecture on AWS with minimal changes, enabling scalability, cost-efficiency, and automation.

---

## Scenario & Challenges

Our current application runs on physical/virtual servers supporting:

- Databases (MySQL/PostgreSQL/Oracle)
- Application servers (Tomcat, LAMP stack)
- Messaging (RabbitMQ)
- Caching (Memcached)
- DNS and monitoring services

Managing these requires multiple specialized teams and suffers from:

- Operational complexity and manual processes
- High upfront costs and maintenance expenses
- Limited scalability and slow provisioning
- Difficulties in automation and orchestration

---

## Solution Overview

By migrating to AWS cloud infrastructure, we:

- Eliminate upfront hardware costs with pay-as-you-go billing
- Gain elasticity: scale out/in automatically
- Automate provisioning and deployment with Infrastructure as Code (IaC)
- Enhance security and monitoring using AWS managed services
- Lay a foundation for future modernization and CI/CD pipelines

---

## AWS Architecture

### Core AWS Services Used

| Service                         | Purpose                                         |
| -------------------------------|------------------------------------------------|
| **Amazon EC2**                 | Hosts Tomcat app servers, MySQL, RabbitMQ, Memcached |
| **Elastic Load Balancer (ALB)**| Distributes HTTPS traffic to Tomcat instances  |
| **Auto Scaling Group (ASG)**   | Automatically scales Tomcat instances           |
| **Amazon S3**                  | Stores application artifacts, backups, logs    |
| **Amazon Certificate Manager** | Manages SSL/TLS certificates for HTTPS          |
| **Amazon Route 53 (Private DNS)** | Provides private DNS resolution for backend services |

### Network & Security

- **Security Groups**:
  - ALB SG: allows inbound HTTPS (443) from the internet
  - Tomcat SG: allows inbound HTTP (8080) from ALB only
  - Backend SG: allows DB/cache/messaging ports from Tomcat only
- **Private subnets** used for app and backend servers
- **Public subnet** hosts the ALB

---

## Execution Flow

1. **Login to AWS Console**
2. **Create SSH Key Pair** for EC2 access
3. **Create Security Groups** for ALB, Tomcat, and backend servers
4. **Launch EC2 Instances** with user-data scripts for:
   - Tomcat server
   - MySQL server
   - RabbitMQ server
   - Memcached server
5. **Set up Route 53 Private Hosted Zone** with DNS entries for backend services
6. **Build application artifact** (WAR) locally and upload to S3 bucket
7. **Download artifact on Tomcat EC2** and deploy it in Tomcat's `webapps/`
8. **Create Application Load Balancer (ALB)** with HTTPS listener using ACM certificate
9. **Configure GoDaddy DNS** to point to ALB endpoint
10. **Create Auto Scaling Group (ASG)** for Tomcat EC2 instances with scaling policies

---

## Benefits

- Flexible, scalable infrastructure without upfront cost
- Automated deployments minimizing human error
- Improved availability and performance
- Foundation for cloud-native modernization and CI/CD

---

## Next Steps

- Automate infrastructure provisioning using Terraform
- Write configuration management scripts (Ansible/bash)
- Implement monitoring and alerting with CloudWatch
- Gradual migration of database to managed services like RDS

---

## Contact

Email: hiddenclue0@gmail.com  
GitHub: [https://github.com/hiddenclue0/](https://github.com/hiddenclue0/)

---

*Project created by Jakir Hosen.*
