output "public_ip" {
  value = aws_instance.web_instance.public_ip
}

output "user_data" {
  value = aws_instance.web_instance.user_data
}