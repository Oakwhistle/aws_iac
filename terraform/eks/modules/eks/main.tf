# EKS Cluster
resource "aws_eks_cluster" "this" {
  name     = var.cluster_name
  role_arn = aws_iam_role.eks_cluster_role.arn

  vpc_config {
    subnet_ids              = var.vpc_subnet_ids
    endpoint_private_access = var.cluster_mode != "PUBLIC"
    endpoint_public_access  = var.cluster_mode != "PRIVATE"
  }

  depends_on = [aws_iam_role_policy_attachment.eks_cluster_AmazonEKSClusterPolicy]
}

# EKS Cluster IAM Role
resource "aws_iam_role" "eks_cluster_role" {
  name = "${var.cluster_name}-eks-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Principal = { Service = "eks.amazonaws.com" }
      Action    = "sts:AssumeRole"
    }]
  })

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "eks_cluster_AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks_cluster_role.name
}

resource "aws_iam_role_policy_attachment" "eks_cluster_AmazonEKSVPCResourceController" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  role       = aws_iam_role.eks_cluster_role.name
}

# EKS Node Group for On-Demand Instances
resource "aws_eks_node_group" "on_demand" {
  count = var.strategy == "mixed" || var.strategy == "on_demand" ? 1 : 0

  cluster_name    = aws_eks_cluster.this.name
  node_group_name = "${var.node_group_name}-on-demand"
  node_role_arn   = aws_iam_role.eks_worker_role.arn
  subnet_ids      = var.vpc_subnet_ids

  scaling_config {
    desired_size = var.node_count
    max_size     = var.max_capacity
    min_size     = var.min_capacity
  }

  instance_types = [var.instance_type]
  capacity_type  = "ON_DEMAND"

  depends_on = [aws_iam_role_policy_attachment.eks_worker_AmazonEKSWorkerNodePolicy]
}

# EKS Node Group for Spot Instances
resource "aws_eks_node_group" "spot" {
  count = var.strategy == "mixed" || var.strategy == "spot" ? 1 : 0

  cluster_name    = aws_eks_cluster.this.name
  node_group_name = "${var.node_group_name}-spot"
  node_role_arn   = aws_iam_role.eks_worker_role.arn
  subnet_ids      = var.vpc_subnet_ids

  scaling_config {
    desired_size = var.node_count
    max_size     = var.max_capacity
    min_size     = var.min_capacity
  }

  instance_types = [var.instance_type]
  capacity_type  = "SPOT"

  depends_on = [aws_iam_role_policy_attachment.eks_worker_AmazonEKSWorkerNodePolicy]
}

# AWS ALB Configuration
resource "aws_lb" "this" {
  name               = "${var.cluster_name}-alb"
  internal           = false
  load_balancer_type = "application"
  subnets            = var.vpc_subnet_ids

  tags = var.tags
}

resource "aws_lb_target_group" "this" {
  name     = "${var.cluster_name}-tg"
  port     = var.alb_target_group.port
  protocol = var.alb_target_group.protocol
  vpc_id   = var.alb_target_group.vpc_id

  tags = var.tags
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.this.arn
  port              = var.alb_listener_http.port
  protocol          = var.alb_listener_http.protocol
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }
}
