
---
tags: [template, aws, vpc, ec2, lab]
created: {{date:YYYY-MM-DD}}
updated: {{date:YYYY-MM-DD}}
---

# AWS Lab Planner: VM + VPC + Security Groups

## LINKS
- https://docs.aws.amazon.com/vpc/latest/userguide/what-is-amazon-vpc.html
- https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/concepts.html
- https://aws.amazon.com/about-aws/global-infrastructure/regions_az/
- https://aws.amazon.com/ec2/instance-types/
- https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance
- https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group
- https://github.com/ChuckKeyes/startup-script-template

---

**STUDENT NAME:** Chuck Keyes  
**DATE:** {{date:YYYY-MM-DD}}

---

## 1) Account & Project Info
- **AWS Account ID:** 
- **Primary Region:** 
- **Additional Regions (if any):** 
- **IAM Role / Instance Profile:** 
- **Key Pair Name:** 
- **Default Tags (key=value):** 
- **Terraform State (S3/DynamoDB) [optional]:** 

---

## 2) VPC & Subnet Design
> One VPC per region is typical. Each subnet must map to a specific **Availability Zone**.

**VPC (Region A – e.g., `af-south-1` Cape Town)**
- **VPC Name:** 
- **VPC CIDR:** 
- **Subnet Name:** 
- **AZ:** 
- **Subnet CIDR:** 
- **Instances:** linux

**VPC (Region B – e.g., `sa-east-1` São Paulo)**
- **VPC Name:** 
- **VPC CIDR:** 
- **Subnet Name:** 
- **AZ:** 
- **Subnet CIDR:** 
- **Instances:** linux & windows

**VPC (Region C – e.g., `us-east-1` N. Virginia)**
- **VPC Name:** 
- **VPC CIDR:** 
- **Subnet Name:** 
- **AZ:** 
- **Subnet CIDR:** 
- **Instances:** linux & windows

> [!tip] Inter-VPC / cross-region traffic
> For private connectivity between regions, plan **VPC Peering** or **Transit Gateway**.  
> Security groups can reference **other SGs only within the same VPC**. Across VPCs/regions, use **CIDR ranges** or private routing.

---

## 3) EC2 Instances
> Use **User data** for bootstrap; Windows needs RDP (3389), Linux typically uses SSH (22).

### Instance A (Region A – Cape Town)
- **Name tag:** `instance-1-cape-town`
- **AMI ID:** 
- **Instance type:** 
- **Subnet:** 
- **Public IPv4:** true (required if installing via Internet)
- **Security Groups:** `sg-http-1`
- **User data:** [[startup-script-template]] (or paste)

### Instance B1 (Region B – São Paulo, Linux)
- **Name tag:** `instance-2-saopaulo-1`
- **AMI ID:** 
- **Instance type:** 
- **Subnet:** 
- **Public IPv4:** true
- **Security Groups:** `sg-http-2`
- **User data:** 

### Instance B2 (Region B – São Paulo, Windows)
- **Name tag:** `instance-2-saopaulo-2`
- **AMI ID (Windows):** 
- **Instance type:** 
- **Subnet:** 
- **Public IPv4:** true
- **Security Groups:** `sg-windows-2`
- **User data:** (optional)

### Instance C1 (Region C – Virginia, Linux)
- **Name tag:** `instance-3-virginia-1`
- **AMI ID:** 
- **Instance type:** 
- **Subnet:** 
- **Public IPv4:** true
- **Security Groups:** `sg-http-3`
- **User data:** 

### Instance C2 (Region C – Virginia, Windows)
- **Name tag:** `instance-3-virginia-2`
- **AMI ID (Windows):** 
- **Instance type:** 
- **Subnet:** 
- **Public IPv4:** true
- **Security Groups:** `sg-windows-3`
- **User data:** (optional)

---

## 4) Tags & Security Group Plan
**Planned Security Groups**
- `sg-http-1`
- `sg-http-2`
- `sg-http-3`
- `sg-windows-2`
- `sg-windows-3`

**Traffic Map (intent)**
- From **Internet (0.0.0.0/0)** → `sg-windows-2`, `sg-windows-3` (RDP/3389) *(lock down to your IPs if possible)*
- From **`sg-windows-2` & `sg-windows-3`** → `sg-http-1` (HTTP/80)
- From **`sg-windows-2`** → `sg-http-2` (HTTP/80)
- From **`sg-windows-3`** → `sg-http-3` (HTTP/80)

> [!warning] Cross-region caveat  
> If `sg-http-*` and `sg-windows-*` live in **different VPCs/regions**, you **cannot** set an SG as a source in the rule. Use **CIDR** (public EIP or private CIDR via peering/TGW).

---

## 5) Security Group Rule Stubs
### Allow RDP to Windows
- **Name:** `allow-3389-from-anywhere-to-windows`
- **Direction:** Ingress
- **Protocol/Port:** TCP/3389
- **Source:** `0.0.0.0/0` *(or better: your public /32)*
- **Targets:** `sg-windows-2`, `sg-windows-3`

### Allow HTTP from Windows → Cape Town Linux
- **Name:** `allow-80-from-windows-to-cape-town`
- **Direction:** Ingress (on Linux SG)
- **Protocol/Port:** TCP/80
- **Source:** `sg-windows-2`, `sg-windows-3` *(or CIDR if cross-VPC)*
- **Target:** `sg-http-1`

### Allow HTTP from Windows → São Paulo Linux
- **Name:** `allow-80-from-windows-to-saopaulo`
- **Direction:** Ingress
- **Protocol/Port:** TCP/80
- **Source:** `sg-windows-2` *(or CIDR)*
- **Target:** `sg-http-2`

### Allow HTTP from Windows → Virginia Linux
- **Name:** `allow-80-from-windows-to-virginia`
- **Direction:** Ingress
- **Protocol/Port:** TCP/80
- **Source:** `sg-windows-3` *(or CIDR)*
- **Target:** `sg-http-3`

---

## 6) Expected Behavior Checklist
- [ ] Can RDP to Windows servers from my workstation?
- [ ] Linux VM in Region C only accessible from **its paired Windows** (HTTP)?
- [ ] Linux VM in Region B only accessible from **its paired Windows** (HTTP)?
- [ ] Linux VM in Region A accessible from **both** Windows servers (HTTP)?
- [ ] (If private) Inter-VPC routing works via **Peering/TGW**?

---

## 7) Notes & Observations
- 
- 
- 

> [!info] Secrets
> Store any passwords/keys in **AWS Secrets Manager** (don’t keep plaintext here).

