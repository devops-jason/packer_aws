# Packer #

This is used to build standard OS images.  You should validate the packer file before building the images.

## Validate
The following command is used to validate the packer file.

`packer validate dbi.pkr.hcl`

## Build
In order to build the AMI's for AWS.  Run the following command to start the build process

`packer build dbi.pkr.hcl`

