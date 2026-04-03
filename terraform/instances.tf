resource "aws_key_pair" "deployer" {
  key_name   = var.key_name
  public_key = file(var.public_key_path)
}

# App Server
resource "aws_instance" "app" {
  ami                    = var.ami_id
  instance_type          = var.app_instance_type
  subnet_id              = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.app.id]
  key_name               = aws_key_pair.deployer.key_name

  root_block_device {
    volume_size = 20
    volume_type = "gp3"
  }

  tags = {
    Name = "${var.project_name}-app-server"
    Role = "app"
  }
}

# App Server 2 (replica)
resource "aws_instance" "app2" {
  ami                    = var.ami_id
  instance_type          = var.app_instance_type
  subnet_id              = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.app.id]
  key_name               = aws_key_pair.deployer.key_name

  root_block_device {
    volume_size = 20
    volume_type = "gp3"
  }

  tags = {
    Name = "${var.project_name}-app2-server"
    Role = "app2"
  }
}

# Monitoring Server
resource "aws_instance" "monitoring" {
  ami                    = var.ami_id
  instance_type          = var.monitoring_instance_type
  subnet_id              = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.monitoring.id]
  key_name               = aws_key_pair.deployer.key_name

  root_block_device {
    volume_size = 30
    volume_type = "gp3"
  }

  tags = {
    Name = "${var.project_name}-monitoring-server"
    Role = "monitoring"
  }
}

# Elastic IP for App Server
resource "aws_eip" "app" {
  instance = aws_instance.app.id
  domain   = "vpc"

  tags = {
    Name = "${var.project_name}-app-eip"
  }
}

# Elastic IP for App Server 2
resource "aws_eip" "app2" {
  instance = aws_instance.app2.id
  domain   = "vpc"

  tags = {
    Name = "${var.project_name}-app2-eip"
  }
}

# Elastic IP for Monitoring Server
resource "aws_eip" "monitoring" {
  instance = aws_instance.monitoring.id
  domain   = "vpc"

  tags = {
    Name = "${var.project_name}-monitoring-eip"
  }
}
