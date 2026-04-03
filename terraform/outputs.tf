output "app_server_public_ip" {
  description = "Public IP of the app server"
  value       = aws_eip.app.public_ip
}

output "monitoring_server_public_ip" {
  description = "Public IP of the monitoring server"
  value       = aws_eip.monitoring.public_ip
}

output "app_server_public_dns" {
  description = "Public DNS of the app server"
  value       = aws_eip.app.public_dns
}

output "monitoring_server_public_dns" {
  description = "Public DNS of the monitoring server"
  value       = aws_eip.monitoring.public_dns
}

output "ssh_app_server" {
  description = "SSH command for app server"
  value       = "ssh -i ~/.ssh/${var.key_name} ubuntu@${aws_eip.app.public_ip}"
}

output "ssh_monitoring_server" {
  description = "SSH command for monitoring server"
  value       = "ssh -i ~/.ssh/${var.key_name} ubuntu@${aws_eip.monitoring.public_ip}"
}

output "app_url" {
  description = "Application URL"
  value       = "http://${aws_eip.app.public_ip}"
}

output "grafana_url" {
  description = "Grafana URL"
  value       = "http://${aws_eip.monitoring.public_ip}:3000"
}

output "prometheus_url" {
  description = "Prometheus URL"
  value       = "http://${aws_eip.monitoring.public_ip}:9090"
}

output "kibana_url" {
  description = "Kibana URL"
  value       = "http://${aws_eip.monitoring.public_ip}:5601"
}

output "app2_server_public_ip" {
  description = "Public IP of the app2 server"
  value       = aws_eip.app2.public_ip
}

output "ssh_app2_server" {
  description = "SSH command for app2 server"
  value       = "ssh -i ~/.ssh/${var.key_name} ubuntu@${aws_eip.app2.public_ip}"
}

output "app_server_private_ip" {
  description = "Private IP of the app server"
  value       = aws_instance.app.private_ip
}

output "app2_server_private_ip" {
  description = "Private IP of the app2 server"
  value       = aws_instance.app2.private_ip
}

output "monitoring_server_private_ip" {
  description = "Private IP of the monitoring server"
  value       = aws_instance.monitoring.private_ip
}
