# terraform-alb-controller
Installing the AWS Load Balancer Controller add-on via Terraform <br>


**Prerequisites**

An existing Amazon EKS cluster. To deploy one, see Getting started with Amazon EKS.

An existing AWS Identity and Access Management (IAM) OpenID Connect (OIDC) provider for your cluster. To determine whether you already have one, or to create one, see Creating an IAM OIDC provider for your cluster.

If your cluster is 1.21 or later, make sure that your Amazon VPC CNI plugin for Kubernetes, kube-proxy, and CoreDNS add-ons are at the minimum versions listed in Service account tokens.

Familiarity with AWS Elastic Load Balancing. For more information, see the Elastic Load Balancing User Guide.

Familiarity with Kubernetes service and ingress resources.

How to use it
```
module "aws_alb_controller" {
  source             = "git::https://github.com/taulanthalili/terraform-alb-controller.git?ref=main"
  region             = module.data.region
  aws_account        = module.data.aws_account
  cluster_name       = module.data.aws_eks_cluster
  oidc_provider_id   = split("/",module.eks.oidc_provider)[2]
}
```
ref: https://docs.aws.amazon.com/eks/latest/userguide/aws-load-balancer-controller.html
