output "ec2ip" {
    value = aws_instance.instance.public_ip
}
