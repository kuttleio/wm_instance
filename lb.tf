resource aws_lb public {
    name               = "${var.name_prefix}-${var.wm_instance}-Public-LB"
    load_balancer_type = "application"
    security_groups    = var.cluster_sg
    subnets            = var.public_subnets

    access_logs {
        bucket  = var.access_logs_s3_bucket
        prefix  = "${var.wm_instance}_lb"
        enabled = true
    }

    tags = merge(var.standard_tags, tomap({ Name = "Public-${var.name_prefix}-${var.wm_instance}" }))
}

resource aws_route53_record main {
    zone_id = var.zone_id.zone_id
    name    = "${var.name_prefix}-${var.wm_instance}."
    type    = "CNAME"
    ttl     = 300
    records = [aws_lb.public.dns_name]
}
