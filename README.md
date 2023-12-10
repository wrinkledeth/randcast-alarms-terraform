# ARPA RAndcast Alarms Terraform

Todo: 
- `Okay let's work on OP GOERLI`
- Disable delivery status logging on stack_alarms sns topic

##  EC2's
test-goerli-ec2 (18.191.59.134) (us-east-2)
test-sepolia-ec2 (54.89.160.213) (us-east-1)
prod-mainnet-ec2 (3.93.60.13) (us-east-1)

prod-mainnet-ec2 (3.93.60.13) (us-east-1)
- eth mainnet (1)
- op mainnet (10)
- base mainnet (8453)

test-goerli-ec2 (18.191.59.134) (us-east-2)
- eth goerli (5)
- op goerli (420)  (deprecated jan 2024)
- base goerli (84531)

test-sepolia-ec2 (54.89.160.213) (us-east-1)
- eth sepolia (11155111)
- op sepolia (11155420) (launching soon)
- base sepolia (84532) (launching soon)

### differentiating networks within the logs:

Goerli EC2:
- Mainnet 
- Eth Goerli: 5
- OP: 420
- Base: 84531  (mainnet is 8453)

fulfill randomness successfully
#### Eth Goerli
"Transaction successful(fulfill_randomness) with chain_id(5)"
#### OP Goerli
"Transaction successful(fulfill_randomness) with chain_id(420)"
#### Base Goerli
"Transaction successful(fulfill_randomness) with chain_id(84531)"

#### Improvements:
- Come up with log types / topics as separate json field
  - Randomness Fulfilled Succesfully
- Add a chainid or networkid in addition to nodeid.


## Networks to alert on:
- Eth (1)
- Eth Goerli (5)
- Eth Sepolia (11155111)
- OP (10)
- OP Goerli (420)
- OP Sepolia (11155420)
- Base (8453)
- Base Goerli (84531)
- Base Sepolia (84532)

## Metric Filters

```bash
(goerli) fulfill randomness successfully # OP L2
(sepolia) fulfill randomness successfully # Eth L1 
```

## Rolldice contract locations
eth goerli: 0xCA7990A5639560Df0e20aEAD45AD2c0990768a64
op goerli: 0x278c8a42b3506724153625e7e233BD5940042F0F

## Alarms Flow

- CLoudwatch alarms fires
- Sends topic to SNS topic
- Lambda function is triggered by sns topic
- Lambda sends message to slack channel

## Resources We need to make with TF

Global:
    IAM 
    S3
Regional
    EC2
    Lambda
    SNS
    Cloudwatch

#### SNS Topic IAM Role
ARN: arn:aws:iam::118775932978:role/sns_logs_role
Name: sns_logs_role
Policy: AmazonSNSRole (Allows SNS to push logs to Cloudwatch)
  
#### Slack alarms SNS Topic (in both us-east-1 and us-east2)
ARN: arn:aws:sns:us-east-2:118775932978:slack_alarms
Name: slack_alarms
Desc: Slack alarms get sent here by pervious metric filters 

#### Lambda Execution IAM Role
ARN: arn:aws:iam::118775932978:role/lambda-send-cw-alarms-to-slack-role
Name: lambda-send-cw-alarms-to-slack-role
Policy: AWSLambdaBasicExecutionRole (send logs to CW)

#### Lambda Function (in both us-east-1 and us-east-2)
Name: send-cw-alarms-to-slack
Policy: triggered by sns topic 

#### CW Metric filter 
##### us-east-1
Name: test_sepolia_fulfill_randomness_succesfully_metric_filter
Desc: Look for "fulfill randomness succesfully" string in the "test-sepolia-node-client-logs" log group

##### us-east-2
Name: test_goerli_fulfill_randomness_succesfully_metric_filter
Desc: Look for "fulfill randomness succesfully" string in the "test-goerli-node-client-logs" log group

#### CW Metric filter alarm 
##### us-east-1
Name: test_sepolia_fulfill_randomness_succesfully_cw_alarm
Desc: If we find fulfill randomness succesfully > 1 time in the past 1 minute, send a notification to the slack_alarms sns topic in us-east-1

##### us-east-2
Name: test_goerli_fulfill_randomness_succesfully_cw_alarm
Desc: If we find fulfill randomness succesfully > 1 time in the past 1 minute, sent a notification to the slack_alarms sns topic in us-east-2

#### CW Log Groups
##### us-east-1
test-sepolia-node-client-logs

##### us-east-2
test-goerli-node-client-logs	

## Focus on us-east-2 op-goerli for now!!!


#### SNS Topic IAM Role (global)
ARN: arn:aws:iam::118775932978:role/sns_logs_role
Name: sns_logs_role
Policy: AmazonSNSRole (Allows SNS to push logs to Cloudwatch)
  
#### Lambda Execution IAM Role (global)
ARN: arn:aws:iam::118775932978:role/lambda-send-cw-alarms-to-slack-role
Name: lambda-send-cw-alarms-to-slack-role
Policy: AWSLambdaBasicExecutionRole (send logs to CW)

#### Slack alarms SNS Topic (us-east-2)
ARN: arn:aws:sns:us-east-2:118775932978:slack_alarms
Name: slack_alarms
Desc: Slack alarms get sent here by pervious metric filters 

#### Lambda Function (us-east-2)
Name: send-cw-alarms-to-slack
Policy: triggered by sns topic 

#### CW Metric filter (us-east-2)
Name: test_goerli_fulfill_randomness_succesfully_metric_filter
Desc: Look for "fulfill randomness succesfully" string in the "test-goerli-node-client-logs" log group

#### CW Metric filter alarm  (us-east-2)
Name: test_goerli_fulfill_randomness_succesfully_cw_alarm
Desc: If we find fulfill randomness succesfully > 1 time in the past 1 minute, sent a notification to the slack_alarms sns topic in us-east-2

#### CW Log Groups (us-east-2)
test-goerli-node-client-logs	
 