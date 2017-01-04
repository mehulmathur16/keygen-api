module Roleable
  extend ActiveSupport::Concern

  def grant(name)
    if role.present?
      self.role.update name: name
    else
      self.role = Role.create name: name
    end
  rescue ActiveRecord::RecordNotSaved
    self.role = Role.new name: name
  end

  def revoke(name)
    role.destroy if role.name == name.to_s
  end

  def role?(name)
    role.name == name.to_s
  end
end
