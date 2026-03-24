provider "aws" {
  region = "us-east-1"
}

resource "aws_dynamodb_table" "challenges" {
  name         = "reality-pass-challenges-dev"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "challenge_id"

  attribute {
    name = "challenge_id"
    type = "S"
  }
}

resource "aws_dynamodb_table" "results" {
  name         = "reality-pass-results-dev"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "pass_id"

  attribute {
    name = "pass_id"
    type = "S"
  }
}
