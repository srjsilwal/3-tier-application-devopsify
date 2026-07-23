data "aws_iam_openid_connect_provider" "github" {
  url = "https://token.actions.githubusercontent.com"
}

# Step 2 - Create the IAM Role
resource "aws_iam_role" "github_actions" {
  name = var.role_name

  assume_role_policy = data.aws_iam_policy_document.github_assume_role.json

}

# Step 3 - Trust Policy
data "aws_iam_policy_document" "github_assume_role" {
    statement {
      actions = [
        "sts:AssumeRoleWithWebIdentity"
      ]

      principals {
        type = "Federated"
        identifiers = [
            data.aws_iam_openid_connect_provider.github.arn
        ]
      }

      condition {
        test = "StringEquals"
        variable = "token.actions.githubusercontent.com:aud"
        values = [
            "sts.amazonaws.com"
        ]
      }

      condition {
        test = "StringEquals"
        variable = "token.actions.githubusercontent.com:sub"
        values = [
           "repo:${var.github_repository}:ref:refs/heads/${var.github_branch}"
         ]
      }
    }
}

# Step 4 - IAM Permissions Policy
data "aws_iam_policy_document" "ecr_permissions" {
    statement {
        actions = [
            "ecr:GetAuthorizationToken"
        ]

        resources = ["*"]
    }

    statement {
        actions = [
            "ecr:BatchCheckLayerAvailability",
            "ecr:InitiateLayerUpload",
            "ecr:UploadLayerPart",
            "ecr:CompleteLayerUpload",
            "ecr:PutImage",
            "ecr:BatchGetImage"
        ]

        resources = [
            var.frontend_repository_arn,
            var.backend_repository_arn
        ]
    }
}

# Step 5 - Create the Policy
resource "aws_iam_policy" "github_actions_policy" {
    name = var.policy_name
    policy = data.aws_iam_policy_document.ecr_permissions.json
}

# Step 6 - Attach the Policy
resource "aws_iam_role_policy_attachment" "github_actions" {
    role = aws_iam_role.github_actions.name
    policy_arn = aws_iam_policy.github_actions_policy.arn
}