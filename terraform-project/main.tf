resource "tls_private_key" "rsa" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
resource "aws_key_pair" "cicd_key" {
  key_name   = "cicd-key"
  public_key = tls_private_key.rsa.public_key_openssh
}

resource "local_file" "private_key" {
  filename = "cicd-key"
  content  = tls_private_key.rsa.private_key_pem
}

resource "aws_security_group" "cicd_sg" {
  name_prefix = "cicd-sg-"
  description = "Allow HTTP and SSH access from anywhere"
  dynamic "ingress" {
    for_each = var.ingressports
    content {
      cidr_blocks = [
        "0.0.0.0/0"
      ]
      from_port = ingress.value
      to_port   = ingress.value
      protocol  = "tcp"
    }
  }

  egress {
    cidr_blocks = [
      "0.0.0.0/0"
    ]
    from_port = 0
    to_port   = 0
    protocol  = "-1"
  }

  tags = {
    "Name" = "cicd-sg"
  }
}



resource "aws_instance" "jenkins_server" {
  ami           = "ami-03f65b8614a860c29"
  instance_type = "t2.micro"
  key_name      = aws_key_pair.cicd_key.key_name
  security_groups = [
    aws_security_group.cicd_sg.name
  ]
  user_data = file("./jenkins_installation.sh")
  tags = {
    Name = "JenkinsServer"
  }
}

resource "aws_instance" "build_server" {
  ami           = "ami-03f65b8614a860c29"
  instance_type = "t2.micro"
  key_name      = aws_key_pair.cicd_key.key_name
  security_groups = [
    aws_security_group.cicd_sg.name
  ]
  user_data = file("./docker_installation.sh")
  tags = {
    "Name" = "BuildServer"
  }
}
