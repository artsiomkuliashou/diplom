resource "local_file" "ansible_inventory" {
  content = templatefile("${path.module}/templates/hosts.ini.tftpl", {
    app_ip        = aws_eip.app.public_ip
    app2_ip       = aws_eip.app2.public_ip
    monitoring_ip = aws_eip.monitoring.public_ip
  })

  filename = "${path.module}/../ansible/inventory/hosts.ini"
}
