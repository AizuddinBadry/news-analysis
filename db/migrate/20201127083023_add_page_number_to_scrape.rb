class AddPageNumberToScrape < ActiveRecord::Migration[6.0]
  def change
    add_column :scrapes, :page_number, :bigint
  end
end
