roles = {
  ecs_task_execution_role = {
    name        = "ecs-task-execution-role"
    path        = "/"
    description = "Allows ECS tasks to pull images, fetch secrets, and send logs."
    assume_role_policy = {
      Version = "2012-10-17"
      Statement = [
        {
          Effect    = "Allow"
          Principal = {
            Service = "ecs-tasks.amazonaws.com"
          }
          Action    = "sts:AssumeRole"
        }
      ]
    }
    max_session_duration  = 3600
    force_detach_policies = true
    tags = {
      Purpose = "ECS-Task-Execution"
    }
  }

  ecs_task_role = {
    name        = "ecs-task-role"
    path        = "/"
    description = "Allows ECS tasks to access AWS services."
    assume_role_policy = {
      Version = "2012-10-17"
      Statement = [
        {
          Effect    = "Allow"
          Principal = {
            Service = "ecs-tasks.amazonaws.com"
          }
          Action    = "sts:AssumeRole"
        }
      ]
    }
    max_session_duration  = 3600
    force_detach_policies = true
    tags = {
      Purpose = "ECS-Task"
    }
  }

  ecs_instance_role = {
    name        = "ecs-instance-role"
    path        = "/"
    description = "Allows EC2 instances to register with ECS."
    assume_role_policy = {
      Version = "2012-10-17"
      Statement = [
        {
          Effect    = "Allow"
          Principal = {
            Service = "ec2.amazonaws.com"
          }
          Action    = "sts:AssumeRole"
        }
      ]
    }
    max_session_duration  = 3600
    force_detach_policies = true
    tags = {
      Purpose = "ECS-Instance"
    }
  }
}