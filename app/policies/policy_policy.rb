# frozen_string_literal: true

class PolicyPolicy < ApplicationPolicy
  def policies = resource.subjects
  def policy   = resource.subject

  def index?
    assert_account_scoped!
    assert_permissions! %w[
      policy.read
    ]

    bearer.has_role?(:admin, :developer, :read_only, :sales_agent, :support_agent) ||
      (bearer.has_role?(:product) &&
        policies.all? { _1.product_id == bearer.id })
  end

  def show?
    assert_account_scoped!
    assert_permissions! %w[
      policy.read
    ]

    bearer.has_role?(:admin, :developer, :read_only, :sales_agent, :support_agent) ||
      policy.product == bearer
  end

  def create?
    assert_account_scoped!
    assert_permissions! %w[
      policy.create
    ]

    bearer.has_role?(:admin, :developer, :sales_agent) ||
      policy.product == bearer
  end

  def update?
    assert_account_scoped!
    assert_permissions! %w[
      policy.update
    ]

    bearer.has_role?(:admin, :developer, :sales_agent) ||
      policy.product == bearer
  end

  def destroy?
    assert_account_scoped!
    assert_permissions! %w[
      policy.delete
    ]

    bearer.has_role?(:admin, :developer) ||
      policy.product == bearer
  end

  def pop?
    assert_account_scoped!
    assert_permissions! %w[
      policy.pool.pop
    ]

    bearer.has_role?(:admin, :developer) ||
      policy.product == bearer
  end

  def attach_entitlement?
    assert_account_scoped!
    assert_permissions! %w[
      policy.entitlements.attach
    ]

    bearer.has_role?(:admin, :developer, :sales_agent) ||
      policy.product == bearer
  end

  def detach_entitlement?
    assert_account_scoped!
    assert_permissions! %w[
      policy.entitlements.detach
    ]

    bearer.has_role?(:admin, :developer, :sales_agent) ||
      policy.product == bearer
  end

  def list_entitlements?
    assert_account_scoped!
    assert_permissions! %w[
      policy.entitlements.read
    ]

    bearer.has_role?(:admin, :developer, :read_only, :sales_agent, :support_agent) ||
      policy.product == bearer
  end

  def show_entitlement?
    assert_account_scoped!
    assert_permissions! %w[
      policy.entitlements.read
    ]

    bearer.has_role?(:admin, :developer, :read_only, :sales_agent, :support_agent) ||
      policy.product == bearer
  end
end
