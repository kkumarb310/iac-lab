terraform {
  backend "s3" {
    bucket         = "iac-lab-state-0ad57ae3"
    key            = "dev/terraform.tfstate"
    region         = "ap-southeast-1"
    dynamodb_table = "iac-lab-state-lock"
    encrypt        = true
  }
}