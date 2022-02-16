output "cluster_name" {
    description = "ECS Cluster Name"
    value       = module.ecs_cluster.cluster_name
}
output "cluster_arn" {
    description = "ECS Cluster ARN"
    value       = module.ecs_cluster.cluster_arn
}
output "cluster_capacity_provider" {
    description = "ECS Cluster Capacity Provider"
    value       = module.ecs_cluster.cluster_capacity_provider
}


output billing_port {
    value = var.service_config.billing.port
}

output marketdata_port {
    value = var.service_config.marketdata.port
}

output nego_port {
    value = var.service_config.nego.port
}
