# Desafio Infra AWS de DADOS

O desafio conta com uma arquitetura construída através do Terraform, e é composta pelos seguintes serviços da AWS:

  1. CLOUDWATCH

  <a href=https://docs.aws.amazon.com/pt_br/AmazonCloudWatch/latest/monitoring/WhatIsCloudWatch.html>Doc CloudWatch AWS</a>

  <p>O Amazon CloudWatch monitora seus Amazon Web Services (AWS) recursos da e os aplicativos que você executa na AWS em tempo real.</p>
  <p>No desafio a ideia do CloudWatch é disparar a cada 5 minutos uma função <b>Lambda</b> para alimentar o <b>Kinesis</b></p>

  Doc da Estrutura CloudWatch no Terraform, <a href=https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm>clique aqui</a>


  resource "aws_cloudwatch_metric_alarm" "extraction" {
  alarm_name                = "terraform-alarm-request"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  statistic                 = "SampleCount"
  threshold                 = "5"
  alarm_description         = "This metric call lambda function to consume an api"
}


