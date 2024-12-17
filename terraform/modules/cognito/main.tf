resource "aws_cognito_user_pool" "main" {
  name = "wanderlog-user-pool"

  #   password_policy {
  #     minimum_length    = 8
  #     require_lowercase = true
  #     require_numbers   = true
  #     require_symbols   = true
  #     require_uppercase = true
  #   }

  username_attributes      = ["email"]
  auto_verified_attributes = ["email"]

  verification_message_template {
    default_email_option = "CONFIRM_WITH_CODE"
  }
}

resource "aws_cognito_user_pool_client" "web_app" {
  name         = "wanderlog-web-client"
  user_pool_id = aws_cognito_user_pool.main.id

  generate_secret = false

  explicit_auth_flows = [
    "ALLOW_USER_SRP_AUTH",
    "ALLOW_REFRESH_TOKEN_AUTH",
    "ALLOW_USER_PASSWORD_AUTH"
  ]
}
