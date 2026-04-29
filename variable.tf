
variable "ingress-rules" {
  type = list(number)
  default = [ 22,8080,80,443,30001 ]
}

variable "egress-rules" {
  type = list(number)
  default = [ 22,8080,80,443,30001 ]
}

variable "eks_cluster_policies" {
  description = "List of policy ARNs to attach to the EKS cluster role"
  type        = list(string)
  default = ["arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"]
}

variable "worker_node_policies" {
  description = "List of policy ARNs to attach to the EKS worker node role"
  type        = list(string)
  default = ["arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy", "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy", "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly", "arn:aws:iam::aws:policy/AmazonEC2FullAccess", "arn:aws:iam::aws:policy/AmazonEKSLoadBalancingPolicy"]
}
