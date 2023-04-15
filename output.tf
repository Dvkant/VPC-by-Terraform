output "public_ip_demo_server" {
  value       = aws_instance.demo-server.public_ip
  description = "Public_ip"
}

output "private_ip_demo_server" {
  value       = aws_instance.demo-server.private_ip
  description = "Private_ip"
}