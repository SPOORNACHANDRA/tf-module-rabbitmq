resource "aws_security_group" "main" {
  name        = "${local.name_prefix}-sg"
  description = "${local.name_prefix}-sg"
  vpc_id      = var.vpc_id
  tags        = merge(local.tags, { name = "${local.name_prefix}-sg" })

  ingress {
    description = "ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.ssh_ingress_cidr
  }
  ingress {
    description = "rabbitmq"
    from_port   = 5672
    to_port     = 5672
    protocol    = "tcp"
    cidr_blocks = var.sg_ingress_cidr
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}


resource "aws_instance" "main" {
  ami = data.aws_ami.ami.id
  instance_type = var.instance_type
  vpc_security_group_ids = [aws_security_group.main.id]
  subnet_id = var.subnet_ids[0]    #one subnet id only need becoz this is not a cluster to create in subnets one instance in one az only
  tags        = merge(local.tags, { name = local.name_prefix })
}
#  user_data = "${path.module}/userdata.sh"
#  `user_data = "${path.module}/userdata.sh"`
#
#  path  is a variable will come automatically
#
#path.module is a module i.e, tf-module-rabbitmq whole
#
#path.root means roboshop-terraform
#
#/userdata.sh     where is your file
#
#if [userdata.sh](http://userdata.sh) is in roboshop-terraform now `user_data = "${path.root}/userdata.sh"`
#
#if [userdata.sh](http://userdata.sh) is in tf-module-rabbitmq  now `user_data = "${path.module}/userdata.sh"`
