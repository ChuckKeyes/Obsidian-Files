
resource "aws_instance" "windows" {
  ami                         = data.aws_ami.win2022.id
  instance_type               = "t3.large"
  subnet_id                   = aws_subnet.public.id
  vpc_security_group_ids      = [aws_security_group.web.id]
  key_name                    = "my-keypair"     # <— change
  associate_public_ip_address = true

  user_data = <<-EOF
    <powershell>
    Install-WindowsFeature -name Web-Server -IncludeManagementTools
    Set-Content -Path "C:\\inetpub\\wwwroot\\index.html" -Value "Hello from Windows on AWS"
    </powershell>
  EOF

  tags = { Name = "windows-1" }
}
