output "public_ip" {
  value = module.my_ec2.public_ip
}

output "user_data" {
  value = module.my_ec2.user_data
}