data "aws_ami" "amz_linux_2" {
  most_recent = true
  name_regex  = "amzn2-ami-hvm-2.*.1-x86_64-gp2"
  owners      = ["amazon"]
}

data "aws_ami" "server_ami" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}

resource "aws_key_pair" "bko_auth" {
  key_name   = "bkokey2"
  public_key = file("~/.ssh/bkokey.pub")
}



resource "aws_instance" "web_instance" {
  #ami           = data.aws_ami.amz_linux_2.id
  ami           = data.aws_ami.server_ami.id
  instance_type = "t2.nano"

  key_name = aws_key_pair.bko_auth.id

  subnet_id                   = var.public_subnet_id
  vpc_security_group_ids      = [var.public_sg_id]
  associate_public_ip_address = true

  #user_data = file("${path.module}/userdata.sh")

    connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("~/.ssh/bkokey")
    host        = self.public_ip
  }
  tags = {
    "Name" : "Monitoring tool vm"
  }
}
#https://jhooq.com/terraform-null-resource/
resource "null_resource" "initialize-vm" {
  depends_on = [aws_instance.web_instance]
  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("~/.ssh/bkokey")
    host        = aws_instance.web_instance.public_ip
  }

    provisioner "remote-exec" {
    inline = [
      "set -x",
      "mkdir -p /tmp/scripts"
    ]
  }

    provisioner "file" {
    source      = "${path.module}/scripts/"
    destination = "/tmp/scripts"
  }

    provisioner "remote-exec" {
    inline = [
      "set -x",
      "sh /tmp/scripts/initialize-vm.sh"
    ]
  }
}

resource "null_resource" "ansible" {
  depends_on = [null_resource.initialize-vm]
  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("~/.ssh/bkokey")
    host        = aws_instance.web_instance.public_ip
  }
    provisioner "remote-exec" {
    inline = [
      "ansible --version",
      "sh /tmp/scripts/run-ansible.sh"
    ]
  }
}

output "finished" {
  depends_on = [aws_instance.web_instance]
  value      = {}
}