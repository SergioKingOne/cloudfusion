output "alb_dns_name" {
  description = "The DNS name of the Application Load Balancer"
  value       = module.ecs.alb_dns_name
}

output "rds_endpoint" {
  description = "The connection endpoint for the RDS instance"
  value       = module.rds.db_endpoint
}

output "ecr_repository_url" {
  description = "URL of the ECR repository"
  value       = module.ecr.repository_url
}

output "ecs_cluster_id" {
  description = "The ID of the ECS Cluster"
  value       = module.ecs.cluster_id
}

output "cognito_user_pool_id" {
  description = "The ID of the Cognito User Pool"
  value       = module.cognito.user_pool_id
}

output "cognito_user_pool_client_id" {
  description = "The ID of the Cognito User Pool Client"
  value       = module.cognito.user_pool_client_id
}

output "cognito_user_pool_arn" {
  description = "The ARN of the Cognito User Pool"
  value       = module.cognito.user_pool_arn
}
