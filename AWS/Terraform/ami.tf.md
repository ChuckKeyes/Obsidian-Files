
data "aws_ami" "al2023" {
  most_recent = true
  owners      = ["137112412989"] # Amazon Linux
  filter { name = "name"; values = ["al2023-ami-*-kernel-6.1-x86_64"] }
}

data "aws_ami" "win2022" {
  most_recent = true
  owners      = ["801119661308"] # Amazon Windows
  filter { name = "name"; values = ["Windows_Server-2022-English-Full-Base-*"] }
}
