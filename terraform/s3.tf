#### Create Bucket S3 ##################
resource "aws_s3_bucket" "bucket_lambda_beer_functions" {
  bucket = "bucket-lambda-beer-functions"
  acl    = "private"

  tags = {
    Name = "My lambdas bucket"
  }
}

############# Upload a file in the bucket #######################
resource "aws_s3_bucket_object" "object" {
  bucket = "bucket-lambda-beer-functions"
  key    = "data_extraction_code"
  source = "../src/data_extraction.zip"
  depends_on = [
    aws_s3_bucket.bucket_lambda_beer_functions
  ]

  etag = filemd5("../src/data_extraction.zip")
}

####### Data to access name and key of this bucket ##############
data "aws_s3_bucket_object" "data_object"{
  bucket = "bucket-lambda-beer-functions"
  key    = "data_extraction_code"

  depends_on = [ aws_s3_bucket_object.object ]
}

############ Buckets for raw data ##############
resource "aws_s3_bucket" "bucket_raw_extraction" {
  bucket = "raw-data"
  acl    = "private"
}

############ Buckets for cleaned data ##############
resource "aws_s3_bucket" "bucket_cleaned_extraction" {
  bucket = "cleaned-data"
  acl    = "private"
}
