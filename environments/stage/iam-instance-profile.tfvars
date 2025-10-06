instance_profiles = {
  ecs_instance_profile = {
    name = "ecs-instance-profile"
    role = "ecs_instance_role"
    tags = {
      Purpose     = "ECS-Container-Instance"
      Environment = "stage"
    }
  }
}