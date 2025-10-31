# frozen_string_literal: true

# Rails 8.1 では `resource` にハッシュを渡すと非推奨警告が発生するため、
# Devise のルーティング用メソッドを keyword arguments 経由の呼び出しに差し替える。
module DeviseRoutesKeywordArgs
  def devise_session(mapping, controllers)
    options = {
      only: [],
      controller: controllers[:sessions],
      path: ""
    }

    resource :session, **options do
      get :new, path: mapping.path_names[:sign_in], as: "new"
      post :create, path: mapping.path_names[:sign_in]
      match :destroy, path: mapping.path_names[:sign_out], as: "destroy", via: mapping.sign_out_via
    end
  end

  def devise_password(mapping, controllers)
    options = {
      only: %i[new create edit update],
      path: mapping.path_names[:password],
      controller: controllers[:passwords]
    }

    resource :password, **options
  end

  def devise_confirmation(mapping, controllers)
    options = {
      only: %i[new create show],
      path: mapping.path_names[:confirmation],
      controller: controllers[:confirmations]
    }

    resource :confirmation, **options
  end

  def devise_unlock(mapping, controllers)
    return unless mapping.to.unlock_strategy_enabled?(:email)

    options = {
      only: %i[new create show],
      path: mapping.path_names[:unlock],
      controller: controllers[:unlocks]
    }

    resource :unlock, **options
  end

  def devise_registration(mapping, controllers) # rubocop:disable Metrics/MethodLength
    path_names = {
      new: mapping.path_names[:sign_up],
      edit: mapping.path_names[:edit],
      cancel: mapping.path_names[:cancel]
    }

    options = {
      only: %i[new create edit update destroy],
      path: mapping.path_names[:registration],
      path_names: path_names,
      controller: controllers[:registrations]
    }

    resource :registration, **options do
      get :cancel
    end
  end
end

ActionDispatch::Routing::Mapper.prepend DeviseRoutesKeywordArgs
