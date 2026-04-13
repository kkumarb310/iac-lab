resource "aws_dynamodb_table" "lock" {
  name         = "${var.project}-state-lock"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = merge(var.tags, {
    linked_bucket = var.state_bucket_name
  })

  lifecycle {
    ignore_changes = [tags]
  }
}
