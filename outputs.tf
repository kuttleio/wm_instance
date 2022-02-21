output cluster_name {
    description = "ECS Cluster Name"
    value       = module.ecs_cluster.cluster_name
}
output cluster_arn {
    description = "ECS Cluster ARN"
    value       = module.ecs_cluster.cluster_arn
}
output cluster_capacity_provider {
    description = "ECS Cluster Capacity Provider"
    value       = module.ecs_cluster.cluster_capacity_provider
}

output dns_name {
    value = aws_route53_record.main.name
}
output fqdn {
    value = aws_route53_record.main.fqdn
}

output server_port {
    value = var.service_config.server.external_port
}
output admin_port {
    value = var.service_config.admin.external_port
}
output client_port {
    value = var.service_config.client.external_port
}
output billing_port {
    value = var.service_config.billing.port
}
output market_stats_collector_port {
    value = var.service_config.market_stats_collector.port
}
output marketdata_port {
    value = var.service_config.marketdata.port
}
output match_negotiations_port {
    value = var.service_config.match_negotiations.port
}
output matching_port {
    value = var.service_config.matching.port
}
output nego_port {
    value = var.service_config.nego.port
}
output nego_client_port {
    value = var.service_config.nego_client.port
}
output optimizer_port {
    value = var.service_config.optimizer.port
}
output other_port {
    value = var.service_config.other.port
}
output positions_port {
    value = var.service_config.positions.port
}
output refinitiv_ingestion_port {
    value = var.service_config.refinitiv_ingestion.port
}
output requests_port {
    value = var.service_config.requests.port
}
output sales_port {
    value = var.service_config.sales.port
}
output speech_port {
    value = var.service_config.speech.port
}
output uploader_port {
    value = var.service_config.uploader.port
}
