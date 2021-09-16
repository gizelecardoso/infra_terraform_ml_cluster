provider "aws" {
  region  = "us-east-1"
}

########### CloudWatch Event Rules #########################
resource "aws_cloudwatch_event_rule" "every_five_minute" {
  name                = "every-five-minute"
  description         = "Fires every five minutes"
  schedule_expression = "rate(5 minutes)"
}

########### CloudWatch Event Target #######################
resource "aws_cloudwatch_event_target" "check_foo_every_five_minute" {
  rule      = "${aws_cloudwatch_event_rule.every_five_minute.name}"
  target_id = "lambda"
  arn       = "${aws_lambda_function.lambda.arn}"
}

########## Lambda Permission ######################
resource "aws_lambda_permission" "allow_cloudwatch_to_call_check_foo" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.lambda.function_name}"
  principal     = "events.amazonaws.com"
  source_arn    = "${aws_cloudwatch_event_rule.every_five_minute.arn}"
}