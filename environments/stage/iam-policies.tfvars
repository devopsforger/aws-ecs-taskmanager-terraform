role_policies = {
  ecs_task_execution_policy = {
    name = "ecs-task-execution-policy"
    role = "ecs_task_execution_role"
    policy = {
      Version = "2012-10-17"
      Statement = [
        {
          Effect = "Allow"
          Action = [
            "ecr:GetAuthorizationToken",
            "ecr:BatchCheckLayerAvailability",
            "ecr:GetDownloadUrlForLayer",
            "ecr:BatchGetImage",
            "logs:CreateLogStream",
            "logs:PutLogEvents"
          ]
          Resource = ["*"]
        },
        {
          Effect = "Allow"
          Action = [
            "secretsmanager:GetSecretValue",
            "ssm:GetParameters"
          ]
          Resource = [
            "*"
          ]
        }
      ]
    }
  }

  backend_task_policy = {
    name = "backend-task-policy"
    role = "ecs_task_role"
    policy = {
      Version = "2012-10-17"
      Statement = [
        {
          Effect = "Allow"
          Action = [
            "s3:GetObject",
            "s3:PutObject"
          ]
          Resource = [
            "arn:aws:s3:::your-backend-bucket",
            "arn:aws:s3:::your-backend-bucket/*"
          ]
        },
        {
          Effect = "Allow"
          Action = [
            "rds-db:connect"
          ]
          Resource = [
            "*"
          ]
        }
      ]
    }
  }

  ecs_instance_policy = {
    name = "ecs-instance-policy"
    role = "ecs_instance_role"
    policy = {
      Version = "2012-10-17"
      Statement = [
        {
          Effect = "Allow"
          Action = [
            "ecs:RegisterContainerInstance",
            "ecs:DeregisterContainerInstance",
            "ecs:DiscoverPollEndpoint",
            "ecs:Poll",
            "ecs:Submit*",
            "ecs:StartTelemetrySession"
          ]
          Resource = ["*"]
        },
        {
          Effect = "Allow"
          Action = [
            "ecr:GetAuthorizationToken",
            "ecr:BatchCheckLayerAvailability",
            "ecr:GetDownloadUrlForLayer",
            "ecr:BatchGetImage"
          ]
          Resource = ["*"]
        },
        {
          Effect = "Allow"
          Action = [
            "logs:CreateLogStream",
            "logs:PutLogEvents",
            "logs:DescribeLogStreams"
          ]
          Resource = ["arn:aws:logs:*:*:*"]
        }
      ]
    }
  }
}