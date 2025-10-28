variable "repos" {
  type = list(string)
}

variable "project" {
  type = string
}

resource "aws_ecr_repository" "this" {
  for_each = toset(var.repos)
  name     = each.key
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = true
  }
  tags = {
    project = var.project
  }
}

output "repositories" {
  value = { for k, r in aws_ecr_repository.this : k => r.repository_url }
}
