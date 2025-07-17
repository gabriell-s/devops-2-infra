resource "aws_iam_role_policy_attachment" "node_group_ebs_csi_policy" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
  role       = module.eks.eks_managed_node_groups["default"].iam_role_name
}
