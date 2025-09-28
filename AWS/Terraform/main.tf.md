
# -----------------------
# Providers (per region)
# -----------------------
provider "aws" {
  region  = var.region_sa
  profile = var.aws_profile
  alias   = "sa"
  default_tags { tags = var.default_tags }
}

provider "aws" {
  region  = var.region_us
  profile = var.aws_profile
  alias   = "us"
  default_tags { tags = var.default_tags }
}

provider "aws" {
  region  = var.region_af
  profile = var.aws_profile
  alias   = "af"
  default_tags { tags = var.default_tags }
}

# -----------------------
# AMIs per region
# -----------------------
# Amazon Linux 2023
data "aws_ami" "al2023_sa" {
  provider    = aws.sa
  most_recent = true
  owners      = ["137112412989"] # Amazon Linux
  filter { name = "name"; values = ["al2023-ami-*-kernel-6.1-x86_64"] }
}

data "aws_ami" "al2023_us" {
  provider    = aws.us
  most_recent = true
  owners      = ["137112412989"]
  filter { name = "name"; values = ["al2023-ami-*-kernel-6.1-x86_64"] }
}

data "aws_ami" "al2023_af" {
  provider    = aws.af
  most_recent = true
  owners      = ["137112412989"]
  filter { name = "name"; values = ["al2023-ami-*-kernel-6.1-x86_64"] }
}

# Windows Server 2022 Base
data "aws_ami" "win2022_sa" {
  provider    = aws.sa
  most_recent = true
  owners      = ["801119661308"] # Amazon Windows
  filter { name = "name"; values = ["Windows_Server-2022-English-Full-Base-*"] }
}

data "aws_ami" "win2022_us" {
  provider    = aws.us
  most_recent = true
  owners      = ["801119661308"]
  filter { name = "name"; values = ["Windows_Server-2022-English-Full-Base-*"] }
}

# -----------------------
# CAPE TOWN (af-south-1)
# VPC + public subnet + IGW + route table
# One Linux instance (http-server-1)
# -----------------------
resource "aws_vpc" "af" {
  provider             = aws.af
  cidr_block           = var.vpc_cidr_af
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = { Name = "vpc-af-cape-town" }
}

resource "aws_internet_gateway" "af" {
  provider = aws.af
  vpc_id   = aws_vpc.af.id
  tags     = { Name = "igw-af" }
}

resource "aws_subnet" "af_public" {
  provider                = aws.af
  vpc_id                  = aws_vpc.af.id
  cidr_block              = var.subnet_cidr_af
  map_public_ip_on_launch = true
  availability_zone       = "${var.region_af}a"
  tags                    = { Name = "subnet-af-public-a" }
}

resource "aws_route_table" "af_public" {
  provider = aws.af
  vpc_id   = aws_vpc.af.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.af.id
  }
  tags = { Name = "rtb-af-public" }
}

resource "aws_route_table_association" "af_public" {
  provider       = aws.af
  subnet_id      = aws_subnet.af_public.id
  route_table_id = aws_route_table.af_public.id
}

# Security Group: http-server-1
resource "aws_security_group" "af_http1" {
  provider    = aws.af
  name        = "sg-http-1"
  description = "Allow HTTP to Cape Town Linux"
  vpc_id      = aws_vpc.af.id

  ingress {
    description = "HTTP from allowed CIDRs (placeholder for cross-VPC traffic)"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = var.af_http_source_cidrs
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "sg-http-1" }
}

# Linux EC2 (instance-1-cape-town)
resource "aws_instance" "af_linux1" {
  provider                    = aws.af
  ami                         = data.aws_ami.al2023_af.id
  instance_type               = "t3.micro"
  key_name                    = var.key_name
  subnet_id                   = aws_subnet.af_public.id
  vpc_security_group_ids      = [aws_security_group.af_http1.id]
  associate_public_ip_address = true

  user_data = <<-EOF
              #!/bin/bash
              set -eux
              yum -y install httpd
              systemctl enable --now httpd
              echo "Hello from Cape Town (http-server-1)" > /var/www/html/index.html
              EOF

  tags = {
    Name = "instance-1-cape-town"
    Role = "http-server-1"
  }
}

# -----------------------
# SÃO PAULO (sa-east-1)
# VPC + public subnet + IGW + route table
# Linux (http-server-2) + Windows (windows-server-2)
# Windows can RDP from allowed_rdp_cidr, Linux allows HTTP from Windows SG
# -----------------------
resource "aws_vpc" "sa" {
  provider             = aws.sa
  cidr_block           = var.vpc_cidr_sa
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = { Name = "vpc-sa-saopaulo" }
}

resource "aws_internet_gateway" "sa" {
  provider = aws.sa
  vpc_id   = aws_vpc.sa.id
  tags     = { Name = "igw-sa" }
}

resource "aws_subnet" "sa_public" {
  provider                = aws.sa
  vpc_id                  = aws_vpc.sa.id
  cidr_block              = var.subnet_cidr_sa
  map_public_ip_on_launch = true
  availability_zone       = "${var.region_sa}a"
  tags                    = { Name = "subnet-sa-public-a" }
}

resource "aws_route_table" "sa_public" {
  provider = aws.sa
  vpc_id   = aws_vpc.sa.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.sa.id
  }
  tags = { Name = "rtb-sa-public" }
}

resource "aws_route_table_association" "sa_public" {
  provider       = aws.sa
  subnet_id      = aws_subnet.sa_public.id
  route_table_id = aws_route_table.sa_public.id
}

# Security Groups (sa-east-1)
resource "aws_security_group" "sa_windows2" {
  provider    = aws.sa
  name        = "sg-windows-2"
  description = "RDP to Windows in São Paulo"
  vpc_id      = aws_vpc.sa.id

  ingress {
    description = "RDP"
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = [var.allowed_rdp_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "sg-windows-2" }
}

resource "aws_security_group" "sa_http2" {
  provider    = aws.sa
  name        = "sg-http-2"
  description = "Allow HTTP from Windows-2"
  vpc_id      = aws_vpc.sa.id

  ingress {
    description     = "HTTP from Windows-2 SG"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.sa_windows2.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "sg-http-2" }
}

# Linux EC2 (instance-2-saopaulo-1)
resource "aws_instance" "sa_linux1" {
  provider                    = aws.sa
  ami                         = data.aws_ami.al2023_sa.id
  instance_type               = "t3.micro"
  key_name                    = var.key_name
  subnet_id                   = aws_subnet.sa_public.id
  vpc_security_group_ids      = [aws_security_group.sa_http2.id]
  associate_public_ip_address = true

  user_data = <<-EOF
              #!/bin/bash
              set -eux
              yum -y install httpd
              systemctl enable --now httpd
              echo "Hello from São Paulo (http-server-2)" > /var/www/html/index.html
              EOF

  tags = {
    Name = "instance-2-saopaulo-1"
    Role = "http-server-2"
  }
}

# Windows EC2 (instance-2-saopaulo-2)
resource "aws_instance" "sa_windows2" {
  provider                    = aws.sa
  ami                         = data.aws_ami.win2022_sa.id
  instance_type               = "t3.large"
  key_name                    = var.key_name
  subnet_id                   = aws_subnet.sa_public.id
  vpc_security_group_ids      = [aws_security_group.sa_windows2.id]
  associate_public_ip_address = true

  user_data = <<-EOF
              <powershell>
              Install-WindowsFeature -name Web-Server -IncludeManagementTools
              Set-Content -Path "C:\\inetpub\\wwwroot\\index.html" -Value "Hello from Windows in São Paulo (windows-server-2)"
              </powershell>
              EOF

  tags = {
    Name = "instance-2-saopaulo-2"
    Role = "windows-server-2"
  }
}

# -----------------------
# VIRGINIA (us-east-1)
# VPC + public subnet + IGW + route table
# Linux (http-server-3) + Windows (windows-server-3)
# -----------------------
resource "aws_vpc" "us" {
  provider             = aws.us
  cidr_block           = var.vpc_cidr_us
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = { Name = "vpc-us-virginia" }
}

resource "aws_internet_gateway" "us" {
  provider = aws.us
  vpc_id   = aws_vpc.us.id
  tags     = { Name = "igw-us" }
}

resource "aws_subnet" "us_public" {
  provider                = aws.us
  vpc_id                  = aws_vpc.us.id
  cidr_block              = var.subnet_cidr_us
  map_public_ip_on_launch = true
  availability_zone       = "${var.region_us}a"
  tags                    = { Name = "subnet-us-public-a" }
}

resource "aws_route_table" "us_public" {
  provider = aws.us
  vpc_id   = aws_vpc.us.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.us.id
  }
  tags = { Name = "rtb-us-public" }
}

resource "aws_route_table_association" "us_public" {
  provider       = aws.us
  subnet_id      = aws_subnet.us_public.id
  route_table_id = aws_route_table.us_public.id
}

# Security Groups (us-east-1)
resource "aws_security_group" "us_windows3" {
  provider    = aws.us
  name        = "sg-windows-3"
  description = "RDP to Windows in Virginia"
  vpc_id      = aws_vpc.us.id

  ingress {
    description = "RDP"
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = [var.allowed_rdp_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "sg-windows-3" }
}

resource "aws_security_group" "us_http3" {
  provider    = aws.us
  name        = "sg-http-3"
  description = "Allow HTTP from Windows-3"
  vpc_id      = aws_vpc.us.id

  ingress {
    description     = "HTTP from Windows-3 SG"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.us_windows3.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "sg-http-3" }
}

# Linux EC2 (instance-3-virginia-1)
resource "aws_instance" "us_linux1" {
  provider                    = aws.us
  ami                         = data.aws_ami.al2023_us.id
  instance_type               = "t3.micro"
  key_name                    = var.key_name
  subnet_id                   = aws_subnet.us_public.id
  vpc_security_group_ids      = [aws_security_group.us_http3.id]
  associate_public_ip_address = true

  user_data = <<-EOF
              #!/bin/bash
              set -eux
              yum -y install httpd
              systemctl enable --now httpd
              echo "Hello from Virginia (http-server-3)" > /var/www/html/index.html
              EOF

  tags = {
    Name = "instance-3-virginia-1"
    Role = "http-server-3"
  }
}

# Windows EC2 (instance-3-virginia-2)
resource "aws_instance" "us_windows3" {
  provider                    = aws.us
  ami                         = data.aws_ami.win2022_us.id
  instance_type               = "t3.large"
  key_name                    = var.key_name
  subnet_id                   = aws_subnet.us_public.id
  vpc_security_group_ids      = [aws_security_group.us_windows3.id]
  associate_public_ip_address = true

  user_data = <<-EOF
              <powershell>
              Install-WindowsFeature -name Web-Server -IncludeManagementTools
              Set-Content -Path "C:\\inetpub\\wwwroot\\index.html" -Value "Hello from Windows in Virginia (windows-server-3)"
              </powershell>
              EOF

  tags = {
    Name = "instance-3-virginia-2"
    Role = "windows-server-3"
  }
}
