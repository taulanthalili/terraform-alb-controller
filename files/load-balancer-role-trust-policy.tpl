{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Federated": "arn:aws:iam::${aws-account}:oidc-provider/oidc.eks.${aws-region}.amazonaws.com/id/${oidc-provider-id}"
            },
            "Action": "sts:AssumeRoleWithWebIdentity",
            "Condition": {
                "StringEquals": {
                    "oidc.eks.${aws-region}.amazonaws.com/id/${oidc-provider-id}:aud": "sts.amazonaws.com",
                    "oidc.eks.${aws-region}.amazonaws.com/id/${oidc-provider-id}:sub": "system:serviceaccount:kube-system:aws-load-balancer-controller"
                }
            }
        }
    ]
}