class Scrape < ApplicationRecord
    include SourceEnums
    serialize :categories
end
