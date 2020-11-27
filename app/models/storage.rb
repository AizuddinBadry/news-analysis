class Storage < ApplicationRecord
    has_one_attached :pdf
    has_one :pdf_attachment, dependent: :destroy
    has_one :pdf_blob, through: :pdf_attachment
end
