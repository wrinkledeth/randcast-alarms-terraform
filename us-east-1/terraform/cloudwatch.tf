
############################
#! US-EAST-1
############################
#! Metric Filters for test-sepolia-node-client-logs
resource "aws_cloudwatch_log_metric_filter" "eth_sepolia_randomness_fulfilled" {
  name           = "eth_sepolia_randomness_fulfilled"
  pattern        = "\"Transaction successful(fulfill_randomness) with chain_id(11155111)\""
  log_group_name = "test-sepolia-node-client-logs"

  metric_transformation {
    namespace     = "randcast"
    name          = "eth_sepolia_randomness_fulfilled"
    value         = "1"
    default_value = 0
    unit          = "Count"
  }
}

resource "aws_cloudwatch_log_metric_filter" "op_sepolia_randomness_fulfilled" {
  name           = "op_sepolia_randomness_fulfilled"
  pattern        = "\"Transaction successful(fulfill_randomness) with chain_id(11155420)\""
  log_group_name = "test-sepolia-node-client-logs"

  metric_transformation {
    namespace     = "randcast"
    name          = "op_sepolia_randomness_fulfilled"
    value         = "1"
    default_value = 0
    unit          = "Count"
  }
}

resource "aws_cloudwatch_log_metric_filter" "base_sepolia_randomness_fulfilled" {
  name           = "base_sepolia_randomness_fulfilled"
  pattern        = "\"Transaction successful(fulfill_randomness) with chain_id(84532)\""
  log_group_name = "test-sepolia-node-client-logs"

  metric_transformation {
    namespace     = "randcast"
    name          = "base_sepolia_randomness_fulfilled"
    value         = "1"
    default_value = 0
    unit          = "Count"
  }
}

#! Metric Filters for prod-mainnet-node-client-logs
resource "aws_cloudwatch_log_metric_filter" "eth_mainnet_randomness_fulfilled" {
  name           = "eth_mainnet_randomness_fulfilled"
  pattern        = "\"Transaction successful(fulfill_randomness) with chain_id(1)\""
  log_group_name = "prod-mainnet-node-client-logs"

  metric_transformation {
    namespace     = "randcast"
    name          = "eth_mainnet_randomness_fulfilled"
    value         = "1"
    default_value = 0
    unit          = "Count"
  }
}

resource "aws_cloudwatch_log_metric_filter" "op_mainnet_randomness_fulfilled" {
  name           = "op_mainnet_randomness_fulfilled"
  pattern        = "\"Transaction successful(fulfill_randomness) with chain_id(10)\""
  log_group_name = "prod-mainnet-node-client-logs"

  metric_transformation {
    namespace     = "randcast"
    name          = "op_mainnet_randomness_fulfilled"
    value         = "1"
    default_value = 0
    unit          = "Count"
  }
}

resource "aws_cloudwatch_log_metric_filter" "base_mainnet_randomness_fulfilled" {
  name           = "base_mainnet_randomness_fulfilled"
  pattern        = "\"Transaction successful(fulfill_randomness) with chain_id(8453)\""
  log_group_name = "prod-mainnet-node-client-logs"

  metric_transformation {
    namespace     = "randcast"
    name          = "base_mainnet_randomness_fulfilled"
    value         = "1"
    default_value = 0
    unit          = "Count"
  }
}

#! Alarms for test-sepolia-node-client-logs
resource "aws_cloudwatch_metric_alarm" "eth_sepolia_randomness_fulfilled_alarm" {
  alarm_name          = "(ETH SEPOLIA) Randomness Fulfilled"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "eth_sepolia_randomness_fulfilled"
  namespace           = "randcast"
  period              = "60"
  statistic           = "Sum"
  threshold           = "1"
  alarm_description   = "This metric checks eth sepolia randomness fulfilled"
  alarm_actions       = [aws_sns_topic.alarms.arn]
}

resource "aws_cloudwatch_metric_alarm" "op_sepolia_randomness_fulfilled_alarm" {
  alarm_name          = "(OP SEPOLIA) Randomness Fulfilled"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "op_sepolia_randomness_fulfilled"
  namespace           = "randcast"
  period              = "60"
  statistic           = "Sum"
  threshold           = "1"
  alarm_description   = "This metric checks op sepolia randomness fulfilled"
  alarm_actions       = [aws_sns_topic.alarms.arn]
}

resource "aws_cloudwatch_metric_alarm" "base_sepolia_randomness_fulfilled_alarm" {
  alarm_name          = "(BASE SEPOLIA) Randomness Fulfilled"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "base_sepolia_randomness_fulfilled"
  namespace           = "randcast"
  period              = "60"
  statistic           = "Sum"
  threshold           = "1"
  alarm_description   = "This metric checks base sepolia randomness fulfilled"
  alarm_actions       = [aws_sns_topic.alarms.arn]
}

#! Alarms for prod-mainnet-node-client-logs
resource "aws_cloudwatch_metric_alarm" "eth_mainnet_randomness_fulfilled_alarm" {
  alarm_name          = "(ETH MAINNET) Randomness Fulfilled"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "eth_mainnet_randomness_fulfilled"
  namespace           = "randcast"
  period              = "60"
  statistic           = "Sum"
  threshold           = "1"
  alarm_description   = "This metric checks eth mainnet randomness fulfilled"
  alarm_actions       = [aws_sns_topic.alarms.arn]
}

resource "aws_cloudwatch_metric_alarm" "op_mainnet_randomness_fulfilled_alarm" {
  alarm_name          = "(OP MAINNET) Randomness Fulfilled"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "op_mainnet_randomness_fulfilled"
  namespace           = "randcast"
  period              = "60"
  statistic           = "Sum"
  threshold           = "1"
  alarm_description   = "This metric checks op mainnet randomness fulfilled"
  alarm_actions       = [aws_sns_topic.alarms.arn]
}

resource "aws_cloudwatch_metric_alarm" "base_mainnet_randomness_fulfilled_alarm" {
  alarm_name          = "(BASE MAINNET) Randomness Fulfilled"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "base_mainnet_randomness_fulfilled"
  namespace           = "randcast"
  period              = "60"
  statistic           = "Sum"
  threshold           = "1"
  alarm_description   = "This metric checks base mainnet randomness fulfilled"
  alarm_actions       = [aws_sns_topic.alarms.arn]
}
