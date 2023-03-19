locals {
  # Credit: https://engineering.statefarm.com/blog/terraform-s3-upload-with-mime/
  mime_types = jsondecode(file("${path.module}/mime-types.json"))
}

resource "aws_s3_bucket_object" "object" {
  for_each = fileset(var.dist_dir, "**/*")

  bucket = var.bucket_name
  key    = each.value
  source = "${var.dist_dir}/${each.value}"

  content_type = lookup(local.mime_types, regex("\\.[^.]+$", each.value), null)

  etag = filemd5("${var.dist_dir}/${each.value}")
}
