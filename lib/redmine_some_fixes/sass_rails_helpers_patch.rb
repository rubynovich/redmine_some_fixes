module RedmineSomeFixes
  module SassRailsHelpersPatch
    extend ActiveSupport::Concern
    def asset_plugin_data_url(path)
      raise __FILE__.inspect
      data = context_asset_data_uri(path.value)
      Sass::Script::String.new(%Q{url(#{data})})
    end
  end
end