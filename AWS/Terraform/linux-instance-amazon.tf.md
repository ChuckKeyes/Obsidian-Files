
resource "aws_instance" "linux" {
  ami                         = data.aws_ami.al2023.id
  instance_type               = "t3.micro"
  subnet_id                   = aws_subnet.public.id
  vpc_security_group_ids      = [aws_security_group.web.id]
  key_name                    = "my-keypair"     # <— change to your EC2 key
  associate_public_ip_address = true

  user_data = <<-EOF
    #!/bin/bash
    set -eux
    yum -y install httpd
    systemctl enable --now httpd
    echo "Hello from Linux on AWS" > /var/www/html/index.html
  EOF

  tags = { Name = "linux-1" }
}
