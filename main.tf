resource "aws_s3_bucket_object" "object" {
  for_each = fileset(var.dist_dir, "**/*")

  bucket = var.bucket_name
  key    = each.value
  source = "${var.dist_dir}/${each.value}"

  etag = filemd5("${var.dist_dir}/${each.value}")
}
