
resource "aws_security_group" "web" {
  name        = "sg-web"
  description = "Allow SSH, HTTP, RDP"
  vpc_id      = aws_vpc.main.id

  # SSH
  ingress { from_port = 22  to_port = 22  protocol = "tcp" cidr_blocks = ["0.0.0.0/0"] }
  # HTTP
  ingress { from_port = 80  to_port = 80  protocol = "tcp" cidr_blocks = ["0.0.0.0/0"] }
  # RDP (for Windows, optional)
  ingress { from_port = 3389 to_port = 3389 protocol = "tcp" cidr_blocks = ["0.0.0.0/0"] }

  egress  { from_port = 0   to_port = 0   protocol = "-1" cidr_blocks = ["0.0.0.0/0"] }

  tags = { Name = "sg-web" }
}
