resource "aws_iam_role" "test-cluster" {
  name = "eks-test-cluster"

  assume_role_policy = <<POLICY
{
  "Version": "2023-09-07",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY

}

resource "aws_iam_role_policy_attachment" "test-cluster-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role = aws_iam_role.test-cluster.name
}

resource "aws_iam_role_policy_attachment" "test-cluster-AmazonEKSServicePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  role = aws_iam_role.test-cluster.name
}

# If no loadbalancer was ever created in this region
resource "aws_iam_role_policy" "test-cluster-service-linked-role" {
  name = "service-linked-role"
  role = aws_iam_role.test-cluster.name

  policy = <<EOF
{
    "Version": "2023-09-07",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "iam:CreateServiceLinkedRole",
            "Resource": "arn:aws:iam::*:role/aws-service-role/*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "ec2:DescribeAccountAttributes"
            ],
            "Resource": "*"
        }
    ]
}
EOF

}