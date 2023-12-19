############################
#! US-EAST-2
############################
#!  Metric Filters for test-goerli-node-client-logs
resource "aws_cloudwatch_log_metric_filter" "eth_goerli_randomness_fulfilled" {
  name           = "eth_goerli_randomness_fulfilled"
  pattern        = "\"Transaction successful(fulfill_randomness) with chain_id(5)\""
  log_group_name = "test-goerli-node-client-logs"

  metric_transformation {
    namespace     = "randcast"
    name          = "eth_goerli_randomness_fulfilled"
    value         = "1"
    default_value = 0
    unit          = "Count"
  }
}

resource "aws_cloudwatch_log_metric_filter" "op_goerli_randomness_fulfilled" {
  name           = "op_goerli_randomness_fulfilled"
  pattern        = "\"Transaction successful(fulfill_randomness) with chain_id(420)\""
  log_group_name = "test-goerli-node-client-logs"

  metric_transformation {
    namespace     = "randcast"
    name          = "op_goerli_randomness_fulfilled"
    value         = "1"
    default_value = 0
    unit          = "Count"
  }
}

resource "aws_cloudwatch_log_metric_filter" "base_goerli_randomness_fulfilled" {
  name           = "base_goerli_randomness_fulfilled"
  pattern        = "\"Transaction successful(fulfill_randomness) with chain_id(84531)\""
  log_group_name = "test-goerli-node-client-logs"

  metric_transformation {
    namespace     = "randcast"
    name          = "base_goerli_randomness_fulfilled"
    value         = "1"
    default_value = 0
    unit          = "Count"
  }
}


#! Alarms for test-goerli-node-client-logs
resource "aws_cloudwatch_metric_alarm" "eth_goerli_randomness_fulfilled_alarm" {
  alarm_name          = "(ETH GOERLI) Randomness Fulfilled"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "eth_goerli_randomness_fulfilled"
  namespace           = "randcast"
  period              = "60"
  statistic           = "Sum"
  threshold           = "1"
  alarm_description   = "This metric checks eth goerli randomness fulfilled"
  alarm_actions       = [aws_sns_topic.alarms.arn]
}

resource "aws_cloudwatch_metric_alarm" "op_goerli_randomness_fulfilled_alarm" {
  alarm_name          = "(OP GOERLI) Randomness Fulfilled"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "op_goerli_randomness_fulfilled"
  namespace           = "randcast"
  period              = "60"
  statistic           = "Sum"
  threshold           = "1"
  alarm_description   = "This metric checks op goerli randomness fulfilled"
  alarm_actions       = [aws_sns_topic.alarms.arn]
}

resource "aws_cloudwatch_metric_alarm" "base_goerli_randomness_fulfilled_alarm" {
  alarm_name          = "(BASE GOERLI) Randomness Fulfilled"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "base_goerli_randomness_fulfilled"
  namespace           = "randcast"
  period              = "60"
  statistic           = "Sum"
  threshold           = "1"
  alarm_description   = "This metric checks base goerli randomness fulfilled"
  alarm_actions       = [aws_sns_topic.alarms.arn]
}
