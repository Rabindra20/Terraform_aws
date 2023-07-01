resource "aws_placement_group" "placement_group" {
  name                      = var.name
  strategy                  = var.strategy
}

##########################################################################################
# create template
##########################################################################################
resource "aws_launch_template" "launch_template" {
  name_prefix              = var.launch_template_name
  image_id                 = var.image_id
  instance_type            = var.instance_type
  user_data                = var.userdata
  update_default_version   = true
  key_name= var.key_name
  network_interfaces {
          security_groups  = var.security_groups
              subnet_id    = var.subnet_id
  }
  block_device_mappings {
           device_name = "/dev/sda1" 

           ebs {
               volume_size = var.volume_size
            }
        }
        iam_instance_profile {
                name       =var.iam_instance_profile
        }
  tags = var.tags
}
##########################################################################################
#create autoscaling group
##########################################################################################

resource "aws_autoscaling_group" "asg" {
  name                      = var.asg_name
  max_size                  = var.max_size
  min_size                  = var.min_size
  health_check_grace_period = 300
  health_check_type         = "ELB"
  desired_capacity          = var.desired_capacity
  force_delete              = true
  placement_group           = aws_placement_group.placement_group.id
  wait_for_capacity_timeout = 0
  target_group_arns = var.target_group_arns

  #attach template
  launch_template{
          id                = aws_launch_template.launch_template.id
          version                = "$Latest"
  }
  vpc_zone_identifier       = var.vpc_zone_identifier
  default_instance_warmup   = var.default_instance_warmup

  initial_lifecycle_hook {
    name                    = var.lifecycle_name
    default_result          = "CONTINUE"
    heartbeat_timeout       = 2000
    lifecycle_transition    = "autoscaling:EC2_INSTANCE_LAUNCHING"

  }

  tag {
    key                     = "Name"
    value                   = var.value
    propagate_at_launch     = true
  }
  timeouts {
    delete                  = var.delete_time
  }
}
