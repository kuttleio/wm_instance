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


output server {
    value = var.service_config.server.port
}
output billing {
    value = var.service_config.billing.port
}
output market_stats_collector {
    value = var.service_config.market_stats_collector.port
}
output marketdata {
    value = var.service_config.marketdata.port
}
output match_negotiations {
    value = var.service_config.match_negotiations.port
}
output matching {
    value = var.service_config.matching.port
}
output nego {
    value = var.service_config.nego.port
}
output nego_client {
    value = var.service_config.nego_client.port
}
output optimizer {
    value = var.service_config.optimizer.port
}
output other {
    value = var.service_config.other.port
}
output positions {
    value = var.service_config.positions.port
}
output refinitiv_ingestion {
    value = var.service_config.refinitiv_ingestion.port
}
output requests {
    value = var.service_config.requests.port
}
output sales {
    value = var.service_config.sales.port
}
output speech {
    value = var.service_config.speech.port
}
output uploader {
    value = var.service_config.uploader.port
}
