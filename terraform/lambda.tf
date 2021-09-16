########### Lambda Extraction Function #################
resource "aws_lambda_function" "lambda"{
  function_name = "data_extraction_function"
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = "index.test"
  s3_bucket = aws_s3_bucket_object.object.bucket
  s3_key = aws_s3_bucket_object.object.key

  source_code_hash = "${data.aws_s3_bucket_object.data_object.body}"

  runtime = "python3.8"
}


########### Lambda Transformation Function ################
resource "aws_lambda_function" "lambda_processor" {
  filename      = "lambda.zip"
  function_name = "firehose_lambda_processor"
  role          = aws_iam_role.lambda_iam.arn
  handler       = "exports.handler"
  runtime       = "nodejs12.x"
}
