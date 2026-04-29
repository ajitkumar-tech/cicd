terraform {
  backend "s3" {
    bucket = "tomcat-demo-project"
    key    = "terraform/terraform.tfstate" 
    region = "ap-south-1"
  }
}
