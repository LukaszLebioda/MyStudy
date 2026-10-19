# Analyst assumptions:
# [REVISE] register.feature — split from register-login-logout.feature by
#   user-directed revise on 2026-10-19. The scenarios below were gathered
#   2026-10-12 from the user prompt ("Users register with email and password,
#   log in, and log out") in new-feature mode and are preserved verbatim:
#   content, tags, and @req:new# ids unchanged. The login and logout
#   scenarios now live in login-logout.feature.
# Domain matched: auth (novels has no docs yet and is out of scope; login and
#   logout behavior lives in the sibling login-logout.feature).
# Intent (from the original prompt): a visitor creates an account with an
#   email and a password so they can sign in later and keep their novel
#   entries private.
# [DERIVED] Passwords must be at least 8 characters; no other complexity
#   rules (digits, symbols, mixed case) are assumed.
# [DERIVED] Emails must be in a valid email format and unique per account.
# [DERIVED] Registering does not sign the user in automatically — the user
#   logs in explicitly afterwards (login behavior: login-logout.feature).
# [DERIVED] Security internals (password hashing at rest, account storage)
#   are implementation details and deliberately not specified as scenarios.
# [SCOPE-OUT] Login and logout — specified in login-logout.feature.
# [SCOPE-OUT per prompt] Email verification, password reset/recovery, and
#   remember-me — the prompt covers only registration, login, and logout.
# [SCOPE-OUT per prompt] Social/OAuth or any other non-email login — the
#   prompt says "email and password".
# [SCOPE-OUT per prompt] Roles, admin users, and any novels CRUD behavior —
#   the prompt has a single user actor; novels are a separate future feature.
# @todo Email case-sensitivity is undecided (is "Reader@Example.com" the same
#   account as "reader@example.com"?); scenarios use lowercase emails only
#   until the user decides.

Feature: User registration
  As a reader using NovelTracker,
  I want to register with my email and a password,
  So that I can create my account and keep my novel collection and my notes
  private to me.

  Background:
    Given the user database is empty

  @req:new#register-success
  Scenario: Register with a new email and a valid password
    When the user registers with email "reader@example.com" and password "correct-horse"
    Then the user sees a confirmation that the account was created
    But the user is not signed in yet
    And the app shows the login screen

  @req:new#register-duplicate-email
  Scenario: Register with an email that already has an account
    Given a user account exists with email "reader@example.com" and password "correct-horse"
    When the user tries to register again with email "reader@example.com" and password "another-pass-123"
    Then the registration fails
    And the user sees an error that the email is already registered
    And there is still only one account with email "reader@example.com"

  @req:new#register-invalid-email
  Scenario: Register with a malformed email
    When the user tries to register with email "not-an-email" and password "correct-horse"
    Then the registration fails
    And the user sees an error that the email address is not valid
    And no account is created for "not-an-email"

  @req:new#register-short-password
  Scenario: Register with a password shorter than 8 characters
    When the user tries to register with email "reader@example.com" and password "short7"
    Then the registration fails
    And the user sees an error that the password must be at least 8 characters long
    And no account is created for "reader@example.com"

  @req:new#register-missing-email
  Scenario: Register without an email
    When the user tries to register with an empty email and password "correct-horse"
    Then the registration fails
    And the user sees an error that the email is required
    And no account is created

  @req:new#register-missing-password
  Scenario: Register without a password
    When the user tries to register with email "reader@example.com" and an empty password
    Then the registration fails
    And the user sees an error that the password is required
    And no account is created
