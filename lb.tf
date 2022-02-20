resource "aws_lb" "public" {
    name               = "${var.name_prefix}-${var.wm_instance}-Public-LB"
    load_balancer_type = "application"
    security_groups    = var.public_lb_security_groups
    subnets            = var.public_subnets

    access_logs {
        bucket  = ""
        prefix  = "${var.wm_instance}_lb"
        enabled = true
    }

    tags = merge(var.standard_tags, tomap({ Name = "Public-${var.name_prefix}-${var.wm_instance}" }))
}

resource "aws_lb_listener" "public_admin" {
    load_balancer_arn = aws_lb.public.arn
    port              = var.service_config.admin.internal_port
    protocol          = "HTTP"
    depends_on        = [aws_lb.public]

    default_action {
        type = "redirect"

        redirect {
            port        = var.external_port
            protocol    = "HTTPS"
            status_code = "HTTP_301"
        }
    }
}
resource "aws_lb_listener" "public_client" {
    load_balancer_arn = aws_lb.public.arn
    port              = var.service_config.client.internal_port
    protocol          = "HTTP"
    depends_on        = [aws_lb.public]

    default_action {
        type = "redirect"

        redirect {
            port        = var.external_port
            protocol    = "HTTPS"
            status_code = "HTTP_301"
        }
    }
}

resource "aws_lb_listener_rule" "block_header_server" {
    listener_arn = aws_lb_listener.public_server.arn
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
resource "aws_lb_listener_rule" "block_header_admin" {
    listener_arn = aws_lb_listener.public_admin.arn
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

resource "aws_lb_listener_rule" "block_header_client" {
    listener_arn = aws_lb_listener.public_client.arn
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


resource "aws_route53_record" "main" {
    zone_id = var.zone_id
    name    = "${var.name_prefix}-${var.wm_instance}."
    type    = "CNAME"
    ttl     = 300
    records = [aws_lb.public.dns_name]
}
