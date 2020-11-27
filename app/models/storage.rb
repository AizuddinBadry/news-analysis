class Storage < ApplicationRecord
    has_one_attached :pdf

    def scraped?
        scraped
    end
end
