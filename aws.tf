provider "aws"{
    access_key = "my key was here"
    secret_key = "my secret key was here"
    region = "eu-central-1" 
}

resource "aws_instance" "myUbuntu"{
    ami = "ami-0caef02b518350c8b" #Ubuntu ami
    instance_type = "t3.micro"
    vpc_security_group_ids = [aws_security_group.ubuntuSecurity.id]
    key_name = "kostia"
    tags = {
        Name = "myUbuntuServer"
    }

    user_data = <<EOF
sudo apt-get update
sudo apt-get install -y apache2
sudo systemctl start apache2
sudo systemctl enable apache2
echo "<h1>Created by Terraform. Hello Kostia Hnitetskiy</h1>" | sudo tee /var/www/html/index.html
EOF
}

resource "aws_key_pair" "myKeys" {
  key_name = "kostia"
  public_key = "ssh-rsa AAA(my key)xc= kosti@DESKTOP-5QLBSRH"
}

resource "aws_security_group" "ubuntuSecurity"{
    name        = "MyUbuntu"
    description = "LabWork4"

 ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}
