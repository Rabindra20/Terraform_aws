data "archive_file" "zipit" {
  type        = "zip"
  source_file = "${path.module}/main.py"
  output_path = "${path.module}/main.zip"
}

resource "aws_iam_role" "role" {
  name = "myrole"

  assume_role_policy = "${data.aws_iam_policy_document.policy.json}"
}
#for lambda fuction
# module "terraform-aws-lambda-function" {
#   source  = "mineiros-io/lambda-function/aws"
#   version = "~> 0.5.0"
resource "aws_lambda_function" "test_lambda" {
  function_name = "from-terraform"
  description   = "Example Python Lambda Function that returns an HTTP response."
  filename      = "${path.module}/main.zip"
  runtime       = "python3.9"
  source_code_hash = "${data.archive_file.zipit.output_base64sha256}"
  handler       = "main.lambda_handler"

  timeout     = 30
  memory_size = 128
  role          = aws_iam_role.role.arn
  # role = "arn:aws:iam::949263681218:role/service-role/rab-role-uk5ime4t"

  # module_tags = {
  #   Environment = "Rab"
  # }
}
resource "aws_apigatewayv2_api" "lambda_api" {
  name                       = "terraform-api"
  protocol_type              = "HTTP"
  
}
resource "aws_apigatewayv2_stage" "lambda_stage" {
  api_id = aws_apigatewayv2_api.lambda_api.id
  name   = "$default"
  auto_deploy = true
}

resource "aws_apigatewayv2_integration" "lambda_integration" {
  api_id           = aws_apigatewayv2_api.lambda_api.id
  integration_type = "AWS_PROXY"
  integration_method = "POST"
  integration_uri = aws_lambda_function.test_lambda.invoke_arn
  passthrough_behavior ="WHEN_NO_MATCH"
}
resource "aws_apigatewayv2_route" "lambda_route" {
  api_id    = aws_apigatewayv2_api.lambda_api.id
  route_key = "GET /{proxy+}"
  target = "integrations/${aws_apigatewayv2_integration.lambda_integration.id}"
}

resource "aws_lambda_permission" "apigw_lambda" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.test_lambda.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn = "${aws_apigatewayv2_api.lambda_api.execution_arn}/*/*/*"
}
data "aws_iam_policy_document" "policy" {
  statement {
    sid    = ""
    effect = "Allow"

    principals {
      identifiers = ["lambda.amazonaws.com"]
      type        = "Service"
    }

    actions = ["sts:AssumeRole"]
  }
}
