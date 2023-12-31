  assume_role_policy = <<POLICY
{
  "Version": "2023-09-07",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY

}

resource "aws_iam_role_policy_attachment" "test-node-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role = aws_iam_role.test-node.name
}

resource "aws_iam_role_policy_attachment" "test-node-AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role = aws_iam_role.test-node.name
}

resource "aws_iam_role_policy_attachment" "test-node-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role = aws_iam_role.test-node.name
}

resource "aws_iam_instance_profile" "test-node" {
  name = "eks-test"
  role = aws_iam_role.test-node.name
}