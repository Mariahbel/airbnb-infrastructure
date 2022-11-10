resource "aws_s3_bucket" "mar5" {
  #bucket = "my-tf-test-bucket47"  

  tags = {
    Name        = "my bucket"
    Environment = "Dev"
  }

  }
