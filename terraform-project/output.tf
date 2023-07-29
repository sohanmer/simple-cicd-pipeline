output "aws_jenkins_server_ip" {
  value = aws_instance.jenkins_server.public_ip //to print public ip of the jenkins server
}

output "aws_build_server_ip" {
  value = aws_instance.build_server.public_ip //to print public ip of the build server
}