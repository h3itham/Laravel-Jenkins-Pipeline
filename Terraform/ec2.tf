resource "aws_instance" "Server1" {
    	ami = "ami-053b0d53c279acc90"
    	instance_type = "t2.medium"
      key_name      = "haithamkey"

      security_groups = ["${aws_security_group.Laravel.name}"]
    	tags = {
    		Name = "Server1"
    	}
    }

resource "aws_security_group" "Laravel" {
   # Allowing ssh access 
   ingress {
        from_port = 22
        to_port   = 22
        protocol  = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        }
   # Allowing Jenkins access
	  ingress {
   		  from_port = 8080
        to_port   = 8080
        protocol  = "tcp"
        cidr_blocks  = ["0.0.0.0/0"]
        }

	 # Allowing PHP Port 
		ingress { 
			  from_port = 5000
				to_port   = 5000
				protocol  = "tcp"
			  cidr_blocks = ["0.0.0.0/0"]
				
				} 	
	 # Allowing Database(mysql) port 
		ingress { 
				from_port = 3000
				to_port   = 3000
				protocol  = "tcp" 
				cidr_blocks = ["0.0.0.0/0"]
				} 
	 # Allowing PhpMyAdmin
		ingress { 
				from_port = 4000
				to_port   = 4000
				protocol  = "tcp" 
				cidr_blocks = ["0.0.0.0/0"] 
       }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        }

      }
output "ec2_global_ips" {
  value = ["${aws_instance.Server1.*.public_ip}"]
   }
 
