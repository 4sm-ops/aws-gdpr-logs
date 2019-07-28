# aws-gdpr-logs
Amazon AWS GDPR Compliance Recommendations - Security Monitoring 

# aws-gdpr-logs
Amazon AWS GDPR Compliance Recommendations - Security Monitoring 

# Notices

This repository provided for informational purposes only. AWS customers are responsible for making their own
independent assessment of the information in this document and any use of AWS’s products or services. Customers should, of course, seek advice from professionals who are familiar with details of the country-specific legislation to ensure compliance with any applicable local laws.

# What services does AWS offer customers to help them comply with the GDPR?

Asset Management and Configuration with AWS Config
Compliance Auditing and security analytics with AWS CloudTrail
Identification of configuration challenges through AWS Trusted Advisor
Fine granular logging of access to Amazon S3 objects
Detailed information about flows in the network through Amazon VPC-FlowLogs
Rule-based configuration checks and actions with AWS Config Rules
Filtering and monitoring of HTTP access to applications with WAF functions in AWS CloudFront

# Processing Records & Logs

With GDPR focused on data security, a core component is recording and logging your processing activities. You need to have the ability to ensure compliance with tools like AWS Service Catalog for managing IT services centrally. AWS CloudTrail provides continuous monitoring and logging across your AWS infrastructure. AWS Config is there for auditing and assessing your AWS configurations to ensure every change to your AWS infrastructure is logged, providing comprehensive change management and compliance monitoring.

# Overall process description

In order to make your systems comply with GDPR I suggest following major steps:
Enable Amazon GuardDuty for all your regions.
Install Amazon CloudWatch on each EC2 appliance to collect and store native Linux (apache) and Windows (IIS) logs.

# Permissions

Amazon doesn’t recommend to use root account. Thereby 2 options are available:
Use root account to setup GuardDuty/CloudWatch and take all appropriate risks.
Assign appropriate permissions to your Administrator’s IAM account or role.

# GuardDuty deployment

Amazon GuardDuty is a security service featuring intelligent threat detection and continuous monitoring. 

# How it works

The service uses machine learning, anomaly detection, and integrated threat intelligence to identify and prioritize potential threats. GuardDuty analyzes tens of billions of events across multiple AWS data sources, such as AWS CloudTrail, Amazon VPC Flow Logs, and DNS logs.




