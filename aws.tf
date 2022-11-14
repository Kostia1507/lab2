provider "aws"{
    access_key = "AKIA45MNGDZV3J3EEFUL"
    secret_key = "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"
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
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCsCI/TKqn+ct+1gXNQYGT8LgxE/LV4ghT7pqIRuZaKYH2lF37RvSj6cgd5f+3WmRqyNDP86cLaipjVOTTGJMJRPVTyMIOAHFQoWnB6Hr0PW9Oe1ZoyUaU7y96gAU5ZKYMIR3oPwT4OHrmvU49STCuzAsD3wMjwwCF+Yq5/ar+zGOqNODh1ukcjVB8ibMBEieky8dAVOsWEbHP72cYbpqQuEZPpjZZ4siKv18BSJ6lRRpDrgIRJ62+IJ9GisxLNzd9YKYEJSh9AzKCaj7QkzW+85kDEXObHDo3b+XsTpOOkw4SrIcv15MmQmePl/ukgdkQ1xBn6yetl5dJi6T6+juKr8ddNg5ASEP1H/sVLPPQBWm0rqmv8psmaUr6by1AXaAEhCe7tpOCXmpAFiQWecjE56qQq41Dmnw+dS9nZ36BkpRA0k1BHvaOn/6wPigA7EiefJdU4EaSFfDVfwEi2etb8S58+6Blyyx5M9tJpOBpQnnNGcKJdo2/IGnHuCtYN+xc= kosti@DESKTOP-5QLBSRH"
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
