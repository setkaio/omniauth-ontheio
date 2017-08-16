require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Ontheio < OmniAuth::Strategies::OAuth2
      option :name, 'ontheio'

      option :authorize_options, [:redirect_uri, :state]

      option :client_options,
             site: 'https://onthe.io',
             authorize_url: '/auth',
             token_url: '/auth'

      option :projects_info_url, 'https://onthe.io/auth'

      option :auth_token_params, {
        mode: :query,
        param_name: 'access_token'
      }

      def callback_url
        options[:redirect_uri] || (full_host + script_name + callback_path)
      end

      uid { info['id'] }

      extra do
        { raw_info: raw_info }
      end

      info { raw_info }

      def raw_info
        projects_info = access_token.post(options[:projects_info_url]).parsed

        {
          'id' => projects_info['user_hash']
        }
      end
    end
  end
end
