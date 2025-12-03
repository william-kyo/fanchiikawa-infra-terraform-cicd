# pipeline for umi-job-manager

resource "aws_s3_bucket" "cache_bucket" {
  bucket        = "codebuild-cache-${var.namespace}-${var.name}-${var.environment}"
  force_destroy = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "cache_bucket_sse" {
  bucket = aws_s3_bucket.cache_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "cache_bucket_lifecycle" {
  bucket = aws_s3_bucket.cache_bucket.id

  rule {
    id     = "codebuild-cache"
    status = "Enabled"

    filter {
      prefix = "/"
    }

    expiration {
      days = 7
    }
  }
}

resource "aws_s3_bucket_versioning" "cache_bucket_versioning" {
  bucket = aws_s3_bucket.cache_bucket.id

  versioning_configuration {
    status = "Disabled"
  }
}

resource "aws_codebuild_project" "default" {
  name                   = "${var.namespace}-${var.name}-fanchiikawa-env-${var.environment}"
  description            = "Managed By umi-terraform"
  concurrent_build_limit = var.concurrent_build_limit
  service_role           = var.service_role_arn
  badge_enabled          = false
  build_timeout          = 300

  artifacts {
    type = "NO_ARTIFACTS"
  }

  cache {
    type     = "S3"
    location = aws_s3_bucket.cache_bucket.bucket
  }

  environment {
    compute_type    = "BUILD_GENERAL1_SMALL"
    image           = "aws/codebuild/standard:6.0"
    type            = "LINUX_CONTAINER"
    privileged_mode = true

    environment_variable {
      name  = "ECR_URL"
      value = var.ecr_url
      type  = "PLAINTEXT"
    }

    environment_variable {
      name  = "NAMESPACE"
      value = var.namespace
      type  = "PLAINTEXT"
    }

    environment_variable {
      name  = "BUILD_PROJECT"
      value = var.name
      type  = "PLAINTEXT"
    }

    environment_variable {
      name  = "DEPLOY_TYPE"
      value = var.deploy_type
      type  = "PLAINTEXT"
    }

    environment_variable {
      name  = "ENVIRONMENT"
      value = var.environment
      type = "PLAINTEXT"
    }

    environment_variable {
      name  = "CLUSTER_NAME"
      value = var.cluster_name
      type  = "PLAINTEXT"
    }
  }

  source {
    buildspec           = ""
    type                = "GITHUB"
    location            = var.code_source
    report_build_status = false
  }
}


resource "aws_codebuild_webhook" "webhook" {
  project_name = aws_codebuild_project.default.name

  dynamic "filter_group" {
    iterator = event
    for_each = ["PULL_REQUEST_MERGED", "PULL_REQUEST_CREATED", "PULL_REQUEST_UPDATED", "PULL_REQUEST_REOPENED"]

    content {
      filter {
        type    = "EVENT"
        pattern = event.value
      }
      filter {
        type    = "HEAD_REF"
        pattern = "^refs/heads/${var.branch}$"
      }
      filter {
        type    = "BASE_REF"
        pattern = "^refs/heads/main$"
      }
      filter {
        type    = "FILE_PATH"
        pattern = var.trigger_by_root_path ? "^*" : "^${var.name}*"
      }
    }
  }

  filter_group {
    filter {
      type    = "EVENT"
      pattern = "PUSH"
    }
    filter {
      type    = "HEAD_REF"
      pattern = "^refs/heads/${var.branch}$"
    }
  }
}

resource "aws_codestarnotifications_notification_rule" "notification" {
  detail_type = "BASIC"
  event_type_ids = [
    "codebuild-project-build-state-in-progress",
    "codebuild-project-build-state-succeeded",
    "codebuild-project-build-state-failed",
  ]

  name     = "cb-${var.namespace}-${var.name}"
  resource = aws_codebuild_project.default.arn

  target {
    address = var.notification_topic
  }
}