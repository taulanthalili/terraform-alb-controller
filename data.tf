
resource "aws_iam_policy" "albcontriampolicy" {
  name   = "AWSLoadBalancerControllerIAMPolicy${var.cluster_name}"

  policy = "${file("${path.module}/files/iam_policy.json")}"
}

##TODO cluster's OIDC provider URL.
#aws eks describe-cluster --name my-cluster --query "cluster.identity.oidc.issuer" --output text

data "template_file" "iam-role-template" {
    template = file("${path.module}/files/load-balancer-role-trust-policy.tpl")

    vars = {
      oidc-provider-id = var.oidc_provider_id
      aws-region       = var.region
      aws-account      = var.aws_account
    }
}

resource "aws_iam_role" "albcontriamrole" {
  name               = "AmazonEKSLoadBalancerControllerRole${var.cluster_name}"
  assume_role_policy = data.template_file.iam-role-template.rendered
}

resource "aws_iam_role_policy_attachment" "attach" {
  role       = aws_iam_role.albcontriamrole.name
  policy_arn = aws_iam_policy.albcontriampolicy.arn
}

resource "kubernetes_manifest" "sa-alb-controller" {
  manifest = {
    "apiVersion" = "v1"
    "kind"       = "ServiceAccount"
    "metadata" = {
      "name"      = "aws-load-balancer-controller"
      "namespace" = "kube-system"
      "labels" = {
        "app.kubernetes.io/component"  = "controller" 
        "app.kubernetes.io/name"       = "aws-load-balancer-controller"
      }
      "annotations" = {
         "eks.amazonaws.com/role-arn" = "arn:aws:iam::${var.aws_account}:role/${aws_iam_role.albcontriamrole.name}"
      }
    }

  }
}