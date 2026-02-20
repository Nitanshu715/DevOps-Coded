resource "aws_cloudwatch_log_group" "strapi_logs" {
  name              = "/ecs/strapi"
  retention_in_days = 7
}

resource "aws_cloudwatch_dashboard" "ecs_dashboard" {
  dashboard_name = "strapi-ecs-dashboard"

  dashboard_body = jsonencode({
    widgets = [
      {
        type = "metric",
        x = 0,
        y = 0,
        width = 12,
        height = 6,
        properties = {
          metrics = [
            ["AWS/ECS", "CPUUtilization", "ClusterName", "strapi-cluster", "ServiceName", "strapi-service"]
          ],
          stat = "Average",
          period = 300,
          region = "us-east-1",
          title = "CPU Utilization"
        }
      },
      {
        type = "metric",
        x = 12,
        y = 0,
        width = 12,
        height = 6,
        properties = {
          metrics = [
            ["AWS/ECS", "MemoryUtilization", "ClusterName", "strapi-cluster", "ServiceName", "strapi-service"]
          ],
          stat = "Average",
          period = 300,
          region = "us-east-1",
          title = "Memory Utilization"
        }
      },
      {
        type = "metric",
        x = 0,
        y = 6,
        width = 12,
        height = 6,
        properties = {
          metrics = [
            ["AWS/ECS", "RunningTaskCount", "ClusterName", "strapi-cluster", "ServiceName", "strapi-service"]
          ],
          stat = "Average",
          period = 300,
          region = "us-east-1",
          title = "Task Count"
        }
      },
      {
        type = "metric",
        x = 12,
        y = 6,
        width = 12,
        height = 6,
        properties = {
          metrics = [
            ["AWS/ECS", "NetworkRxBytes", "ClusterName", "strapi-cluster", "ServiceName", "strapi-service"]
          ],
          stat = "Sum",
          period = 300,
          region = "us-east-1",
          title = "Network In"
        }
      },
      {
        type = "metric",
        x = 0,
        y = 12,
        width = 12,
        height = 6,
        properties = {
          metrics = [
            ["AWS/ECS", "NetworkTxBytes", "ClusterName", "strapi-cluster", "ServiceName", "strapi-service"]
          ],
          stat = "Sum",
          period = 300,
          region = "us-east-1",
          title = "Network Out"
        }
      }
    ]
  })
}