terraform {
  backend "s3" {
    bucket         = "tdt-terraform-state-054037132427"
    key            = "environments/prod/terraform.tfstate"
    region         = "us-east-2"
    profile        = "tdt"
    dynamodb_table = "tdt-terraform-locks"
    encrypt        = true
  }
}
