module SourceEnums
    extend ActiveSupport::Concern
  
    included do
        enum source: {
            'file': 0,
            'url': 1
        }
    end
end