for zip
data "archive_file" "zipit" {
  type        = "zip"
  source_file = "main.py"
  output_path = "main.zip"
}
#for lambda fuction
# module "terraform-aws-lambda-function" {
#   source  = "mineiros-io/lambda-function/aws"
#   version = "~> 0.5.0"
resource "aws_lambda_function" "test_lambda" {
  function_name = "from-terraform"
  description   = "Example Python Lambda Function that returns an HTTP response."
  filename      = "main.zip"
  runtime       = "python3.9"
  source_code_hash = "${data.archive_file.zipit.output_base64sha256}"
  handler       = "main.lambda_handler"

  timeout     = 30
  memory_size = 128

  role = "arn:aws:iam::949263681218:role/service-role/rab-role-uk5ime4t"

  # module_tags = {
  #   Environment = "Rab"
  # }
}