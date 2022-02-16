# ---------------------------------------------------
#    ECS Cluster
# ---------------------------------------------------
module "ecs_cluster" {
    source                    = "github.com/zbs-nu/aws_ecs_cluster//"
    cluster_name              = "${var.name_prefix}-${var.wm_instance}"
    container_insights        = var.container_insights
    instance_types            = var.instance_types
    ebs_disks                 = var.ebs_disks
    key_name                  = var.key_name
    cluster_sg                = var.subnets # var.cluster_sg
    ecs_subnet                = var.ecs_subnets
    standard_tags             = var.standard_tags
}


# ---------------------------------------------------
#    Billing
# ---------------------------------------------------
module billing {
    source                  = "github.com/zbs-nu/aws_ecs_service//"
    name_prefix             = var.name_prefix
    standard_tags           = var.standard_tags
    cluster_name            = module.ecs_cluster.cluster_name
    capacity_provider_name  = module.ecs_cluster.capacity_provider_name
    wm_instance             = var.wm_instance
    vpc_id                  = var.vpc_id
    security_groups         = var.security_groups
    subnets                 = var.subnets
    logdna_key              = var.logdna_key
    account_id              = var.account_id
    ecr_account_id          = var.account_id
    ecr_region              = var.ecr_region
    aws_lb_arn              = var.aws_lb_arn
    aws_lb_certificate_arn  = var.aws_lb_certificate_arn
    environment             = var.environment
    service_name            = var.service_config.billing.service_name
    image_name              = var.service_config.billing.image_name
    image_version           = var.service_config.billing.image_version
    service_port            = var.service_config.billing.port
}

# ---------------------------------------------------
#    Marketdata
# ---------------------------------------------------
module marketdata {
    source                  = "github.com/zbs-nu/aws_ecs_service//"
    name_prefix             = var.name_prefix
    standard_tags           = var.standard_tags
    cluster_name            = module.ecs_cluster.cluster_name
    capacity_provider_name  = module.ecs_cluster.capacity_provider_name
    wm_instance             = var.wm_instance
    vpc_id                  = var.vpc_id
    security_groups         = var.security_groups
    subnets                 = var.subnets
    logdna_key              = var.logdna_key
    account_id              = var.account_id
    ecr_account_id          = var.account_id
    ecr_region              = var.ecr_region
    aws_lb_arn              = var.aws_lb_arn
    aws_lb_certificate_arn  = var.aws_lb_certificate_arn
    environment             = var.environment
    service_name            = var.service_config.marketdata.service_name
    image_name              = var.service_config.marketdata.image_name
    image_version           = var.service_config.marketdata.image_version
    service_port            = var.service_config.marketdata.port
}

# ---------------------------------------------------
#    Nego
# ---------------------------------------------------
module nego {
    source                  = "github.com/zbs-nu/aws_ecs_service//"
    name_prefix             = var.name_prefix
    standard_tags           = var.standard_tags
    cluster_name            = module.ecs_cluster.cluster_name
    capacity_provider_name  = module.ecs_cluster.capacity_provider_name
    wm_instance             = var.wm_instance
    vpc_id                  = var.vpc_id
    security_groups         = var.security_groups
    subnets                 = var.subnets
    logdna_key              = var.logdna_key
    account_id              = var.account_id
    ecr_account_id          = var.account_id
    ecr_region              = var.ecr_region
    aws_lb_arn              = var.aws_lb_arn
    aws_lb_certificate_arn  = var.aws_lb_certificate_arn
    environment             = var.environment
    service_name            = var.service_config.nego.service_name
    image_name              = var.service_config.nego.image_name
    image_version           = var.service_config.nego.image_version
    service_port            = var.service_config.nego.port
}
