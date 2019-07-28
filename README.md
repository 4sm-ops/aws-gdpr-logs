# aws-gdpr-logs
Amazon AWS GDPR Compliance Recommendations - Security Monitoring 

# Notices

This repository provided for informational purposes only. AWS customers are responsible for making their own
independent assessment of the information in this document and any use of AWS’s products or services. Customers should, of course, seek advice from professionals who are familiar with details of the country-specific legislation to ensure compliance with any applicable local laws.

# What services does AWS offer customers to help them comply with the GDPR?

- Asset Management and Configuration with AWS Config
- Compliance Auditing and security analytics with AWS CloudTrail
- Identification of configuration challenges through AWS Trusted Advisor
- Fine granular logging of access to Amazon S3 objects
- Detailed information about flows in the network through Amazon VPC-FlowLogs
- Rule-based configuration checks and actions with AWS Config Rules
- Filtering and monitoring of HTTP access to applications with WAF functions in AWS CloudFront

# Processing Records & Logs

With GDPR focused on data security, a core component is recording and logging your processing activities. You need to have the ability to ensure compliance with tools like AWS Service Catalog for managing IT services centrally. AWS CloudTrail provides continuous monitoring and logging across your AWS infrastructure. AWS Config is there for auditing and assessing your AWS configurations to ensure every change to your AWS infrastructure is logged, providing comprehensive change management and compliance monitoring.

# Overall process description

In order to make your web applications compliant with GDPR I suggest following major steps:
- Enable **Amazon GuardDuty** for all your regions.
- Install **Amazon CloudWatch** on each EC2 appliance to collect and store native **Linux (apache, nginx)** and **Windows (IIS)** logs.

# Permissions

Amazon doesn’t recommend to use **root** account. Thereby 2 options are available:
- Use **root** account to setup GuardDuty/CloudWatch and take all appropriate **risks**.
- **Assign** appropriate permissions to your Administrator’s IAM account or role.

# GuardDuty deployment

Amazon GuardDuty is a security service featuring intelligent threat detection and continuous monitoring. 

## How it works

The service uses machine learning, anomaly detection, and integrated threat intelligence to identify and prioritize potential threats. GuardDuty analyzes tens of billions of events across multiple AWS data sources, such as AWS CloudTrail, Amazon VPC Flow Logs, and DNS logs.

![GuardDuty How it works](https://github.com/rustamabdullin/aws-gdpr-logs/blob/master/aws-gdpr-monitoring-misc/guardduty-howitworks.png)

Amazon provides GuardDuty for 30-days at no cost. You will receive full access to GuardDuty features and its detection findings during the free trial.

To use GuardDuty, you must first enable it. Use the following procedure to enable GuardDuty.

1. Open https://console.aws.amazon.com/guardduty/home with root account.
1. When you open the **GuardDuty** console for the first time, choose **Get Started**, and then choose **Enable GuardDuty**.

    ![GuardDuty Get Started](https://github.com/rustamabdullin/aws-gdpr-logs/blob/master/aws-gdpr-monitoring-misc/guardduty-getstarted.png)

    ![GuardDuty Enable](https://github.com/rustamabdullin/aws-gdpr-logs/blob/master/aws-gdpr-monitoring-misc/guardduty-enable.png)

1. Enable **GuardDuty** in each region with production environment.

## Check GuardDuty Dashboard

Open https://console.aws.amazon.com/guardduty/home to verify existing findings.

![GuardDuty Sample Logs](https://github.com/rustamabdullin/aws-gdpr-logs/blob/master/aws-gdpr-monitoring-misc/guardduty-samplelogs.png)

# CloudWatch deployment

Amazon CloudWatch is a monitoring and management service built for developers, system operators, site reliability engineers and IT managers. CloudWatch provides you with data and actionable insights to monitor your applications, understand and respond to system-wide performance changes, optimize resource utilization, and get a unified view of operational health. 

Our goal is to collect native EC2 Operating systems logs and store it in a secure place with appropriate retention period. If the instance of interest is down, local log files won’t be accessible. CloudWatch log agent ensure that logs are continuously shipped from the instances and stored in a secure and durable place.

## How it works

CloudWatch collects monitoring and operational data in the form of logs, metrics, and events, providing you with a unified view of AWS resources, applications and services that run on AWS, and on-premises servers.

![CloudWatch How it works](https://github.com/rustamabdullin/aws-gdpr-logs/blob/master/aws-gdpr-monitoring-misc/cloudwatch-howitworks.png)

## Preparing IAM permissions

The IAM identity (user, role, group) that you use to enable CloudWatch must have the required permissions. EC2 Instances should be equipped with appropriate permissions as well. 

1. To create the IAM role necessary for each server to run the CloudWatch agent sign in to the AWS Management Console and open the IAM console at https://console.aws.amazon.com/iam/.

1. In the navigation pane, choose **Roles** and then choose **Create role**.

    ![CloudWatch Create Role](https://github.com/rustamabdullin/aws-gdpr-logs/blob/master/aws-gdpr-monitoring-misc/cloudwatch-createrole.png)

1. Under **Select** type of trusted entity, choose **AWS service**.

1. Immediately under **Choose** the service that will use this role, choose **EC2**,and then choose **Next: Permissions**.

1. In the list of policies, select the box next to **CloudWatchAgentServerPolicy**. If necessary, use the search box to find the policy.

1. Choose **Next: Tags** and then choose **Next: Review**.

1. For Role name, enter a name for your new role, such as CloudWatchAgentServerRole or another name that you prefer.

1. Confirm that CloudWatchAgentServerPolicy appears next to Policies.

1. Choose Create role.

1. The role is now created.

## Attach an IAM Role to the Instance

You must attach an **IAM** role to **each EC2 instance with your web site/ web application** to be able to run the CloudWatch agent on the instance. This role enables the CloudWatch agent to perform actions on the instance. Use **CloudWatchAgentServerRole** role you created earlier that includes just the permissions needed for installing and running the agent to attach an IAM role to an instance (console):

1. Open the Amazon EC2 console at https://console.aws.amazon.com/ec2/ .

1. In the navigation pane, choose **Instances**.

1. Select the instance, choose **Actions -> Instance Settings -> Attach/Replace IAM role**.

    ![CloudWatch Attach Role](https://github.com/rustamabdullin/aws-gdpr-logs/blob/master/aws-gdpr-monitoring-misc/cloudwatch-attachrole.png)

1. Select the IAM **CloudWatchAgentServerPolicy** role to attach to your instance, and choose **Apply**.

## CloudWatch Installation

We recommend you to equip **all your production Windows and Linux servers** processing Personal Data with CloudWatch agents. Installation script with predefined settings for:

### Windows and IIS Web server: PowerShell Script Run with Admin awpermissions.
1. Download installation script: https://github.com/rustamabdullin/aws-gdpr-logs/tree/master/aws-gdpr-monitoring-scripts/windows
1. Open PowerShell with Admin permissions.
1. Run installation:

![CloudWatch Windows Script](https://github.com/rustamabdullin/aws-gdpr-logs/blob/master/aws-gdpr-monitoring-misc/cloudwatch-windows.png)

### Linux with apache web server:
1. Download installation script: https://github.com/rustamabdullin/aws-gdpr-logs/tree/master/aws-gdpr-monitoring-scripts/linux
1. Execute script with super user account permissions:

![CloudWatch Linux Script](https://github.com/rustamabdullin/aws-gdpr-logs/blob/master/aws-gdpr-monitoring-misc/cloudwatch-linux.png)

## Verify CloudWatch Dashboard

Verify that logs are exists in appropriate AWS Dashboard: https://console.aws.amazon.com/cloudwatch/home?#logs

![CloudWatch Dashboard](https://github.com/rustamabdullin/aws-gdpr-logs/blob/master/aws-gdpr-monitoring-misc/cloudwatch-dashboard.png)

![CloudWatch Graph](https://github.com/rustamabdullin/aws-gdpr-logs/blob/master/aws-gdpr-monitoring-misc/cloudwatch-graph.png)
