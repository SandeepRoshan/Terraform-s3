********************Terraform AWS S3 Bucket Module*********************
This Terraform module automates the creation of an Amazon S3 bucket on AWS with customizable settings. The module allows users to define key parameters, such as the bucket name, versioning preference, and access control settings.

******************************Features*********************************
S3 Bucket Creation
The core of this module is the creation of an S3 bucket, where users can specify a unique name for their bucket.

***********************Bucket Ownership Controls***********************
Bucket ownership controls are configured to prioritize the bucket owner for object ownership. This ensures proper management of objects within the bucket.

***********************Versioning Configuration************************
Users have the option to enable versioning for the S3 bucket. When versioning is enabled, the bucket keeps track of different versions of objects, providing additional control over data changes.

***********************Access Control Lists (ACLs)*********************
The module supports the configuration of Access Control Lists (ACLs) based on user preferences. If the public_acl variable is set to true, the bucket's ACL is configured to allow public-read access, making certain data publicly accessible. Conversely, if public_acl is set to false, the ACL is set to private, restricting public access.

**********************Public Access Block Settings*********************
For enhanced security, users can configure public access block settings. This feature prevents unintentional public access to the bucket by blocking various public access points.

********************************Usage**********************************

# Define the S3 bucket name and configuration variables
variable "bucket_name" {
  type        = string
  description = "Please provide a globally unique name for your bucket."
}

variable "versioning" {
  type        = bool
  description = "Enter true to enable versioning. Defaults to false."
  default     = false
}

variable "public_acl" {
  type        = bool
  description = "Set to true to enable a public ACL. Defaults to false."
  default     = false
}

# Include the Terraform module for creating the S3 bucket
module "s3_bucket" {
  source      = "your/module/source"
  bucket_name = var.bucket_name
  versioning  = var.versioning
  public_acl  = var.public_acl
}
