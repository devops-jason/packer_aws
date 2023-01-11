variable "ubuntu_20" {
	type    = string
	default = "ami-08d4ac5b634553e16"
}

variable "ubuntu_22" {
	type    = string
	default = "ami-052efd3df9dad4825"
}

variable "amazon_2" {
	type    = string
	default = "ami-090fa75af13c156b4"
}

locals {
	version = "1.1"
}

source "amazon-ebs" "ubuntu-20" {
	profile       = "mgmt_packer"
	ami_name      = "DBI-Ubuntu-20.04-Standard-${local.version}"
	instance_type = "t2.micro"
	region        = "us-east-1"
	source_ami    = "${var.ubuntu_20}"
	ssh_username  = "ubuntu"
	subnet_id     = "subnet-732ef629"
	tags = {
		Name = "DBI-Ubuntu-20.04-Standard-${local.version}"
		CreatedBy = "Packer <v.jmiller@dbi.com>"
		Version = "${local.version}"
	}
}

source "amazon-ebs" "ubuntu-22" {
	profile       = "mgmt_packer"
	ami_name      = "DBI-Ubuntu-22.04-Standard-${local.version}"
	instance_type = "t2.micro"
	region        = "us-east-1"
	source_ami    = "${var.ubuntu_22}"
	ssh_username  = "ubuntu"
	subnet_id     = "subnet-732ef629"
	tags = {
		Name = "DBI-Ubuntu-22.04-Standard-${local.version}"
		CreatedBy = "Packer <v.jmiller@dbi.com>"
		Version = "${local.version}"
	}
}

source "amazon-ebs" "amazon-2" {
	profile       = "mgmt_packer"
	ami_name      = "DBI-Amazon-2-Standard-${local.version}"
	instance_type = "t2.micro"
	region        = "us-east-1"
	source_ami    = "${var.amazon_2}"
	ssh_username  = "ec2-user"
	subnet_id     = "subnet-732ef629"
	tags = {
		Name = "DBI-Amazon-2-Standard-${local.version}"
		CreatedBy = "Packer <v.jmiller@dbi.com>"
		Version = "${local.version}"
	}
}

build {
	sources = ["source.amazon-ebs.ubuntu-20"]

	provisioner "ansible" {
		playbook_file   = "ansible/dbi.yml"
		user            = "ubuntu"
		extra_arguments = [ "-v" ]
	}

}

build {
	sources = ["source.amazon-ebs.ubuntu-22"]

	provisioner "ansible" {
		playbook_file   = "ansible/dbi.yml"
		user            = "ubuntu"
		extra_arguments = [ "-v" ]
	}
}

build {
	sources = ["source.amazon-ebs.amazon-2"]

	provisioner "ansible" {
		playbook_file   = "ansible/dbi.yml"
		user            = "ec2-user"
		extra_arguments = [ "-v" ]
	}
}

