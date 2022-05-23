module "s3_read" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-policy"
  version = "~> 4"

  name        = "s3_read"
  path        = "/user/"
  description = "My example policy"

  policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Action" : [
            "s3:ListBucket",
            "s3:GetObject",
          ],
          "Effect" : "Allow",
          "Resource" : "*"
        }
      ]
    }
  )
}
