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
resource "aws_iam_role" "lambda_exec" {
  name = "reality-pass-lambda-role-dev"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}

resource "aws_lambda_function" "verifier" {
  function_name = "reality-pass-verifier-dev"
  handler       = "handler.lambda_handler"
  runtime       = "python3.11"
  role          = aws_iam_role.lambda_exec.arn

  filename         = "${path.module}/../../services/verifier/app.zip"
  source_code_hash = filebase64sha256("${path.module}/../../services/verifier/app.zip")
}

resource "aws_apigatewayv2_api" "api" {
  name          = "reality-pass-api-dev"
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_integration" "lambda" {
  api_id           = aws_apigatewayv2_api.api.id
  integration_type = "AWS_PROXY"
  integration_uri  = aws_lambda_function.verifier.invoke_arn
}

resource "aws_apigatewayv2_route" "verify" {
  api_id    = aws_apigatewayv2_api.api.id
  route_key = "POST /verify"
  target    = "integrations/${aws_apigatewayv2_integration.lambda.id}"
}

resource "aws_apigatewayv2_stage" "default" {
  api_id      = aws_apigatewayv2_api.api.id
  name        = "$default"
  auto_deploy = true
}
