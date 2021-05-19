module Serializers::AppConfig::Initial
    class << self
      def hash(user)
        {
          app_config: {
            language: AppConfig::DEFAULTS.dig(:LANGUAGE),
          },
          my_profile: Serializers::Profile::Show.hash(user)
        }.compact
      end
    end
  end