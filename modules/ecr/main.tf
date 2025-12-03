# Use random_string resource to generate random string
# resource "random_string" "random" {
#   length  = 6
#   special = false
# }

resource "aws_ecr_repository" "repo" {
  name                 = "${var.name}"
  image_tag_mutability = var.mutability

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = var.tags
}

resource "aws_ecr_lifecycle_policy" "expire" {
  repository = aws_ecr_repository.repo.name

  policy = <<EOF
{
    "rules": [
        {
            "rulePriority": 1,
            "description": "Keep last 5 images",
            "selection": {
                "tagStatus": "any",
                "countType": "imageCountMoreThan",
                "countNumber": 5
            },
            "action": {
                "type": "expire"
            }
        }
    ]
}
EOF
}