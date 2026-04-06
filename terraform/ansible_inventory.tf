resource "local_file" "ansible_inventory" {
  content = templatefile("${path.module}/templates/hosts.ini.tftpl", {
    app_ip        = aws_eip.app.public_ip
    app2_ip       = aws_eip.app2.public_ip
    monitoring_ip = aws_eip.monitoring.public_ip
  })

  filename = "${path.module}/../ansible/inventory/hosts.ini"
}

resource "local_file" "ansible_group_vars" {
  content = templatefile("${path.module}/templates/all.yml.tftpl", {
    app_private_ip        = aws_instance.app.private_ip
    app2_private_ip       = aws_instance.app2.private_ip
    monitoring_private_ip = aws_instance.monitoring.private_ip
    vpc_cidr              = var.vpc_cidr
  })

  filename = "${path.module}/../ansible/inventory/group_vars/all.yml"
}
