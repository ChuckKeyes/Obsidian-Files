
output "vpc_id"        { value = aws_vpc.main.id }
output "subnet_id"     { value = aws_subnet.public.id }
output "linux_public_ip"   { value = aws_instance.linux.public_ip }
output "windows_public_ip" { value = try(aws_instance.windows.public_ip, null) }
