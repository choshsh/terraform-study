locals {
  bucket_name = "choshsh-test-s3"
}

module "s3_test" {
  source = "terraform-aws-modules/s3-bucket/aws"

  bucket = local.bucket_name

  acl                     = "private"
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

  attach_policy = true
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : "s3:List*",
        "Principal" : {
          "AWS" : [
            "arn:aws:iam::801167518143:role/choshsh-ec2-role"
          ]
        },
        "Resource" : [
          "arn:aws:s3:::${local.bucket_name}"
        ]
      }
    ]
  })

  versioning = {
    enabled = false
  }
}
