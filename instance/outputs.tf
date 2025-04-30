output "public_ip" {
  value = aws_instance.terrafromDockerApp.public_ip
}

output "instance_id" {
  value = aws_instance.terrafromDockerApp.id
}

output "availability_zone" {
  value = aws_instance.terrafromDockerApp.availability_zone
}

