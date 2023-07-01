##########################################################################################
# Autoscaling policy for demo
##########################################################################################
resource "aws_autoscaling_policy" "autoscaling_policy" {
  depends_on                   =[module.asg]
  autoscaling_group_name       = module.asg.name
  name                         = module.asg.name
  policy_type                  = "PredictiveScaling"
  predictive_scaling_configuration {
    metric_specification {
      target_value             = 10
      predefined_load_metric_specification {
        predefined_metric_type = "ASGTotalCPUUtilization"
        resource_label         = "sch"
      }
      customized_scaling_metric_specification {
        metric_data_queries {
          id                   = "scaling"
          metric_stat {
            metric {
              metric_name      = "CPUUtilization"
              namespace        = "AWS/EC2"
              dimensions {
                name           = "AutoScalingGroupName"
                value          = module.asg.name
              }
            }
            stat               = "Average"
          }
        }
      }
    }
  }
}

  