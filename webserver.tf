resource "aws_security_group" "sg" {
  name = "sg for webserver"
  ingress {
    from_port   = var.server_port
    to_port     = var.server_port
    protocol    = var.protocol
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "webserver" {
  ami                         = var.ami
  instance_type               = var.instance_type
  vpc_security_group_ids      = [aws_security_group.sg.id]
  user_data                   = <<-EOF
              #!/bin/bash
              echo "Hello , wlcome to this page" > index.html
              nohup busybox httpd -f -p ${var.server_port} &
              EOF
  user_data_replace_on_change = true
  tags = {
    Name  = "webserver"
    owner = "siva"
  }
}
