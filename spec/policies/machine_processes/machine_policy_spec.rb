# frozen_string_literal: true

require 'rails_helper'
require 'spec_helper'

describe MachineProcesses::MachinePolicy, type: :policy do
  subject { described_class.new(record, account:, bearer:, token:, machine_process:) }

  with_role_authorization :admin do
    with_scenarios %i[accessing_a_machine_process accessing_its_machine] do
      with_token_authentication do
        with_permissions %w[machine.read] do
          without_token_permissions { denies :show }

          allows :show
        end

        with_wildcard_permissions do
          without_token_permissions { denies :show }

          allows :show
        end

        with_default_permissions do
          without_token_permissions { denies :show }

          allows :show
        end

        without_permissions do
          denies :show
        end
      end
    end

    with_scenarios %i[accessing_another_account accessing_a_machine_process accessing_its_machine] do
      with_token_authentication do
        with_permissions %w[machine.read] do
          denies :show
        end

        with_wildcard_permissions do
          denies :show
        end

        with_default_permissions do
          denies :show
        end

        without_permissions do
          denies :show
        end
      end
    end
  end

  with_role_authorization :product do
    with_scenarios %i[accessing_its_machine_process accessing_its_machine] do
      with_token_authentication do
        with_permissions %w[machine.read] do
          without_token_permissions { denies :show }

          allows :show
        end

        with_wildcard_permissions do
          without_token_permissions { denies :show }

          allows :show
        end

        with_default_permissions do
          without_token_permissions { denies :show }

          allows :show
        end

        without_permissions do
          denies :show
        end
      end
    end

    with_scenarios %i[accessing_a_machine_process accessing_its_machine] do
      with_token_authentication do
        with_permissions %w[machine.read] do
          denies :show
        end

        with_wildcard_permissions do
          denies :show
        end

        with_default_permissions do
          denies :show
        end

        without_permissions do
          denies :show
        end
      end
    end
  end

  with_role_authorization :license do
    with_scenarios %i[accessing_its_machine_process accessing_its_machine] do
      with_license_authentication do
        with_permissions %w[machine.read] do
          allows :show
        end

        with_wildcard_permissions do
          allows :show
        end

        with_default_permissions do
          allows :show
        end

        without_permissions do
          denies :show
        end
      end

      with_token_authentication do
        with_permissions %w[machine.read] do
          without_token_permissions { denies :show }

          allows :show
        end

        with_wildcard_permissions do
          without_token_permissions { denies :show }

          allows :show
        end

        with_default_permissions do
          without_token_permissions { denies :show }

          allows :show
        end

        without_permissions do
          denies :show
        end
      end
    end

    with_scenarios %i[accessing_a_machine_process accessing_its_machine] do
      with_license_authentication do
        with_permissions %w[machine.read] do
          denies :show
        end

        with_wildcard_permissions do
          denies :show
        end

        with_default_permissions do
          denies :show
        end

        without_permissions do
          denies :show
        end
      end

      with_token_authentication do
        with_permissions %w[machine.read] do
          denies :show
        end

        with_wildcard_permissions do
          denies :show
        end

        with_default_permissions do
          denies :show
        end

        without_permissions do
          denies :show
        end
      end
    end
  end

  with_role_authorization :user do
    with_bearer_trait :with_licenses do
      with_scenarios %i[accessing_its_machine_process accessing_its_machine] do
        with_token_authentication do
          with_permissions %w[machine.read] do
            without_token_permissions { denies :show }

            allows :show
          end

          with_wildcard_permissions do
            without_token_permissions { denies :show }

            allows :show
          end

          with_default_permissions do
            without_token_permissions { denies :show }

            allows :show
          end

          without_permissions do
            denies :show
          end
        end
      end
    end

    with_scenarios %i[accessing_a_machine_process accessing_its_machine] do
      with_token_authentication do
        with_permissions %w[machine.read] do
          denies :show
        end

        with_wildcard_permissions do
          denies :show
        end

        with_default_permissions do
          denies :show
        end

        without_permissions do
          denies :show
        end
      end
    end
  end

  without_authorization do
    with_scenarios %i[accessing_a_machine_process accessing_its_machine] do
      without_authentication do
        denies :show
      end
    end
  end
end
