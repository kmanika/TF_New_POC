terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
    datadog = {
      source = "DataDog/datadog"
    }
  }
}

provider "aws" {
  region = "us-east-1"
  shared_credentials_file = var.Cred_file
  profile = "main_cred"
}

provider "datadog" {
  api_key = var.DD_API_Key
  app_key = var.DD_APP_Key
}

data "aws_subnet" "test_subnet" {
  id = var.test_subnet_id
}

data "aws_security_group" "pb_security" {
  id = var.SG_Group
}
data "template_file" "user_data" {
  template = file(var.user_data_file)
}

data "aws_sns_topic" "Ec2-Alarm" {
  name = var.SNS_Name
}

##### Creating EC2 instance #####
resource "aws_instance" "Test_Instance" {
  ami = var.AMI_ID
  instance_type = var.Inst_Type
  subnet_id = data.aws_subnet.test_subnet.id
  associate_public_ip_address = true
  iam_instance_profile = var.Role_Name
  user_data = data.template_file.user_data.template
  security_groups = [ data.aws_security_group.pb_security.id ]
  key_name = var.Key_details
  tags = {
    Name = "Test_Instance"
  }
}

resource "aws_cloudwatch_metric_alarm" "Test_AMI_Alarm" {
  alarm_name = "Terraform_CPU_Alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods = "1"
  metric_name = "CPUUtilization"
  namespace = "AWS/EC2"
  statistic = "Sum"
  period = "60"
  threshold = "2"
  alarm_description = "EC2 CPU utiliazation"
  alarm_actions = [ data.aws_sns_topic.Ec2-Alarm.arn ]
  dimensions = {
    InstanceId = aws_instance.Test_Instance.id
  }

}

resource "datadog_timeboard" "AMI_CPU" {
  title = "CPU Utilization dashbaord"
  description = "EC2 CPU"
  read_only = true
  graph {
    title = "CPU"
    viz = "timeseries"
    request {
      q = var.DD_query
      type = "lines"
    }
  }
   template_variable {
      name = var.DD_Host
    }
}