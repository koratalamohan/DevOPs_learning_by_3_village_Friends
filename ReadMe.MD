# Deploying a single Web server

This project explains How to create EC2 instance and make it as a web server in aws. The Goal is to deploy a simple web architecture possible : a single webserver that responds to HTTP requests .

### Bash script that helps to run a simple web server

```bash
#!/bin/bash
 echo "Hello , wlcome to this page" > index.html
 nohup busybox httpd -f -p ${var.port} &
```
This is a Bash script that writes the text "Hello welcome to this page" into index.html page and runs a simple tool called busybox (which is installed by default on ubuntu) to fire up a web server on port 8080 to serve that file. I wrapped the busybox command with nohup and an ampersand(&) so that the web server runs permently in the background, where as the bash script itself can exit.

#### Port Numbers

The reason in this example uses port 8080 rather than default HTTP port 80 is that listening ao any port less than 1024 requires root user permissions. This is a security risk since any attacker who manages to compromise your server would get root privileges too.
Therefore its is good practise to run webserver with a non root user that has limited permissions.

### Code to create EC2 instance

```bash
resource "aws_instance" "webserver" {
    ami = var.ami
    instance_type = var.instance_type
    vpc_security_group_ids = [aws_security_group.sg.id]
     user_data = <<-EOF
              #!/bin/bash
              echo "Hello , wlcome to this page" > index.html
              nohup busybox httpd -f -p ${var.port} &
              EOF
    user_data_replace_on_change = true
    tags = {
        Name = "webserver"
        owner = "siva"
    }          
}
```
#### Explination

The above code block is used to craete an EC2 instance on aws user data is used to pass the shell script and EC2 instance will execute it during its very first boot. you pass a shell script to user data by setting the **user_data** argument in terraform code.

The **user_data_replace_on_change** paremete is set to **true** so that when you cahnge when you change the **user_data** parameter and **apply** it will terminate the orignal instance and creates the new one. **Terraforms default behaviour is to update the orignal instance in place but since userdata runs only on the very first boot and your orignal instance already went through boot process you need to force the creation of new instance to ensure your new userdata script actually gets executed**

### Code to create security groups
```bash
resource "aws_security_group" "sg" {
    name = "sg for webserver"
    ingress{
        from_port = var.port
        to_port = var.port
        protocol = var.protocal
        cidr_blocks = ["0.0.0.0/0"]
    }
}
```

#### Explination

This code is used to create inbound traffic rule and attach this rule to EC2 instance by default aws doesnt allow inbound or outbound traafic to EC2 instance. To allow the EC2 instance to recive traffic on port 8080 you need to create a security group.


*** PLEASE READ THE ABOVE ARTCILE AND SHARE YOUR OPINION THANK YOU *** 