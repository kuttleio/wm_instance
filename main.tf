# ---------------------------------------------------
#    ECS Cluster
# ---------------------------------------------------
module ecs_cluster {
    source                    = "github.com/zbs-nu/aws_ecs_cluster//?ref=1.0.0"
    cluster_name              = "${var.name_prefix}-${var.wm_instance}"
    container_insights        = var.container_insights
    instance_types            = var.instance_types
    ebs_disks                 = var.ebs_disks
    key_name                  = var.key_name
    cluster_sg                = var.cluster_sg
    ecs_subnet                = var.private_subnets
    standard_tags             = var.standard_tags
}

# ---------------------------------------------------
#    Services
# ---------------------------------------------------
module server {
    source                  = "github.com/zbs-nu/aws_ecs_service//?ref=do-not-create-lb-stuff-if-public-2022-02-21" # "?ref=1.0.3"""
    name_prefix             = var.name_prefix
    standard_tags           = var.standard_tags
    cluster_name            = module.ecs_cluster.cluster_name
    capacity_provider_name  = module.ecs_cluster.cluster_capacity_provider
    wm_instance             = var.wm_instance
    vpc_id                  = var.vpc_id
    security_groups         = var.security_groups
    subnets                 = var.private_subnets
    logdna_key              = var.logdna_key
    ecr_account_id          = var.account_id
    ecr_region              = var.ecr_region
    aws_lb_arn              = var.aws_lb_arn
    aws_lb_certificate_arn  = var.aws_lb_certificate_arn
    domain_name             = var.domain_name
    environment             = var.environment
    desired_count           = var.desired_count    
    public                  = true
    service_name            = var.service_config.server.service_name
    image_name              = var.service_config.server.image_name
    image_version           = var.service_config.server.image_version
    service_port            = var.service_config.server.internal_port
    aws_lb_out_port         = var.service_config.server.external_port
}

module admin {
    source                  = "github.com/zbs-nu/aws_ecs_service//?ref=do-not-create-lb-stuff-if-public-2022-02-21" # "?ref=1.0.5"
    name_prefix             = var.name_prefix
    standard_tags           = var.standard_tags
    cluster_name            = module.ecs_cluster.cluster_name
    capacity_provider_name  = module.ecs_cluster.cluster_capacity_provider
    wm_instance             = var.wm_instance
    vpc_id                  = var.vpc_id
    security_groups         = var.security_groups
    subnets                 = var.private_subnets
    logdna_key              = var.logdna_key
    ecr_account_id          = var.account_id
    ecr_region              = var.ecr_region
    aws_lb_arn              = var.aws_lb_arn
    aws_lb_certificate_arn  = var.aws_lb_certificate_arn
    domain_name             = var.domain_name
    environment             = var.environment
    desired_count           = var.desired_count
    public                  = true
    service_name            = var.service_config.admin.service_name
    image_name              = var.service_config.admin.image_name
    image_version           = var.service_config.admin.image_version
    service_port            = var.service_config.admin.internal_port
    aws_lb_out_port         = var.service_config.admin.external_port
}

module client {
    source                  = "github.com/zbs-nu/aws_ecs_service//?ref=do-not-create-lb-stuff-if-public-2022-02-21" # "?ref=1.0.5"
    name_prefix             = var.name_prefix
    standard_tags           = var.standard_tags
    cluster_name            = module.ecs_cluster.cluster_name
    capacity_provider_name  = module.ecs_cluster.cluster_capacity_provider
    wm_instance             = var.wm_instance
    vpc_id                  = var.vpc_id
    security_groups         = var.security_groups
    subnets                 = var.private_subnets
    logdna_key              = var.logdna_key
    ecr_account_id          = var.account_id
    ecr_region              = var.ecr_region
    aws_lb_arn              = var.aws_lb_arn
    aws_lb_certificate_arn  = var.aws_lb_certificate_arn
    domain_name             = var.domain_name
    environment             = var.environment
    desired_count           = var.desired_count
    public                  = true
    service_name            = var.service_config.client.service_name
    image_name              = var.service_config.client.image_name
    image_version           = var.service_config.client.image_version
    service_port            = var.service_config.client.internal_port
    aws_lb_out_port         = var.service_config.client.external_port

}

module billing {
    source                  = "github.com/zbs-nu/aws_ecs_service//?ref=do-not-create-lb-stuff-if-public-2022-02-21" # "?ref=1.0.5"
    name_prefix             = var.name_prefix
    standard_tags           = var.standard_tags
    cluster_name            = module.ecs_cluster.cluster_name
    capacity_provider_name  = module.ecs_cluster.cluster_capacity_provider
    wm_instance             = var.wm_instance
    vpc_id                  = var.vpc_id
    security_groups         = var.security_groups
    subnets                 = var.private_subnets
    logdna_key              = var.logdna_key
    ecr_account_id          = var.account_id
    ecr_region              = var.ecr_region
    aws_lb_arn              = var.aws_lb_arn
    aws_lb_certificate_arn  = var.aws_lb_certificate_arn
    domain_name             = var.domain_name
    environment             = var.environment
    desired_count           = var.desired_count
    service_name            = var.service_config.billing.service_name
    image_name              = var.service_config.billing.image_name
    image_version           = var.service_config.billing.image_version
    service_port            = var.service_config.billing.port
}

module market_stats_collector {
    source                  = "github.com/zbs-nu/aws_ecs_service//?ref=do-not-create-lb-stuff-if-public-2022-02-21" # "?ref=1.0.5"
    name_prefix             = var.name_prefix
    standard_tags           = var.standard_tags
    cluster_name            = module.ecs_cluster.cluster_name
    capacity_provider_name  = module.ecs_cluster.cluster_capacity_provider
    wm_instance             = var.wm_instance
    vpc_id                  = var.vpc_id
    security_groups         = var.security_groups
    subnets                 = var.private_subnets
    logdna_key              = var.logdna_key
    ecr_account_id          = var.account_id
    ecr_region              = var.ecr_region
    aws_lb_arn              = var.aws_lb_arn
    aws_lb_certificate_arn  = var.aws_lb_certificate_arn
    domain_name             = var.domain_name
    environment             = var.environment
    desired_count           = var.desired_count
    service_name            = var.service_config.market_stats_collector.service_name
    image_name              = var.service_config.market_stats_collector.image_name
    image_version           = var.service_config.market_stats_collector.image_version
    service_port            = var.service_config.market_stats_collector.port
}

module marketdata {
    source                  = "github.com/zbs-nu/aws_ecs_service//?ref=do-not-create-lb-stuff-if-public-2022-02-21" # "?ref=1.0.5"
    name_prefix             = var.name_prefix
    standard_tags           = var.standard_tags
    cluster_name            = module.ecs_cluster.cluster_name
    capacity_provider_name  = module.ecs_cluster.cluster_capacity_provider
    wm_instance             = var.wm_instance
    vpc_id                  = var.vpc_id
    security_groups         = var.security_groups
    subnets                 = var.private_subnets
    logdna_key              = var.logdna_key
    ecr_account_id          = var.account_id
    ecr_region              = var.ecr_region
    aws_lb_arn              = var.aws_lb_arn
    aws_lb_certificate_arn  = var.aws_lb_certificate_arn
    domain_name             = var.domain_name
    environment             = var.environment
    desired_count           = var.desired_count
    service_name            = var.service_config.marketdata.service_name
    image_name              = var.service_config.marketdata.image_name
    image_version           = var.service_config.marketdata.image_version
    service_port            = var.service_config.marketdata.port
}

module match_negotiations {
    source                  = "github.com/zbs-nu/aws_ecs_service//?ref=do-not-create-lb-stuff-if-public-2022-02-21" # "?ref=1.0.5"
    name_prefix             = var.name_prefix
    standard_tags           = var.standard_tags
    cluster_name            = module.ecs_cluster.cluster_name
    capacity_provider_name  = module.ecs_cluster.cluster_capacity_provider
    wm_instance             = var.wm_instance
    vpc_id                  = var.vpc_id
    security_groups         = var.security_groups
    subnets                 = var.private_subnets
    logdna_key              = var.logdna_key
    ecr_account_id          = var.account_id
    ecr_region              = var.ecr_region
    aws_lb_arn              = var.aws_lb_arn
    aws_lb_certificate_arn  = var.aws_lb_certificate_arn
    domain_name             = var.domain_name
    environment             = var.environment
    desired_count           = var.desired_count
    service_name            = var.service_config.match_negotiations.service_name
    image_name              = var.service_config.match_negotiations.image_name
    image_version           = var.service_config.match_negotiations.image_version
    service_port            = var.service_config.match_negotiations.port
}

module matching {
    source                  = "github.com/zbs-nu/aws_ecs_service//?ref=do-not-create-lb-stuff-if-public-2022-02-21" # "?ref=1.0.5"
    name_prefix             = var.name_prefix
    standard_tags           = var.standard_tags
    cluster_name            = module.ecs_cluster.cluster_name
    capacity_provider_name  = module.ecs_cluster.cluster_capacity_provider
    wm_instance             = var.wm_instance
    vpc_id                  = var.vpc_id
    security_groups         = var.security_groups
    subnets                 = var.private_subnets
    logdna_key              = var.logdna_key
    ecr_account_id          = var.account_id
    ecr_region              = var.ecr_region
    aws_lb_arn              = var.aws_lb_arn
    aws_lb_certificate_arn  = var.aws_lb_certificate_arn
    domain_name             = var.domain_name
    environment             = var.environment
    desired_count           = var.desired_count
    service_name            = var.service_config.matching.service_name
    image_name              = var.service_config.matching.image_name
    image_version           = var.service_config.matching.image_version
    service_port            = var.service_config.matching.port
}

module nego {
    source                  = "github.com/zbs-nu/aws_ecs_service//?ref=do-not-create-lb-stuff-if-public-2022-02-21" # "?ref=1.0.5"
    name_prefix             = var.name_prefix
    standard_tags           = var.standard_tags
    cluster_name            = module.ecs_cluster.cluster_name
    capacity_provider_name  = module.ecs_cluster.cluster_capacity_provider
    wm_instance             = var.wm_instance
    vpc_id                  = var.vpc_id
    security_groups         = var.security_groups
    subnets                 = var.private_subnets
    logdna_key              = var.logdna_key
    ecr_account_id          = var.account_id
    ecr_region              = var.ecr_region
    aws_lb_arn              = var.aws_lb_arn
    aws_lb_certificate_arn  = var.aws_lb_certificate_arn
    domain_name             = var.domain_name
    environment             = var.environment
    desired_count           = var.desired_count
    service_name            = var.service_config.nego.service_name
    image_name              = var.service_config.nego.image_name
    image_version           = var.service_config.nego.image_version
    service_port            = var.service_config.nego.port
}

module nego_client {
    source                  = "github.com/zbs-nu/aws_ecs_service//?ref=do-not-create-lb-stuff-if-public-2022-02-21" # "?ref=1.0.5"
    name_prefix             = var.name_prefix
    standard_tags           = var.standard_tags
    cluster_name            = module.ecs_cluster.cluster_name
    capacity_provider_name  = module.ecs_cluster.cluster_capacity_provider
    wm_instance             = var.wm_instance
    vpc_id                  = var.vpc_id
    security_groups         = var.security_groups
    subnets                 = var.private_subnets
    logdna_key              = var.logdna_key
    ecr_account_id          = var.account_id
    ecr_region              = var.ecr_region
    aws_lb_arn              = var.aws_lb_arn
    aws_lb_certificate_arn  = var.aws_lb_certificate_arn
    domain_name             = var.domain_name
    environment             = var.environment
    desired_count           = var.desired_count
    service_name            = var.service_config.nego_client.service_name
    image_name              = var.service_config.nego_client.image_name
    image_version           = var.service_config.nego_client.image_version
    service_port            = var.service_config.nego_client.port
}

module optimizer {
    source                  = "github.com/zbs-nu/aws_ecs_service//?ref=do-not-create-lb-stuff-if-public-2022-02-21" # "?ref=1.0.5"
    name_prefix             = var.name_prefix
    standard_tags           = var.standard_tags
    cluster_name            = module.ecs_cluster.cluster_name
    capacity_provider_name  = module.ecs_cluster.cluster_capacity_provider
    wm_instance             = var.wm_instance
    vpc_id                  = var.vpc_id
    security_groups         = var.security_groups
    subnets                 = var.private_subnets
    logdna_key              = var.logdna_key
    ecr_account_id          = var.account_id
    ecr_region              = var.ecr_region
    aws_lb_arn              = var.aws_lb_arn
    aws_lb_certificate_arn  = var.aws_lb_certificate_arn
    domain_name             = var.domain_name
    environment             = var.environment
    desired_count           = var.desired_count
    service_name            = var.service_config.optimizer.service_name
    image_name              = var.service_config.optimizer.image_name
    image_version           = var.service_config.optimizer.image_version
    service_port            = var.service_config.optimizer.port
}

module other {
    source                  = "github.com/zbs-nu/aws_ecs_service//?ref=do-not-create-lb-stuff-if-public-2022-02-21" # "?ref=1.0.5"
    name_prefix             = var.name_prefix
    standard_tags           = var.standard_tags
    cluster_name            = module.ecs_cluster.cluster_name
    capacity_provider_name  = module.ecs_cluster.cluster_capacity_provider
    wm_instance             = var.wm_instance
    vpc_id                  = var.vpc_id
    security_groups         = var.security_groups
    subnets                 = var.private_subnets
    logdna_key              = var.logdna_key
    ecr_account_id          = var.account_id
    ecr_region              = var.ecr_region
    aws_lb_arn              = var.aws_lb_arn
    aws_lb_certificate_arn  = var.aws_lb_certificate_arn
    domain_name             = var.domain_name
    environment             = var.environment
    desired_count           = var.desired_count
    service_name            = var.service_config.other.service_name
    image_name              = var.service_config.other.image_name
    image_version           = var.service_config.other.image_version
    service_port            = var.service_config.other.port
}

module positions {
    source                  = "github.com/zbs-nu/aws_ecs_service//?ref=do-not-create-lb-stuff-if-public-2022-02-21" # "?ref=1.0.5"
    name_prefix             = var.name_prefix
    standard_tags           = var.standard_tags
    cluster_name            = module.ecs_cluster.cluster_name
    capacity_provider_name  = module.ecs_cluster.cluster_capacity_provider
    wm_instance             = var.wm_instance
    vpc_id                  = var.vpc_id
    security_groups         = var.security_groups
    subnets                 = var.private_subnets
    logdna_key              = var.logdna_key
    ecr_account_id          = var.account_id
    ecr_region              = var.ecr_region
    aws_lb_arn              = var.aws_lb_arn
    aws_lb_certificate_arn  = var.aws_lb_certificate_arn
    domain_name             = var.domain_name
    environment             = var.environment
    desired_count           = var.desired_count
    service_name            = var.service_config.positions.service_name
    image_name              = var.service_config.positions.image_name
    image_version           = var.service_config.positions.image_version
    service_port            = var.service_config.positions.port
}

module refinitiv_ingestion {
    source                  = "github.com/zbs-nu/aws_ecs_service//?ref=do-not-create-lb-stuff-if-public-2022-02-21" # "?ref=1.0.5"
    name_prefix             = var.name_prefix
    standard_tags           = var.standard_tags
    cluster_name            = module.ecs_cluster.cluster_name
    capacity_provider_name  = module.ecs_cluster.cluster_capacity_provider
    wm_instance             = var.wm_instance
    vpc_id                  = var.vpc_id
    security_groups         = var.security_groups
    subnets                 = var.private_subnets
    logdna_key              = var.logdna_key
    ecr_account_id          = var.account_id
    ecr_region              = var.ecr_region
    aws_lb_arn              = var.aws_lb_arn
    aws_lb_certificate_arn  = var.aws_lb_certificate_arn
    domain_name             = var.domain_name
    environment             = var.environment
    desired_count           = var.desired_count
    service_name            = var.service_config.refinitiv_ingestion.service_name
    image_name              = var.service_config.refinitiv_ingestion.image_name
    image_version           = var.service_config.refinitiv_ingestion.image_version
    service_port            = var.service_config.refinitiv_ingestion.port
}

module requests {
    source                  = "github.com/zbs-nu/aws_ecs_service//?ref=do-not-create-lb-stuff-if-public-2022-02-21" # "?ref=1.0.5"
    name_prefix             = var.name_prefix
    standard_tags           = var.standard_tags
    cluster_name            = module.ecs_cluster.cluster_name
    capacity_provider_name  = module.ecs_cluster.cluster_capacity_provider
    wm_instance             = var.wm_instance
    vpc_id                  = var.vpc_id
    security_groups         = var.security_groups
    subnets                 = var.private_subnets
    logdna_key              = var.logdna_key
    ecr_account_id          = var.account_id
    ecr_region              = var.ecr_region
    aws_lb_arn              = var.aws_lb_arn
    aws_lb_certificate_arn  = var.aws_lb_certificate_arn
    domain_name             = var.domain_name
    environment             = var.environment
    desired_count           = var.desired_count
    service_name            = var.service_config.requests.service_name
    image_name              = var.service_config.requests.image_name
    image_version           = var.service_config.requests.image_version
    service_port            = var.service_config.requests.port
}

module sales {
    source                  = "github.com/zbs-nu/aws_ecs_service//?ref=do-not-create-lb-stuff-if-public-2022-02-21" # "?ref=1.0.5"
    name_prefix             = var.name_prefix
    standard_tags           = var.standard_tags
    cluster_name            = module.ecs_cluster.cluster_name
    capacity_provider_name  = module.ecs_cluster.cluster_capacity_provider
    wm_instance             = var.wm_instance
    vpc_id                  = var.vpc_id
    security_groups         = var.security_groups
    subnets                 = var.private_subnets
    logdna_key              = var.logdna_key
    ecr_account_id          = var.account_id
    ecr_region              = var.ecr_region
    aws_lb_arn              = var.aws_lb_arn
    aws_lb_certificate_arn  = var.aws_lb_certificate_arn
    domain_name             = var.domain_name
    environment             = var.environment
    desired_count           = var.desired_count
    service_name            = var.service_config.sales.service_name
    image_name              = var.service_config.sales.image_name
    image_version           = var.service_config.sales.image_version
    service_port            = var.service_config.sales.port
}

module speech {
    source                  = "github.com/zbs-nu/aws_ecs_service//?ref=do-not-create-lb-stuff-if-public-2022-02-21" # "?ref=1.0.5"
    name_prefix             = var.name_prefix
    standard_tags           = var.standard_tags
    cluster_name            = module.ecs_cluster.cluster_name
    capacity_provider_name  = module.ecs_cluster.cluster_capacity_provider
    wm_instance             = var.wm_instance
    vpc_id                  = var.vpc_id
    security_groups         = var.security_groups
    subnets                 = var.private_subnets
    logdna_key              = var.logdna_key
    ecr_account_id          = var.account_id
    ecr_region              = var.ecr_region
    aws_lb_arn              = var.aws_lb_arn
    aws_lb_certificate_arn  = var.aws_lb_certificate_arn
    domain_name             = var.domain_name
    environment             = var.environment
    desired_count           = var.desired_count
    service_name            = var.service_config.speech.service_name
    image_name              = var.service_config.speech.image_name
    image_version           = var.service_config.speech.image_version
    service_port            = var.service_config.speech.port
}

module uploader {
    source                  = "github.com/zbs-nu/aws_ecs_service//?ref=do-not-create-lb-stuff-if-public-2022-02-21" # "?ref=1.0.5"
    name_prefix             = var.name_prefix
    standard_tags           = var.standard_tags
    cluster_name            = module.ecs_cluster.cluster_name
    capacity_provider_name  = module.ecs_cluster.cluster_capacity_provider
    wm_instance             = var.wm_instance
    vpc_id                  = var.vpc_id
    security_groups         = var.security_groups
    subnets                 = var.private_subnets
    logdna_key              = var.logdna_key
    ecr_account_id          = var.account_id
    ecr_region              = var.ecr_region
    aws_lb_arn              = var.aws_lb_arn
    aws_lb_certificate_arn  = var.aws_lb_certificate_arn
    domain_name             = var.domain_name
    environment             = var.environment
    desired_count           = var.desired_count
    service_name            = var.service_config.uploader.service_name
    image_name              = var.service_config.uploader.image_name
    image_version           = var.service_config.uploader.image_version
    service_port            = var.service_config.uploader.port
}
# ---------------------------------------------------
