terraform {
  backend "s3" {
    bucket = "eks-cicd-project"
    key    = "terraform/terraform.tfstate" 
    region = "ap-south-1"
  }
}
