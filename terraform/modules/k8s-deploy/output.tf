output "internal_lb_ip" {
  value = kubernetes_service.app_service.status.0.load_balancer.0.ingress.0.ip
}