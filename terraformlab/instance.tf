resource "aws_instance" "master" {
  ami                           = "ami-06e71a1e6ee290060"
  instance_type                 = "t2.medium"
  key_name                      = "terraform_test_rsa"
  vpc_security_group_ids        = ["${data.aws_security_group.selected.id}"]
  provisioner "local-exec" {
    command = <<EOF
      echo "[master]" >> /etc/ansible/hosts
      echo "${aws_instance.master.public_ip}" >> /etc/ansible/hosts
      echo "${aws_instance.master.public_ip}" > /root/masterip
      echo "Host ${aws_instance.master.public_ip}
User ubuntu
IdentityFile /root/.ssh/terraform_test_rsa" >> /etc/ssh/ssh_config
      EOF
  }


  tags = {
                Name = "terraform-master"
        }
}



data "aws_security_group" "selected" {
  name = "terraform"
}


resource "aws_key_pair" "master-key-pair" {
  key_name                      = "terraform_test_rsa"
  public_key                    = file("/root/.ssh/terraform_test_rsa.pub")
  tags = {
        description = "terraform key pair import"
  }
}
