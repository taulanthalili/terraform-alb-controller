#TODO add the module to install alb-controller crds resources #The deployed chart doesn't receive security updates automatically
#kubectl apply -k "github.com/aws/eks-charts/stable/aws-load-balancer-controller/crds?ref=master"
resource "helm_release" "alb_ingress_controller" {
  name       = "alb-ingress-controller"
  repository = "https://aws.github.io/eks-charts"
  chart      = "aws-load-balancer-controller"
  version    = "1.4.6"
  namespace = "kube-system"

  set {
    name  = "clusterName"
    value = "${var.cluster_name}" ###Need to be the EKS Cluster as a variable
    type  = "string"
  }

  set {
    name  = "serviceAccount.create"
    value = "false"
  }

  set {
    name  = "serviceAccount.name"
    value = "aws-load-balancer-controller" #"${kubernetes_manifest.sa-alb-controller}" The SA needs to exists
    type  = "string"
  }

  set {
    name  = "image.repository"
    value = "602401143452.dkr.ecr.${var.region}.amazonaws.com/amazon/aws-load-balancer-controller"
    type  = "string"
  }
  depends_on = [
    kubernetes_manifest.sa-alb-controller
  ]
}
