output "Message"{
  value = "Your app has been deployed!"
}

output "AppURL" {
  value = "http://${module.ec2_instance.public_ip}:8081/api/v1"
}

