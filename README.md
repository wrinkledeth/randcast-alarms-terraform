# Randcast Alarms Terraform IAC

Terraform to deploy Randcast AWS Metrics and Alarms infrastructure. 


## Usage
```bash
cd tf
terraform init # download provider plugin to interact with docker
terraform validate # validate
terraform plan # view the state changes that will occur
terraform apply # provision the resources
terraform destroy # kill previously provisioned resources 
```

## Folder structure
```bash
.
└── tf/
    ├── cloudwatch.tf
    ├── lambda-s3-bucket.tf
    ├── lambda.tf
    ├── provider.tf
    ├── sns-topic.tf
    ├── terraform.tfstate
    └── terraform.tfstate.backup
└── functions/
    └── send-cloudwatch-alarms-to-slack/
        └── function.py
```

## Slack Alarm Example
![](.images/alarm_example.png)

## Planned networks to alert on
- [ ] Eth (1)
- [ ] OP (10)
- [ ] Base (8453)
- [x] Eth Goerli (5)  
- [x] OP Goerli (420)
- [x] Base Goerli (84531)
- [ ] Eth Sepolia (11155111)
- [ ] OP Sepolia (11155420)
- [ ] Base Sepolia (84532)

## Metric Filters Used
(us-east-2)
- Eth Goerli: "Transaction successful(fulfill_randomness) with chain_id(5)"
- OP Goerli: "Transaction successful(fulfill_randomness) with chain_id(420)"
- Base Goerli: "Transaction successful(fulfill_randomness) with chain_id(84531)"

## Rolldice contract locations (for testing)
- eth goerli: 0xCA7990A5639560Df0e20aEAD45AD2c0990768a64
- op goerli: 0x278c8a42b3506724153625e7e233BD5940042F0F