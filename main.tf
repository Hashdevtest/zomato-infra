resource "aws_security_group" "frontend-traffic" {
    
  name_prefix        = "${var.project}-${var.environment}-webserver"
  description = "Allow http & https traffic"
    
 ingress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  } 
    
  ingress {
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

    
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  tags = {
      
    "Name" = "${var.project}-${var.environment}-frontend"
    "project" = var.project
    "environemnt" = var.environment
      
  }
}


resource "aws_security_group" "remote-traffic" {
    
  name        = "${var.project}-${var.environment}-remote"
  description = "Allow SSH traffic"
    
 ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  } 
    
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {    
    "Name" = "${var.project}-${var.environment}-remote"
    "project" = var.project
    "environemnt" = var.environment  
  }
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_instance"  "webserver" {
   
  ami = var.instance_ami
  instance_type = var.instance_type
  key_name = var.key
  vpc_security_group_ids  = [ aws_security_group.remote-traffic.id, aws_security_group.frontend-traffic.id ]

  tags = {
      
    "Name" = "${var.project}-${var.environment}-webserver"
  } 
  user_data = file("userdata.sh")
    
}

resource "aws_eip" "webserver" {
  instance = aws_instance.webserver.id
  vpc      = true
}
