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

      option :auth_token_params, {
        mode: :query,
        param_name: 'access_token'
      }

      def callback_url
        options[:redirect_uri] || (full_host + script_name + callback_path)
      end

      uid { info['id'] }

      info { raw_info }

      def raw_info
        { 'id' => SecureRandom.random_number(10**21) }
      end
    end
  end
end
