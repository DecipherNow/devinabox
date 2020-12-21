output "ec2ip" {
    value = aws_eip.eip.public_ip
}
