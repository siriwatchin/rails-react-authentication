require 'api_constraints'

Rails.application.routes.draw do
  root to: 'homes#index'

  scope module: :api, defaults: { format: :json }, path: 'api' do
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
      use_doorkeeper do
        # No need to register client application
        controllers tokens: 'oauth/tokens',
                    token_info: 'oauth/token_info'
        skip_controllers :applications, :authorized_applications, :authorizations
      end
    end
  end
end
