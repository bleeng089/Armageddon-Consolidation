resource "tls_private_key" "MyLinuxBox2-London" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

data "tls_public_key" "MyLinuxBox2-London" {
  private_key_pem = tls_private_key.MyLinuxBox2-London.private_key_pem
}

output "private_key-London" { #"terraform output private_key"  to print to standard output
  value     = tls_private_key.MyLinuxBox2-London.private_key_pem
  sensitive = true
}

output "public_key-London" {
  value = data.tls_public_key.MyLinuxBox2-London.public_key_openssh
}

resource "aws_key_pair" "MyLinuxBox2-London" { #creates a key pair using the public key generated from the tls_private_key.
 provider = aws.eu-west-2
  key_name = "MyLinuxBox2-London" 
  public_key = data.tls_public_key.MyLinuxBox2-London.public_key_openssh 
  }