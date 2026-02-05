output "app_url" {
  value = aws_lb.alb.dns_name
}
