# ---------------------------------------------------
#    LB (Load Balancer)
# ---------------------------------------------------
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

# ---------------------------------------------------
#    TG (Target Groups)
# ---------------------------------------------------
resource aws_lb_target_group public_server_tg {
    name                          = "${var.name_prefix}-${var.wm_instance}-${var.service_config.server.service_name}-tg"
    port                          = var.service_config.server.external_port
    protocol                      = "HTTP"
    vpc_id                        = var.vpc_id
    load_balancing_algorithm_type = "round_robin"
    target_type                   = "ip"
    depends_on                    = [aws_lb.public]

    health_check {
        healthy_threshold   = 3
        unhealthy_threshold = 10
        timeout             = 5
        interval            = 10
        path                = "/health"
        port                = var.service_config.server.external_port
    }
}
resource aws_lb_target_group public_admin_tg {
    name                          = "${var.name_prefix}-${var.wm_instance}-${var.service_config.admin.service_name}-tg"
    port                          = var.service_config.server.external_port
    protocol                      = "HTTP"
    vpc_id                        = var.vpc_id
    load_balancing_algorithm_type = "round_robin"
    target_type                   = "ip"
    depends_on                    = [aws_lb.public]

    health_check {
        healthy_threshold   = 3
        unhealthy_threshold = 10
        timeout             = 5
        interval            = 10
        path                = "/health"
        port                = var.service_config.admin.external_port
    }
}
resource aws_lb_target_group public_client_tg {
    name                          = "${var.name_prefix}-${var.wm_instance}-${var.service_config.client.service_name}-tg"
    port                          = var.service_config.server.external_port
    protocol                      = "HTTP"
    vpc_id                        = var.vpc_id
    load_balancing_algorithm_type = "round_robin"
    target_type                   = "ip"
    depends_on                    = [aws_lb.public]

    health_check {
        healthy_threshold   = 3
        unhealthy_threshold = 10
        timeout             = 5
        interval            = 10
        path                = "/health"
        port                = var.service_config.client.external_port
    }
}


# ---------------------------------------------------
#    Listeners
# ---------------------------------------------------
resource aws_lb_listener public_server_http {
    load_balancer_arn = aws_lb.public.arn
    port              = var.service_config.server.internal_port
    protocol          = "HTTP"
    depends_on        = [aws_lb.public]

    default_action {
        type = "redirect"

        redirect {
            port        = var.service_config.server.external_port
            protocol    = "HTTPS"
            status_code = "HTTP_301"
        }
    }
}
resource aws_lb_listener public_server_https {
    load_balancer_arn = aws_lb.public.arn
    port              = var.service_config.server.external_port
    protocol          = "HTTPS"
    ssl_policy        = "ELBSecurityPolicy-TLS-1-2-Ext-2018-06"
    certificate_arn   = var.aws_lb_certificate_arn

    default_action {
        type             = "forward"
        target_group_arn = aws_lb_target_group.public_server_tg.arn
    }
}

resource aws_lb_listener public_admin {
    load_balancer_arn = aws_lb.public.arn
    port              = var.service_config.admin.internal_port
    protocol          = "HTTP"
    depends_on        = [aws_lb.public]

    default_action {
        type = "redirect"

        redirect {
            port        = var.service_config.admin.external_port
            protocol    = "HTTPS"
            status_code = "HTTP_301"
        }
    }
}
resource aws_lb_listener public_admin_https {
    load_balancer_arn = aws_lb.public.arn
    port              = var.service_config.admin.external_port
    protocol          = "HTTPS"
    ssl_policy        = "ELBSecurityPolicy-TLS-1-2-Ext-2018-06"
    certificate_arn   = var.aws_lb_certificate_arn

    default_action {
        type             = "forward"
        target_group_arn = aws_lb_target_group.public_admin_tg.arn
    }
}

resource aws_lb_listener public_client_http {
    load_balancer_arn = aws_lb.public.arn
    port              = var.service_config.client.internal_port
    protocol          = "HTTP"
    depends_on        = [aws_lb.public]

    default_action {
        type = "redirect"

        redirect {
            port        = var.service_config.client.external_port
            protocol    = "HTTPS"
            status_code = "HTTP_301"
        }
    }
}
resource aws_lb_listener public_client_https {
    load_balancer_arn = aws_lb.public.arn
    port              = var.service_config.client.external_port
    protocol          = "HTTPS"
    ssl_policy        = "ELBSecurityPolicy-TLS-1-2-Ext-2018-06"
    certificate_arn   = var.aws_lb_certificate_arn

    default_action {
        type             = "forward"
        target_group_arn = aws_lb_target_group.public_client_tg.arn
    }
}

# ---------------------------------------------------
#    Listener Rules
# ---------------------------------------------------
resource aws_lb_listener_rule block_header_server {
    listener_arn = aws_lb_listener.public_server_http.arn
    priority = 100

    condition {
        http_header {
            http_header_name = "X-Forwarded-Host"
            values           = ["*"]
        }
    }
    action {
        type = "fixed-response"
        fixed_response {
            content_type = "text/plain"
            message_body = "Invalid host header."
            status_code = 400
        }
    }
}
resource aws_lb_listener_rule block_header_admin {
    listener_arn = aws_lb_listener.public_admin_http.arn
    priority = 100

    condition {
        http_header {
            http_header_name = "X-Forwarded-Host"
            values           = ["*"]
        }
    }
    action {
        type = "fixed-response"
        fixed_response {
            content_type = "text/plain"
            message_body = "Invalid host header."
            status_code = 400
        }
    }
}
resource aws_lb_listener_rule block_header_client {
    listener_arn = aws_lb_listener.public_client_http.arn
    priority = 100

    condition {
        http_header {
            http_header_name = "X-Forwarded-Host"
            values           = ["*"]
        }
    }
    action {
        type = "fixed-response"
        fixed_response {
            content_type = "text/plain"
            message_body = "Invalid host header."
            status_code = 400
        }
    }
}

# ---------------------------------------------------
#    Route53 CNAME Record
# ---------------------------------------------------
resource aws_route53_record main {
    zone_id = var.zone_id.zone_id
    name    = "${var.name_prefix}-${var.wm_instance}."
    type    = "CNAME"
    ttl     = 300
    records = [aws_lb.public.dns_name]
}
