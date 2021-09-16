######### Create a policy to permit lambda access to the bucket ###############
resource "aws_s3_bucket_policy" "policy" {
  bucket = aws_s3_bucket.bucket_lambda_beer_functions.bucket

  policy = jsonencode({
    Version = "2012-10-17",
    Id = "aws_s3_bucket_policy"
    Statement = [
    {
      Effect = "Allow",
      Principal = "*",
      Action    = "s3:*",
      Resource =  [
        aws_s3_bucket.bucket_lambda_beer_functions.arn,
        "${aws_s3_bucket.bucket_lambda_beer_functions.arn}/*",
      ],
    }
  ]
})
}
######### Create a policy to permit lambda access to the bucket ###############
resource "aws_iam_policy" "policy" {
  name        = "test-policy"
  description = "A test policy"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "s3:*"
        ],
        Effect = "Allow",
        Resource = "*"
      }
    ]
  })
}

######## Attached IAM Role and the new created Policy #############

resource "aws_iam_role_policy_attachment" "test-attach" {
  role       = "${aws_iam_role.iam_for_lambda.name}"
  policy_arn = "${aws_iam_policy.policy.arn}"

  depends_on = [
    aws_iam_role.iam_for_lambda,
    aws_iam_policy.policy
  ]
}

############# Lambda role ###############
resource "aws_iam_role" "iam_for_lambda" {
  name = "iam_for_lambda"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action =  "sts:AssumeRole",
        Principal = {
          Service = "lambda.amazonaws.com"
        },
        Effect = "Allow",
        Sid = ""
      }
    ]
  })
}

############## Firehose Role ###############
resource "aws_iam_role" "firehose_role" {
  name = "firehose_test_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Principal = {
          Service = "firehose.amazonaws.com"
        },
        Effect = "Allow",
        Sid = ""
      }
    ]
  })
}

resource "aws_iam_role" "lambda_iam" {
  name = "lambda_iam"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Principal = {
          Service = "lambda.amazonaws.com"
        },
        Effect = "Allow",
        Sid = ""
      }
    ]
  })
}
