################### Kinesis Stream ################
resource "aws_kinesis_stream" "kinesis_extraction" {
  name             = "terraform-kinesis-extraction"
  shard_count      = 1
  retention_period = 24

  tags = {
    Environment = "extraction"
  }
}

################### Kinesis Firehouse Raw Data ###################
resource "aws_kinesis_firehose_delivery_stream" "kinesis_firehouse_raw_extraction" {
  name        = "terraform-kinesis-firehose-raw-extraction"
  destination = "extended_s3"
  kinesis_source_configuration = kinesis_extraction.name

  extended_s3_configuration {
    role_arn   = aws_iam_role.firehose_role.arn
    bucket_arn = aws_s3_bucket.bucket_raw_extraction.arn
  }
}

################### Kinesis Firehouse Cleaned Data ###################
resource "aws_kinesis_firehose_delivery_stream" "kinesis_firehouse_cleaned_extraction" {
  name        = "terraform-kinesis-firehose-cleaned-extraction"
  destination = "extended_s3"
  kinesis_source_configuration = kinesis_extraction.name

  extended_s3_configuration {
    role_arn   = aws_iam_role.firehose_role.arn
    bucket_arn = aws_s3_bucket.bucket_cleaned_extraction.arn

    processing_configuration {
      enabled = "true"

      processors {
        type = "Lambda"

        parameters {
          parameter_name  = "LambdaArn"
          parameter_value = "${aws_lambda_function.lambda_processor.arn}:$LATEST"
        }
      }
    }
  }
}
